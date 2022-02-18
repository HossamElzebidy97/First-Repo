
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/ShopApp/Search/SearchScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (context,state){
      ShopCubit cubit=BlocProvider.of(context);
      return Scaffold(
        appBar: AppBar(
          title:Text('Salla') ,
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: (){
              signOut(context);
            }, icon: Icon(Icons.arrow_back_ios_sharp))
          ],
        ),
        body:cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottom(index);
          },
        ),
      );
    }, listener: (context,state){});
  }
}
