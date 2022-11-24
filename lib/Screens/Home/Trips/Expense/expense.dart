import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/Category/category_service.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/add_expense.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/view_expense.dart';
import 'package:trip_planner/constants.dart';

import 'Category/category_model.dart';

class Expense extends StatefulWidget {
  Cat? category;
   Expense({Key? key,this.category}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
            title: Text("Trip Expense"),
          elevation: 2,
          bottom:
          const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Add Expense',icon: Icon(Icons.add),),
              Tab(text: 'View Expense',icon: Icon(Icons.view_headline_outlined),)
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
          AddExpense(category: widget.category,),
            const ViewExpense(),
          ],
        ),
      ),
    );
  }
}
