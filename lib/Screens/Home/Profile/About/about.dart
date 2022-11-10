import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Profile/About/privacy_cookies.dart';
import 'package:trip_planner/Screens/Home/Profile/About/terms_of_use.dart';
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
                  title: Text('Privacy Policy'),
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => PrivacyPolicy()));
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TermsOfUse()));
              },
            ),
          ),

        ],
      ),
    );
  }
}
