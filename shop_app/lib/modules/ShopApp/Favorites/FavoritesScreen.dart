import 'package:buildcondition/buildcondition.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          return BuildCondition(
            condition: state is! ShopLoadingGetFavoritesState ,
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product,context),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context,state){});
  }
}
