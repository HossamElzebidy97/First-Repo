
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/modules/ShopApp/Register/ShopRegisterScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/Cashehelper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>ShopLoginCubit(),
    child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state){
        if(state is ShopLoginSuccessState){
          if(state.loginModel.status==true){
          showToast(text:state.loginModel.message??'error' , state: ToastStates.SUCCESS);
            //CacheHelper.saveString(key: 'token', value: state.loginModel.data!.token.toString());
            CacheHelper.saveData(
                key: 'Token',
                value: state.loginModel.data!.token).then((value) {
                  token= state.loginModel.data!.token!;
              navigateAndFinish(context, ShopLayout());
            });
           // print(state.loginModel.data!.token.toString());
          //print(state.loginModel.message);
           }
          else if(state.loginModel.status==false)
            {
            // print(state.loginModel.message);
            // print(state.loginModel.data!.token);
              showToast(
                  text:  state.loginModel.message??'error',
                  state: ToastStates.WARNING);
          }
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black
                        ),),
                        Text('login now to browse our hot offers',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                        ),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email,
                            label: 'Email Address',
                            validate: (value){
                              if(value!.isEmpty){
                                return 'Email must not be empty';
                              }
                            }),
                        SizedBox(height: 15,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          suffixPressed: (){
                            ShopLoginCubit().get(context).changePasswordVisibility();
                          },
                          suffix:ShopLoginCubit().get(context).passIcon,
                          isPassword: ShopLoginCubit().get(context).isPassword,
                          label: 'Password',
                          validate: (value){
                            if(value!.isEmpty){
                              return 'Password must not be empty';
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        BuildCondition(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(text: 'login', function: (){
                            if(formKey.currentState!.validate()){
                            ShopLoginCubit().get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text
                            );
                          }}),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',style: TextStyle(fontSize: 20),),
                            defaultTextButton(function: (){
                              navigateTo(context, ShopRegisterScreen());
                            }, text: 'Register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
        );
      },
    ),

    );
  }
}
