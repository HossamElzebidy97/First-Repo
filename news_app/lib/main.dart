import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/newsLayout.dart';
import 'package:news_app/shared/Cubit/cubit.dart';
import 'package:news_app/shared/Cubit/states.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/Cashehelper.dart';
import 'package:news_app/shared/network/remote/dioHelper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'Dark');
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool? isDark;
  MyApp({required this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness()..getScience()..getSport(),
        ),
        BlocProvider(
          create:
              (BuildContext context) => AppCubit()
            ..changeAppMode(fromShared: isDark),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit=BlocProvider.of(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit().get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

