
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/layout/Cubit/cubit.dart';
import 'package:todo_app/layout/Cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit=BlocProvider.of(context);
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return  taskBuilder(tasks: cubit.archiveTasks);
        }, listener: (context,state){});
  }
}
