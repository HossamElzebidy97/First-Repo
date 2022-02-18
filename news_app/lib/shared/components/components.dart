import 'package:flutter/material.dart';
import 'package:news_app/modules/NewsApp/webview/webviewScreen.dart';

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
    // onFieldSubmitted: (s) {
    //   onSubmit!(s);
    // },
     onChanged: (s) {
       onchange!(s);
     },
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

Widget buildArticleItem(article,context){
  return InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen('${article['url']}'));
    },
    child: Padding(
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