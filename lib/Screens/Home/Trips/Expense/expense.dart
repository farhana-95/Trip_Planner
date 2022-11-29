import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/add_expense.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/pie_chart.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/view_expense.dart';
import 'package:trip_planner/constants.dart';

import 'Category/category_model.dart';

class Expense extends StatefulWidget {
  Cat? category;
  final int tripid;
   Expense( {Key? key,this.category, required this.tripid}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  static int tripId = 0 ;
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
          TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Container(
                  child: Text('Add expense'),
                ),
              ),
              Tab(
                child: Container(
                  child: Text('View Expense'),
                ),
              ),
              // Tab(text: 'Add Expense',icon: Icon(Icons.add),),
              // Tab(text: 'View Expense',icon: Icon(Icons.view_headline_outlined),)
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
          AddExpense(category: widget.category,tripid: widget.tripid),
            // ViewExpense(tripid: tripId)
             AllExpensePieChart(tripid: widget.tripid,),
          ],
        ),
      ),
    );
  }
}
