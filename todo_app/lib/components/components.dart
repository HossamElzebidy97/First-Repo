import 'package:flutter/material.dart';
import 'package:todo_app/layout/Cubit/cubit.dart';

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
Widget taskBuilder({required List<Map> tasks}){
  return tasks.length>0?ListView.separated(itemBuilder: (context,index)=>buildTaskItem(tasks[index],context), separatorBuilder: (context,index)=>myDivider(), itemCount: tasks.length)
      :Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,color: Colors.green,size: 100,),
        Text('No Tasks Yet Please add some',style: TextStyle(color: Colors.blueGrey,fontSize: 22,fontWeight: FontWeight.w600),)
      ],
    ),
  );
}
Widget buildTaskItem(Map model,context){
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction){
      AppCubit().get(context).deleteFromDatabase(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['date']}'),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Text('${model['title']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                Text('${model['time']}',style: TextStyle(color:Colors.grey,fontSize: 15,fontWeight: FontWeight.normal),),
              ],
            ),
          ),
          IconButton(onPressed: (){
            AppCubit().get(context).updateDatabase(status: 'done', id: model['id']);
          },
            icon: Icon(Icons.check_box),
            color: Colors.green,),
          IconButton(
            color:Colors.grey,onPressed: (){
            AppCubit().get(context).updateDatabase(status: 'archive', id: model['id']);
          },
            icon: Icon(Icons.archive_outlined),),
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
