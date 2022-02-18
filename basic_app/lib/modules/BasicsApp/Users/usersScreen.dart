
import 'package:basic_app/models/userModel.dart';
import 'package:flutter/material.dart';




class UsersScreen extends StatelessWidget {
  List<UserModel> Users = [
    UserModel(id: 1, name: 'Hossam Ahmed', phone: '0109863417'),
    UserModel(id: 2, name: 'Ali Ahmed', phone: '0109675417'),
    UserModel(id: 3, name: 'Ahmed Ahmed', phone: '01087963417'),
    UserModel(id: 4, name: 'Mohamed Ahmed', phone: '0109983417'),
    UserModel(id: 5, name: 'Raouf Ahmed', phone: '0109869017'),
    UserModel(id: 6, name: 'Ibrahim Ahmed', phone: '01095683417'),
    UserModel(id: 1, name: 'Hossam Ahmed', phone: '0109863417'),
    UserModel(id: 2, name: 'Ali Ahmed', phone: '0109675417'),
    UserModel(id: 3, name: 'Ahmed Ahmed', phone: '01087963417'),
    UserModel(id: 4, name: 'Mohamed Ahmed', phone: '0109983417'),
    UserModel(id: 5, name: 'Raouf Ahmed', phone: '0109869017'),
    UserModel(id: 6, name: 'Ibrahim Ahmed', phone: '01095683417'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => buildUserItem(Users[index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
            itemCount: Users.length),
      ),
    );
  }

  Widget buildUserItem(UserModel user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          child: Text(
            '${user.id}',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${user.phone}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
