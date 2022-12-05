import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/Invite_User/user_service.dart';
import 'package:trip_planner/constants.dart';

import '../../../../models/UserModel.dart';

class InviteUser extends StatefulWidget {
  const InviteUser({Key? key}) : super(key: key);

  @override
  State<InviteUser> createState() => _InviteUserState();
}

class _InviteUserState extends State<InviteUser> {
  UserService userService= UserService();
  List<UserModel> _userList = [];
  List<UserModel> newUserList = [];
  List<UserModel> userList = [];
  final TextEditingController _invite = TextEditingController();
  // void onSearch()async{
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   await firestore
  //       .collection('users')
  //       .where("email", isEqualTo: _invite.text)
  //       .get().then((value) {
  //         setState(() {
  //           userMap=value.docs[0].data();
  //         });
  //         print('SEARCH USER   $userMap');
  //   });
  // }

  void _onGetUser(String value) {
    setState(() {
      newUserList = _userList.where((val) {
        return val.email!.toLowerCase().contains(value.toLowerCase());
      }).toList();
      //  print("search  ${}")
    });

  }

  @override
  void initState() {
    super.initState();
    userService.getUserData().then((val) {
      setState(() {
        if(val!= null){
          _userList = val;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Invite Friends"),
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Search Friends',
              ),
              onChanged: _onGetUser,
            ),
          ),

          Expanded(
            child:
            ListView.builder(itemCount: newUserList.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 12,right: 6),
                              child: Text(
                                "\n${newUserList[i].email }",
                                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            Container(
                              margin: const EdgeInsets.only(left: 14,right: 6),
                              child: Text(
                                "Name: ${newUserList[i].name }",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
