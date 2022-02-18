import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  bool isMale;
  double result;
  int age;

  BMIResultScreen(
      {required this.isMale, required this.result, required this.age});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender: ${isMale ? 'Male' : 'FeMale'}',
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
            ),
            Text(
              'Result:${result.round()}',
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age:$age',
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
