import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/Shop/ShopCategoriesModel.dart';
import 'package:shop_app/models/Shop/ShopHomeModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  Color? backColor;
  CarouselController carouselController=CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(state.model.status==false){
            showToast(text: state.model.message??'', state: ToastStates.ERROR);
          }
        }
      },
      builder: (context,state){
        ShopCubit cubit=BlocProvider.of(context);
        return BuildCondition(
          condition: cubit.homeModel!=null&&cubit.categoriesModel!=null,
          builder:(context)=> productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SingleChildScrollView(
            child: CarouselSlider(
              carouselController: carouselController,
                items:model!.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width:double.infinity,
              // fit: BoxFit.cover,
            )).toList(),
                options: CarouselOptions(height: 250, initialPage: 0, enableInfiniteScroll: true, viewportFraction: 1, reverse: false, autoPlay: true, autoPlayInterval: Duration(seconds: 3), autoPlayAnimationDuration: Duration(seconds: 1), autoPlayCurve: Curves.fastLinearToSlowEaseIn, scrollDirection: Axis.horizontal,pauseAutoPlayInFiniteScroll: true)),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 110,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10,),
                      itemCount: categoriesModel!.data!.data.length
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[400],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1/1.65,
              children: List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context),),

            ),
          ),
        ],
      ),
    );
  }
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image??''),
        width: 140,
        height:120 ,
      ),
      Container(
        color: Colors.black.withOpacity(.6),
        width: 140,
        child: Text(model.name??'',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel? model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            if(model.discount!=0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
              child: Text('DISCOUNT',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 14
                ),
              ),
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: TextStyle(
                        height: 1.3,
                        color: defaultColor,
                        fontSize: 14
                    ),
                  ),
                  SizedBox(width: 10,),
                  if(model.discount!=0)
                  Text('${model.oldPrice.round()}',
                    style: TextStyle(
                        height: 1.3,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 14
                    ),
                  ),
                  Spacer(),
                 IconButton(
                   onPressed: (){
                     ShopCubit.get(context).changeFavorites(model.id??2);
                     print(model.id);
                   },
                   icon: CircleAvatar(
                       radius: 15,
                       backgroundColor:(ShopCubit.get(context).favorites[model.id]??true)?defaultColor:Colors.grey,
                       child: Icon(Icons.favorite_border,size: 20,color: Colors.white,)),
                 )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
