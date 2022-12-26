
class ExpenseModel {
  double amount = 0;
  String expenseCat = "";
  String date;

  ExpenseModel({required this.amount,required this.expenseCat,required this.date});

  //receiving data from server
  factory ExpenseModel.fromMap(map){
    return ExpenseModel(
      amount: map['amount'] ,
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
    ExpenseModel expenseModel = ExpenseModel(amount: i["amount"] ?? 0, expenseCat: i["expenseCat"] , date: i["date"]);
    return expenseModel;

  }

}