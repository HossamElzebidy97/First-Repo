


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/layout/Cubit/cubit.dart';
import 'package:todo_app/layout/Cubit/states.dart';

class Homelayout extends StatelessWidget {



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();






  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>AppCubit()..createDatabase(),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is AppInsertToDatabaseState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){

        AppCubit cubit =BlocProvider.of(context);

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.yellow,
            onTap: (index) {
            cubit.changeNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                title: Text('Tasks'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                title: Text('Done'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                title: Text('Archived'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(title: titleController.text, date: dateController.text, time: timeController.text);
                    // Navigator.pop(context);
                    //    isBottomsheetShown = false;
                    //    setState(() {
                    //      fabIcon = Icons.edit;
                    //    });
                    // insertToDatabase(
                    //     date: dateController.text,
                    //     time: timeController.text,
                    //     title: titleController.text)
                    //     .then((value) {
                    //   getFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomsheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //
                    //     //   tasks=value;
                    //     //   print(tasks);
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.name,
                                  prefix: Icons.title,
                                  label: 'task Title',
                                  validate: (value) {
                                    print(value);
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                prefix: Icons.access_time,
                                label: 'task Time',
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'time must not be empty';
                                  }
                                },
                                ontap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: dateController,
                                type: TextInputType.datetime,
                                prefix: Icons.calendar_today,
                                label: 'task Date',
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'date must not be empty';
                                  }
                                },
                                ontap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-12-19'))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMMd().format(value!);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )).closed.then((value) {
                    cubit.changeBottomSheet(isShown: false, icon: Icons.edit);


                  });
                  cubit.changeBottomSheet(isShown: true, icon: Icons.add);

                }
              }
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    ),);
}





  // void insertToDatabase()  {
  //     database!.transaction((txn)  {
  //     return txn
  //         .rawInsert(
  //         'INSERT INTO Tasks2 (title,date,time,status) VALUES("first item","3455","7589","new")')
  //         .then((value) {
  //       print('$value inserted successfully');
  //     }).catchError((error) {
  //       print('Error when inserting records ${error.toString()}');
  //     });
  //   });
  // }


  // Future<String> getName() async {
  //   return ('Ahmed Ali');
  // }
}
