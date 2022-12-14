import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  late final CollectionReference _userInfo= FirebaseFirestore.instance.collection("users").doc("Usa01Yl0OMNXjBilot31rsqak603").get();
  //final users = FirebaseAuth.instance.currentUser;
  var userData =
      FirebaseFirestore.instance.collection("/userdata").doc("uid").get();

  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    // Similarly we can get email as well
    final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print(uid);
    // _userInfo;
    // print(_userInfo);
    return uemail;

  }

  @override
  Widget build(BuildContext context) {
    //getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Personal Informations'),
      ),
      body: ListView(children: <Widget>[
        //name
        Padding(
          padding: const EdgeInsets.only(top: 18,left: 24),
          child: Text('Name: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        ),
        Container(
          height: 80,
          width: 100,
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
                      return Padding(
                        padding:  const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                        child: Text("${data['name']}",style: TextStyle(fontSize: 17),),

                      );
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
        const Divider(height: 2,),
        //mail
        Padding(
          padding: const EdgeInsets.only(top: 18,left: 24),
          child: Text('Mail: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        ),
        Container(
          height: 80,
          width: 100,
          child:
          Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: Text(
                   getCurrentUser(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 17),
                ),
              )

        ),
        const Divider(height: 2,),
        //phone
        Padding(
          padding: const EdgeInsets.only(top: 18,left: 24),
          child: Text('Phone: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
        ),
        Container(
          height: 80,
          width: 100,
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return Center(
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
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                        child: Text("${data['number']}",style: TextStyle(fontSize: 17),),
                      );
                    }

                    return Text("loading");
                  },
                );
              } else {
                return Text("user is not logged in");
              }
            },
          ),
        ),
        const Divider(height: 2,),

      ]),
    );
  }
}
