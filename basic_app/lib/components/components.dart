import 'package:flutter/material.dart';

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
