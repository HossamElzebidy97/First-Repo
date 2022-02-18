
import 'package:basic_app/modules/BasicsApp/Login/loginScreen.dart';
import 'package:basic_app/modules/BasicsApp/Users/usersScreen.dart';
import 'package:flutter/material.dart';

import 'modules/BasicsApp/Massenger/massengerScreenListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersScreen(),
    );
  }
}

