import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/Profile/About/about.dart';
import 'package:trip_planner/Screens/Home/Profile/Help/help.dart';
import 'package:trip_planner/Screens/Home/Profile/Personal_Info/personal_informations.dart';
import 'package:trip_planner/Screens/Home/Profile/Settings/setting.dart';
import 'package:trip_planner/Screens/Home/Profile/Personal_Info/user_image.dart';
import 'package:trip_planner/Screens/Home/Trips/trip_history.dart';
import 'package:trip_planner/Screens/Welcome/welcome_screen.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String  Id;
  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    //final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print(uid);
    // print(_userInfo);
    return uid;
  }


  TextEditingController comments = TextEditingController();
  late double count=0;

  @override
  void initState(){
    Id=getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
           Container(
            height: 214,
            width: 100,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  Center(
                    child: UserImage(),
                  ),
                  SizedBox(height: 13,),
                  Center(
                    child: Container(
                      child: StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.active) {
                            return const Center(
                                child: CircularProgressIndicator()); // 👈 user is loading
                          }
                          final user = snapshot.data;
                          final uid = user?.uid; // 👈 get the UID
                          if (user != null) {
                            print(user);
                            CollectionReference users =
                            FirebaseFirestore.instance.collection('users');

                            return FutureBuilder<DocumentSnapshot>(
                              future: users.doc(uid).get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }

                                if (snapshot.hasData && !snapshot.data!.exists) {
                                  return const Text("Document does not exist");
                                }

                                if (snapshot.connectionState == ConnectionState.done) {
                                  Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                                  return Text("${data['name']}",style: TextStyle(fontSize: 17),);
                                }

                                return const Text("loading");
                              },
                            );
                          } else {
                            return const Text("user is not logged in");
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 5,
          ),
          //personal info
          Container(
            margin: EdgeInsets.only(left: 15),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                leading:
                Image.asset(
                  "assets/images/img_6.png",
                  height: 22,
                  color: Colors.grey,
                ),
                title: Text('Personal Info'),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PersonalInfo()));
              },
            ),
          ),
          Divider(indent: 10,endIndent: 10,),
          Container(
            margin: EdgeInsets.only(left: 15),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                  leading: Image.asset(
                    "assets/images/history.png",
                    height: 23,
                    color: Colors.grey,
                  ),
                  title: Text('History')),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TripHistory()));
              },
            ),
          ),
          Divider(indent: 10,endIndent: 10,),
          // setting
          Container(
            margin: EdgeInsets.only(left: 15),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                leading: Image.asset(
                  "assets/images/img.png",
                  height: 23.5,color: Colors.grey,
                ),
                title: Text('Setting'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  Setting()));
              },
            ),
          ),
          Divider(indent: 10,endIndent: 10,),
          // help,
          Container(
            margin: EdgeInsets.only(left: 15),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                leading: Image.asset(
                  "assets/images/img_4.png",
                  height: 22.5,
                  color: Colors.grey,
                ),
                title: Text('Help'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Help()));
              },
            ),
          ),
          Divider(indent: 10,endIndent: 10,),
          //about
          Container(
            margin: EdgeInsets.only(left: 15),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                leading: Image.asset(
                  "assets/images/info.png",
                  height: 23,
                  color: Colors.grey,
                ),
                title: Text('About'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => About()));
              },
            ),
          ),
          // Divider(indent: 10,endIndent: 10,),
          // Container(
          //   margin: EdgeInsets.only(left: 15),
          //   height: 60,
          //   width: 100,
          //   child: GestureDetector(
          //     child: ListTile(
          //         leading: Image.asset(
          //           "assets/images/img_9.png",
          //           height: 23,
          //           color: Colors.grey,
          //         ),
          //         title: const Text('Rate this app')),
          //     onTap: () async {
          //         showDialog(context: context,
          //             builder: (BuildContext context)=>
          //                 AlertDialog(
          //                   title: const Text('Rate App'),
          //                   content: Wrap(
          //                     children: [
          //                       buildRating(),
          //                       SizedBox(height: 10),
          //                       Padding(padding: EdgeInsets.all(5),
          //                         child: TextFormField(
          //                           controller: comments,
          //                           textInputAction: TextInputAction.done,
          //                           decoration: const InputDecoration(
          //                             border: UnderlineInputBorder(),
          //                             labelText: 'Comments ',
          //                             labelStyle: TextStyle(
          //                               color: Colors.black,
          //                               //fontWeight: FontWeight.bold
          //                             ),
          //                             hintText: 'Add Comment',
          //                           ),
          //                         ),
          //
          //                       )
          //                     ],
          //                   ),
          //                   actions: [
          //                     TextButton(onPressed: ()=>Navigator.pop(context),
          //                         child: Text('Cancel')),
          //                     TextButton(onPressed: (){
          //                       //count = rate.text as double;
          //                       Map<String,dynamic> data={
          //                         'rate': count,
          //                         'comment': comments.text,
          //                       };
          //                       print("DB   $count");
          //                       _rating.add(data);
          //                       comments.text='';
          //                      Navigator.pop(context);
          //                     },
          //                         child: Text('Submit')),
          //                   ],
          //                 )
          //         );
          //     },
          //   ),
          // ),
          //logout
          Divider(indent: 10,endIndent: 10,),
          Container(
            margin: EdgeInsets.only(left: 19),
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                  leading: Image.asset(
                    "assets/images/img_5.png",
                    height: 23,
                    color: Colors.grey,
                  ),
                  title: const Text('Log Out')),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                // prefs.remove(key)
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
  // Widget buildRating()=>
  //     RatingBar.builder(
  //       initialRating: count,
  //       minRating: 1,
  //       direction: Axis.horizontal,
  //       allowHalfRating: true,
  //       itemCount: 5,
  //       itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
  //       itemBuilder: (BuildContext context, _)=>const Icon(
  //         Icons.star,
  //         color: Colors.amber,
  //       ),
  //       onRatingUpdate: (rating) {
  //         setState(() {
  //           count= rating;
  //         });
  //         print('rating:  $count');
  //       },updateOnDrag: true,
  //
  //     );
}
