import 'package:flutter/material.dart';

import '../../../../constants.dart';

class GetHelp extends StatelessWidget {
  const GetHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy'),
        backgroundColor: kPrimaryColor,),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,

          children:<Widget> [
            SizedBox(height: 24,),
            Container(
             margin: EdgeInsets.only(left: 20),
              child: Text('How do I add new Trips/ Tours?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
            ),
            SizedBox(height: 18,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 8),
              child: Text('When you log in, you will see "Trips" page and there on the bottom you can see a circular button.'
                  ' Press the button and you will be able to add new trip along with the given attributes',
                style:TextStyle(height: 1.5),
                textAlign: TextAlign.left,),
            ),
            SizedBox(height: 21,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('How to add tour plans?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
            ),
            SizedBox(height: 18,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 8),
              child: Text('After creating a trip, you can see it on "Trips" and it contains an forward arrow icon. Tap there and you will go to on "Plans" page'
                  '.There is a circular add button. Pressing the button you can add the plans.',
                style:TextStyle(height: 1.5),
                textAlign: TextAlign.left,),
            ),
            SizedBox(height: 21,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('Why the profile picture is not uploading?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
            ),
            SizedBox(height: 18,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 8),
              child: Text('Make sure you have selected the picture and have a stable internet connection.'
                  ' If doesnot work properly afterwords, report the problem as this might be an internal issue.',
                style:TextStyle(height: 1.5),
                textAlign: TextAlign.left,),
            ),
          ]
      ) ,
    );
  }
}
