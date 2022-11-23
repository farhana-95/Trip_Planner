import 'package:firebase_auth/firebase_auth.dart';

class ExpenseModel {
  String? amount;
  String? expenseCat;

  ExpenseModel({this.amount,this.expenseCat});

  //receiving data from server
  factory ExpenseModel.fromMap(map){
    return ExpenseModel(
      amount: map['amount'],
      expenseCat: map['expenseCat'],

    );
  }
//sending data to server
  Map<String, dynamic> toMap(){
    return{
      'amount': amount,
      'expenseCat': expenseCat,
    };
  }
  static fromJson(i) {
    ExpenseModel expenseModel = ExpenseModel(amount: i["amount"],expenseCat: i["expenseCat"]);
    return expenseModel;

  }

}