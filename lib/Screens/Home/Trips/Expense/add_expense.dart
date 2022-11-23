import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final amount=TextEditingController();
  final expenseCat=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView
        (
        child: Column(
          children:<Widget> [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amount,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Trip Name ',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Amount',
                ),
                onSaved: (amount){
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: expenseCat,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Category ',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                  hintText: 'Select Category',
                ),
                onSaved: (item){},
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: ElevatedButton(
                onPressed: (){},
              child: Text("Submit"),),
            )
          ],
        ),
      )
    );
  }
}
