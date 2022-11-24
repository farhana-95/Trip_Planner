
class ExpenseModel {
  double? amount;
  String? expenseCat;
  String? date;

  ExpenseModel({this.amount,this.expenseCat,this.date});

  //receiving data from server
  factory ExpenseModel.fromMap(map){
    return ExpenseModel(
      amount: map['amount'],
      expenseCat: map['expenseCat'],
      date: map['date'],

    );
  }
//sending data to server
  Map<String, dynamic> toMap(){
    return{
      'amount': amount,
      'expenseCat': expenseCat,
      'date': date,
    };
  }
  static fromJson(i) {
    ExpenseModel expenseModel = ExpenseModel(amount: i["amount"],expenseCat: i["expenseCat"],date: i["date"]);
    return expenseModel;

  }

}