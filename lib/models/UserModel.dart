import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
   String? email;
   String? name;
   String? number;

  UserModel({this.email,this.name,this.number});

  //receiving data from server
factory UserModel.fromMap(map){
  return UserModel(
    email: map['email'],
    name: map['name'],
    number: map['number'],

  );
}
//sending data to server
Map<String, dynamic> toMap(){
  return{
    'email': email,
    'name': name,
    'number': number,
  };
}

}