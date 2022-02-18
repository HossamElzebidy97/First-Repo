
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Shop/ShopLoginModel.dart';
import 'package:shop_app/modules/ShopApp/Login/cubit/states.dart';
import 'package:shop_app/shared/network/endPoints.dart';
import 'package:shop_app/shared/network/remote/dioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());

  UserData? data;
  ShopLoginModel? loginModel;

  ShopLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
      'email':email,
      'password':password,
    }).then((value) {
      //print(value.data);
       //data =(value.data['data']);
      loginModel=  ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.message);
      // Map<String,dynamic> de=loginModel!.data as Map<String, dynamic>;
       print(loginModel!.message);
      // print(data);
       //print(value.data['data']['id']);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool isPassword=true;
  IconData passIcon=Icons.visibility_off_rounded;

  void changePasswordVisibility(){
    isPassword=!isPassword;
    passIcon=isPassword?Icons.visibility:Icons.visibility_off_rounded;
  emit(ShopChangePasswordVisibilityState());

  }

}