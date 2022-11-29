import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/pie_chart.dart';

class ViewExpense extends StatefulWidget {
  final int tripid;
   ViewExpense({Key? key, required this.tripid}) : super(key: key);

  @override
  State<ViewExpense> createState() => _ViewExpenseState();
}

class _ViewExpenseState extends State<ViewExpense> {
  static int tripId = 0 ;
  @override
  void initState(){
    tripId = widget.tripid;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
       AllExpensePieChart(tripid: tripId,);

  }
}
