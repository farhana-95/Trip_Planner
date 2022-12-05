import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/UserModel.dart';

class UserService{


  Future<List<UserModel>?> getUserData() async {

    var data = await FirebaseFirestore.instance.collection("users");

    List<UserModel> userList = [];

    QuerySnapshot userQuery = await data.get();
    final List<dynamic> userListData = userQuery.docs.map((doc) => doc.data()).toList();
    List<UserModel> itemsList = List<UserModel>.from(
        userListData.map<UserModel>((dynamic i) => UserModel.fromJson(i)));
    userList.addAll(itemsList);


    return userList;
  }

}