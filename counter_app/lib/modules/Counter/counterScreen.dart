
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/cubit.dart';
import 'Cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


      return BlocProvider(
        create:(context)=>CounterCubit() ,
        child: BlocConsumer<CounterCubit,CounterStates>(
          builder: (BuildContext context, state) {

            CounterCubit cubit=CounterCubit().get(context);

            return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        cubit.minus();
                        print('Counter decreased');
                      },
                      child: Text(
                        'MINUS',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      '${cubit.counter}',
                      style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                       cubit.plus();
                        print('Counter Increased');
                      },
                      child: Text(
                        'PLUS',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ); },
          listener: (BuildContext context,  state) {
            // if(state is CounterMinusState){
            //   print('Minus State');
            // }
            // if(state is CounterPlusState){
            //   print('Plus State');
            // }
          },),
      );

  }

}


