import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy'),
      backgroundColor: kPrimaryColor,),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('What is Privacy Policy and What is covered?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
          ),
          SizedBox(height: 18,),
          Container(
            margin: EdgeInsets.only(left: 20,right: 8),
            child: Text('We want you to read our Privacy Policy well. It will ensure proper service of the product.\n'
                'Here, we explain how we collect data and use them and let you know the rights',textAlign: TextAlign.left,
            maxLines: null,
            softWrap: true,
            style: TextStyle(
              height: 2,fontSize: 16
            ),),
          ),
    ]
      ) ,
    );
  }
}
