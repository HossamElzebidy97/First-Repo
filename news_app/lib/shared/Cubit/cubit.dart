
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/Cubit/states.dart';
import 'package:news_app/shared/network/local/Cashehelper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  AppCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark=fromShared;
      emit(ChangeAppModeState());
    }else{
      isDark=!isDark;
      CacheHelper.saveData(key: 'Dark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
    }

  }