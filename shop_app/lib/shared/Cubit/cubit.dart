
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/Cubit/states.dart';
import 'package:shop_app/shared/network/local/Cashehelper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

  AppCubit get(context)=>BlocProvider.of(context);





  bool isDark=true;
  void changeAppMode(){
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }

  }