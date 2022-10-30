import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Profile/profile_navigation.dart';
import 'package:trip_planner/constants.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 210,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              color: kPrimaryLightColor,
              child: Center(child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 60,
              )),
            ),
          ),
          Divider(height: 5,),
          //SizedBox(height: 5,),
         // Divider(height: 5,),
          Container(
            height: 80,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Center(child: Text('Setting')),
              elevation: 3,
            ),
          ),
         // Divider(height: 5,),
          Container(
            height: 80,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Center(child: Text('Help')),
              elevation: 3,
            ),
          ),
          //Divider(height: 5,),
          Container(
            height: 80,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Center(child: Text('About')),
              elevation: 3,
            ),
          ),
          Container(
            height: 80,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                  title: Text('Log Out')),
              elevation: 3,
            ),
          ),
        ],
      )
    );
  }
}