import 'package:flutter/material.dart';

class MassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34492145?v=4'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Chats',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            )
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.camera_alt_outlined),
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Text('Serach'),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 90,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStoryItem(),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 17,
                ),
                itemCount: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() {
    return Container(
      width: 65,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/34492145?v=4'),
              ),
              CircleAvatar(
                radius: 6,
              ),
            ],
          ),
          Text(
            'Ahmed Ali Hossam Ahmed Hossam Ali',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildChatItem() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34492145?v=4'),
            ),
            CircleAvatar(
              radius: 6,
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Ahmed Ali Hossam Ali Hossam Ahmed Ali  ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'This My First message To you My friend i miss you alot so have agood day ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('02:00 Pm')
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
