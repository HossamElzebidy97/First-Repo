import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/Cubit/cubit.dart';
import 'package:shop_app/shared/Cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/Cashehelper.dart';
import 'package:shop_app/shared/network/remote/dioHelper.dart';
import 'package:shop_app/shared/styles/Themes.dart';

import 'layout/ShopLayout.dart';
import 'layout/cubit/cubit.dart';
import 'modules/ShopApp/Login/ShopLoginScreen.dart';
import 'modules/ShopApp/OnBoarding/onBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token=CacheHelper.getData(key: 'Token')??'null';
   if(onBoarding==true){

     if(token==CacheHelper.getData(key: 'Token')) {
       widget=ShopLayout();
     }
     else {
       widget=ShopLoginScreen();
     }
   }
   else{
     widget=OnBoardingScreen();
   }

  runApp(MyApp(isDark: isDark,startWidget: widget,));
}
class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
  MyApp({required this.startWidget,required this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create:
              (BuildContext context) => AppCubit()
            ..changeAppMode(),),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit=BlocProvider.of(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:AppCubit().get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
