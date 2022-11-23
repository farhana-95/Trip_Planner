import 'package:flutter/material.dart';

class ViewExpense extends StatefulWidget {
  const ViewExpense({Key? key}) : super(key: key);

  @override
  State<ViewExpense> createState() => _ViewExpenseState();
}

class _ViewExpenseState extends State<ViewExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('view'),
    );
  }
}
