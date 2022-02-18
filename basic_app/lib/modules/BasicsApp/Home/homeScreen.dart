import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          size: 14,
        ),
        title: Text(
          'Hello Again',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(
            Icons.youtube_searched_for,
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              print('You Clicked ');
            },
            icon: Icon(Icons.accessibility_sharp),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg'),
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:  )),
                    //   padding: EdgeInsets.symmetric(vertical: 40),
                    color: Colors.black.withOpacity(.5),
                    width: 200,
                    child: Text(
                      'flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
