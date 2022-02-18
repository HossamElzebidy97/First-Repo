
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/NewsApp/search/searchScreen.dart';
import 'package:news_app/shared/Cubit/cubit.dart';
import 'package:news_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return
    BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        NewsCubit cubit=NewsCubit().get(context);

        return  Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search),),
              IconButton(onPressed: (){
                AppCubit().get(context).changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined),),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,

          ),
          body:cubit.screens[cubit.currentIndex] ,
        );
      },
    );
  }

}