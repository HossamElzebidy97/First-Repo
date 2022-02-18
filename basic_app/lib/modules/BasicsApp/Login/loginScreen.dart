import 'dart:ui';

import 'package:basic_app/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'login App',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.amber),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    prefix: Icons.email_outlined,
                    label: 'Email',
                    onchange: (value) {
                      print(value);
                    },
                    onSubmit: (value) {
                      print(value);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return ('email must not be empty');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                    label: 'MyPassword',
                    isPassword: isPassword,
                    onchange: (value) {
                      print(value);
                    },
                    onSubmit: (value) {
                      print(value);
                    },
                    validate: (value) {
                      if (value!.isEmpty) {
                        return ('password must not be empty');
                      }
                    },
                    suffix:
                        isPassword ? Icons.visibility_off : Icons.visibility,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                defaultButton(
                  text: 'Login',
                  isUpperCase: true,
                  raduis: 20,
                  width: 200,
                  color: Colors.brown,
                  function: () {
                    if (formKey.currentState!.validate()) {
                      print(emailController.text);
                      print(passwordController.text);
                    }
                  },
                ),
                MaterialButton(
                  child: Text('Login'),
                  color: Colors.amber,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print(emailController.text);
                      print(passwordController.text);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.end,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Register Now',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
