
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = true,
  double raduis = 10.0,
  required String text,
  required Function() function,
}) {
  return MaterialButton(
    onPressed: function,
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: color,
      ),
      width: width,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(height: 2, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
Widget defaultTextButton({required Function() function,required String text}){
  return TextButton(onPressed:function, child: Text(text.toUpperCase()));
}
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  //void  Function(dynamic? value)? onSubmitt,
  void Function(dynamic? value)? onchange,
  Function()? ontap,
  bool isPassword = false,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  required String label,
  required String? Function(String? val)? validate,
  void Function(String text)? onSubmit,
}) {
  return TextFormField(
    onTap: ontap,
    validator: (value) {
      return validate!(value);
    },
    obscureText: isPassword,
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: (s) {
      onSubmit!(s);
    },
    // onChanged: (s) {
    //   onchange!(s);
    // },
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      labelText: label,
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildArticleItem(article,context){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:NetworkImage('${article['urlToImage']}'), ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text('${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,),),
                Text('${article['publishedAt']}'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Widget myDivider(){
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey,
  );
}
Widget articleBuilder(context,{required list,isSearch=false}){
  return list.length>0?
  ListView.separated(
      physics:BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: 10):isSearch?Container():Center(child: CircularProgressIndicator());
}
void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget));
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) => widget), (Route<dynamic> route) => false);
void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16
);
enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color? color;
  switch(state){
      case ToastStates.SUCCESS:
      color= Colors.green;
      break;
      case ToastStates.ERROR:
      color= Colors.red;
      break;
      case ToastStates.WARNING:
      color= Colors.yellow;
      break;

  }
  return color;
}
Widget buildListProduct(model,context,{bool isOldPrice=true}){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.image??''),
                    height: 120,
                    width: 120,
                  ),
                  if(model.discount!=0&&isOldPrice)
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
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.3,
                        fontSize: 14
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(model.price.toString(),
                        style: TextStyle(
                            height: 1.3,
                            color: defaultColor,
                            fontSize: 14
                        ),
                      ),
                      SizedBox(width: 10,),
                      if(model.discount!=0&&isOldPrice)
                        Text(model.oldPrice.toString(),
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
                          // print(model.id);
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
      ),
    );
  }