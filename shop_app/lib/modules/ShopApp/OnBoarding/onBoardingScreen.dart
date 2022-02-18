
import 'package:flutter/material.dart';
import 'package:shop_app/modules/ShopApp/Login/ShopLoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/Cashehelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 List<BoardingModel> boarding=[
   BoardingModel('assets/OnBoarding1.png', 'OnBoard1Title', 'OnBoard1Body'),
   BoardingModel('assets/OnBoarding1.png', 'OnBoard2Title', 'OnBoard2Body'),
   BoardingModel('assets/OnBoarding1.png', 'OnBoard3Title', 'OnBoard3Body'),
 ];

 void submit(){
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
     navigateAndFinish(context, ShopLoginScreen());
   });
 }

 var boardController=PageController();
 bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP'))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              onPageChanged: (index){
                setState(() {
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                      print('last');
                    });
                  }
                  else{
                    setState(() {
                      isLast=false;
                      print('not last');

                    });
                  }
                });
              },
              controller: boardController,
              itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
              physics: BouncingScrollPhysics(),
              itemCount: 3,
            ),),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect:ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5
                  )
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                  submit();
                  }else{
                    boardController.nextPage(duration: Duration(
                        milliseconds: 600
                    ), curve:Curves.fastLinearToSlowEaseIn,);
                  }
                },
                child: Icon(Icons.arrow_forward_ios_rounded),),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'),
          height: 300,
          width: 300,
        ),),
        SizedBox(
          height: 30,
        ),
        Text('${model.title}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        Text('${model.body}',style: TextStyle(fontSize:20,fontWeight: FontWeight.w300),),
      ],
    );
}
