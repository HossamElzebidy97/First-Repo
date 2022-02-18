
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/Shop/ShopCategoriesModel.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          return ListView.separated(
              itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
        listener: (context,state){});
  }
  Widget buildCatItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(model.image??""),
            width: 120,
            height:120 ,
            fit: BoxFit.cover,
          ),
           SizedBox(width: 10,),
           Text(model.name!.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
