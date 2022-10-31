import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/Profile/about.dart';
import 'package:trip_planner/Screens/Home/Profile/help.dart';
import 'package:trip_planner/Screens/Home/Profile/setting.dart';
import 'package:trip_planner/Screens/Welcome/welcome_screen.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  File? image;
  Future pickImage( ) async{

    final photo = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if(photo == null) return;
    File imageTemporary = File(photo.path);
    //imageTemporary = await imageTemporary.copy(imageTemporary.path);

    setState(() {
      image =imageTemporary;
    });
  }
  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: <Widget>[
          Text("Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.camera_alt_outlined,),
                label: Text('Camera'),

              ),
              SizedBox(width: 55,),
              TextButton.icon(
                onPressed: (){
                  pickImage();
                },
                icon: Icon(Icons.photo_library,),
                label: Text('Gallery'),

              )
            ],
          )
        ],
      ),
    );
  }
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
              child: Center(child: Stack(
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
              )),
            ),
          ),
          Divider(height: 5,),
         // setting
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset("assets/images/cogwheel.png",height: 36.5,),
                  title: Text('Setting'),
                ),
                elevation: 3,
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Settings()));
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
                  leading: Image.asset("assets/images/question.png",height: 38,),
                  title: Text('Help'),
                ),
                elevation: 3,
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Help()));
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
                  leading: Image.asset("assets/images/about.png",height: 40,),
                  title: Text('About'),
                ),
                elevation: 3,
              ),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => About()));
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
                  leading: Image.asset("assets/images/logout.png",height: 39,),
                    title: Text('Log Out')),

                elevation: 3,
              ),
              onTap: ()  async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => WelcomeScreen()));
              },
            ),
          ),
        ],
      ),

    );

  }
}