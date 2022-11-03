import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('About'),backgroundColor: kPrimaryColor,),
      body: ListView(
        children: <Widget>[
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  // leading: Image.asset(
                  //   "assets/images/about.png",
                  //   height: 40,
                  // ),
                  title: Text('About Trip Planner'),
                ),
              ),
              onTap: () {
              },
            ),
          ),
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  // leading: Image.asset(
                  //   "assets/images/about.png",
                  //   height: 40,
                  // ),
                  title: Text('Privacy & Cookies'),
                ),
              ),
              onTap: () {

              },
            ),
          ),
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  // leading: Image.asset(
                  //   "assets/images/about.png",
                  //   height: 40,
                  // ),
                  title: Text('Terms of Use'),
                ),
              ),
              onTap: () {

              },
            ),
          ),

        ],
      ),
    );
  }
}
