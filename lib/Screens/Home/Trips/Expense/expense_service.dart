
import 'package:cloud_firestore/cloud_firestore.dart';

import 'expense_model.dart';
class ExpenseService {
  double totalExpense = 0.0;
  double balance = 0.0;

  Future<List<ExpenseModel>?> getExpenseData(int tripId) async {
    final CollectionReference  _expense = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("expense");

    List<ExpenseModel> expenseList = [];
    totalExpense=0.0;
    balance = 0.0;
    QuerySnapshot addExpenseQuerySnapshot = await _expense.orderBy('date',descending: true).get();
    final List<dynamic> addExpenseData = addExpenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    print("AddExpenseData=    $addExpenseData");
    List<ExpenseModel> itemsList = List<ExpenseModel>.from(
        addExpenseData.map<ExpenseModel>((dynamic i) => ExpenseModel.fromJson(i)));
    expenseList.addAll(itemsList);

    for (var element in expenseList) {
      totalExpense += element.amount;
      print("allData  ${expenseList.last.amount} ${expenseList.length}   $totalExpense");
    }
    return itemsList;
  }

}
