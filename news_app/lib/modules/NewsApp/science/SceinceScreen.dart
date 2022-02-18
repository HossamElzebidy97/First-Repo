
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit=BlocProvider.of(context);
    return BlocConsumer<NewsCubit,NewsStates>(builder: (context,state){
    return articleBuilder(context,list: cubit.science);
     }, listener: (context,state){});
  }
}