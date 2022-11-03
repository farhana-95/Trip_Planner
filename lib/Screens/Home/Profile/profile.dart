import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/Profile/about.dart';
import 'package:trip_planner/Screens/Home/Profile/help.dart';
import 'package:trip_planner/Screens/Home/Profile/personal_informations.dart';
import 'package:trip_planner/Screens/Home/Profile/setting.dart';
import 'package:trip_planner/Screens/Home/Profile/user_image.dart';
import 'package:trip_planner/Screens/Welcome/welcome_screen.dart';

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
              child: Center(
                child: UserImage(),
                /*Stack(
                children: <Widget>[
                  CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  backgroundImage: image != null? FileImage(File(image!.path)): null,
                  radius: 60,
                ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: InkWell(
                        child: Icon(Icons.camera_alt),
                      onTap: (){
                          showModalBottomSheet(context: context,
                              builder: ((builder)=> bottomSheet()));
                      },
                    ),
                  )
                ]
              )*/
              ),
            ),
          ),
          Divider(
            height: 5,
          ),
          //personal info
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/user.png",
                    height: 36.5,
                  ),
                  title: Text('Personal Info'),
                ),
                elevation: 3,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PersonalInfo()));
              },
            ),
          ),
          // setting
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/cogwheel.png",
                    height: 36.5,
                  ),
                  title: Text('Setting'),
                ),
                elevation: 3,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ),
          // help,
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/question.png",
                    height: 38,
                  ),
                  title: Text('Help'),
                ),
                elevation: 3,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Help()));
              },
            ),
          ),
          //Divider(height: 5,),
          //about
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/about.png",
                    height: 40,
                  ),
                  title: Text('About'),
                ),
                elevation: 3,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => About()));
              },
            ),
          ),
          //logout
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                    leading: Image.asset(
                      "assets/images/logout.png",
                      height: 39,
                    ),
                    title: Text('Log Out')),
                elevation: 3,
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => WelcomeScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
