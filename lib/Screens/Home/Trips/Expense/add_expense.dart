import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/expense_model.dart';
import 'Category/category_model.dart';
import 'Category/show_category.dart';

class AddExpense extends StatefulWidget {
    Cat? category;
     int?  tripid;
   AddExpense({Key? key, this.category,  this.tripid
   }) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  ExpenseModel expModel = ExpenseModel();
   static int tripId = 0 ;
     late CollectionReference addExpense;
  final amount=TextEditingController();
  final expenseCat=TextEditingController();
  final date=TextEditingController();
   int iconId = 0;

  @override
  void initState(){
    tripId = widget.tripid!;
    expenseCat.text = widget.category?.name ?? "";
    iconId = widget.category?.icon ?? 0;

    addExpense = FirebaseFirestore.instance.collection("$tripId").doc("addExpense").collection("$tripId");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  labelText: 'Amount ',
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

                decoration: InputDecoration(
                  prefixIcon:  iconId == 0? null :Icon(IconDataSolid(iconId)),
                  border: UnderlineInputBorder(),
                  labelText: 'Category ',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                  hintText: 'Select Category',
                ),
                onSaved: (item){
                },
                onTap: (){
                  showModalBottomSheet(context: context,
                      builder: (BuildContext context){
                        return const CategoryScreen();
                      });
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: date,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date ',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                  hintText: 'Enter Date',
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      date.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }

                },
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: ElevatedButton(
                onPressed: (){
                  expModel.toMap();
                },
              child: const Text("Submit"),),
            )
          ],
        ),
      )
    );
  }
}

