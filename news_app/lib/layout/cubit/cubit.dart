
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/NewsApp/business/businessScreen.dart';
import 'package:news_app/modules/NewsApp/science/SceinceScreen.dart';
import 'package:news_app/modules/NewsApp/sports/sportScreen.dart';
import 'package:news_app/shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  NewsCubit get(context)=>BlocProvider.of(context);

  List<Widget> screens=[
    ScienceScreen(),
    SportScreen(),
    BusinessScreen()
  ];
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science',),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sport',),
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business',),
  ];

  int currentIndex=0;
  void changeBottomNavBar(index){
    currentIndex=index;
    // if(index==1)
    //   getSport();
    // if(index==2)
    //   getScience();
    emit(NewsChangeNavBarState());
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
     DioHelper.getData(url: 'v2/top-headlines', query:{
      'country':'eg',
      'category':'business',
      'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
    }
    ).then((value) {
      //print(value.data['articles']['0']);
      business=value.data['articles' ];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print('error is ${error.toString()}');
    });
  }

  List<dynamic> sports=[];

  void getSport(){
    if(sports.length==0){
      emit(NewsGetSportLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query:{
        'country':'eg',
        'category':'sport',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
      ).then((value) {
        //print(value.data['articles']['0']);
        sports=value.data['articles' ];
        emit(NewsGetSportSuccessState());
      }).catchError((error){
        emit(NewsGetSportErrorState(error.toString()));
        print('error is ${error.toString()}');
      });
    }else{
      emit(NewsGetSportSuccessState());
    }

  }

  List<dynamic> science=[];

  void getScience(){
    if(science.length==0){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query:{
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
      ).then((value) {
        //print(value.data['articles']['0']);
        science=value.data['articles' ];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString()));
        print('error is ${error.toString()}');
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }
  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}