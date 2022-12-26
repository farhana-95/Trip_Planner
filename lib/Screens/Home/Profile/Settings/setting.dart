import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String  Id;
  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print(uid);
    // _userInfo;
    // print(_userInfo);
    return uid;
  }
  late final CollectionReference _trip;
  @override
  void initState(){
    Id=getCurrentUser();
    _trip = FirebaseFirestore.instance.
    collection("trip").doc(Id).collection("trip");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              child: Card(
                elevation: 2,
                child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 28,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25,left: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.settings_backup_restore,
                                color: Color(0xFF868585),
                                size: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                              ' Reset All Data',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF868585)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
              onTap: (){
                showDialog<void>(context: context, builder: (ctx)=>
                AlertDialog(
                  content: const Text('Reset Data'),
                  actions: [
                    TextButton(onPressed: (){
                      _trip.get().then((snapshot) {
                        for (DocumentSnapshot doc in snapshot.docs) {
                          doc.reference.delete();
                        }
                      });

                    },
                        child: Text('OK')),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel'))
                  ],
                ));
              },
            ),
          ),

        ],
      ),
    );
  }
}
