import 'package:bloc/bloc.dart';
import 'package:counter_app/modules/Counter/Cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit(): super(CounterInitialState());

  CounterCubit get(context)=>BlocProvider.of(context);

  int counter=0;

  void minus(){
    counter--;
    emit(CounterMinusState());

  }
  void plus(){
    counter ++;
    emit(CounterPlusState());
  }


}