
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/Cubit/states.dart';
import 'package:todo_app/modules/TodoApp/ArchivedTasks/archivedtasks.dart';
import 'package:todo_app/modules/TodoApp/DoneTasks/doneTasks.dart';
import 'package:todo_app/modules/TodoApp/NewTasks/newTasks.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  AppCubit get(context)=>BlocProvider.of(context);



  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  Database? database;

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    required bool isShown,
    required IconData icon,
}){
    isBottomSheetShown=isShown;
    fabIcon=icon;
    emit(AppChangeBottomSheet());
  }

  int currentIndex = 0;

  void changeNavBar(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    // var directory=await getDatabasesPath();
    // String path=join(directory,'todo2.db');
   openDatabase('phone.db', version: 1,
        onCreate: (Database db, version) async{
          print('database created');
          await db
              .execute(
              'CREATE TABLE Task(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');

          }).catchError((error) {
            print('error when creating table ${error.toString()}');
          });
        }, onOpen: (database) {
          getFromDatabase(database);
          print('database opened');
        },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database!.transaction((txn)
    async{
      await txn
          .rawInsert(
        'INSERT INTO Task(title, date, time, status) VALUES("$title", "$time", "$date", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertToDatabaseState());
         getFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  // Future insertToDatabase({
  //   required String title,
  //   required String date,
  //   required String time,
  // })  async{
  //   return await database!.transaction((txn) async {
  //     await txn
  //         .rawInsert(
  //         'INSERT INTO Car(title,date,time,status) VALUES($title,$date,$time,"new")')
  //         .then((value) {
  //       print('$value inserted successfully');
  //       emit(AppInsertToDatabaseState());
  //
  //       // getFromDatabase(database).then((value) {
  //       //   tasks=value;
  //       //   print(tasks );
  //       //   emit(AppGetFromDatabaseState());
  //       // });
  //     }).catchError((error) {
  //       print('Error when inserting records ${error.toString()}');
  //     });
  //   });
  // }

 void getFromDatabase(database){

    newTasks=[];
    doneTasks=[];
    archiveTasks=[];



    emit(AppLoadingGetFromDatabaseState());
     database!.rawQuery('SELECT * FROM Task').then((value) {

       value.forEach((element) {
         if(element['status']=='new')
           newTasks.add(element);
        else if(element['status']=='done')
           doneTasks.add(element);
        else
           archiveTasks.add(element);
       });

       emit(AppGetFromDatabaseState());
     });
  }
  void updateDatabase({
    required String status,
    required int id
})async{
 return database!.rawUpdate('UPDATE Task SET status = ? WHERE id = ?',
    ['$status', '$id']).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDatabaseState());
  });
  }
  void deleteFromDatabase({required int id}){
    database!.rawDelete('DELETE FROM Task WHERE id=?',[id]).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }


  }