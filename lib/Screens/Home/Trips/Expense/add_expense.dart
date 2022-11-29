import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'Category/category_model.dart';
import 'Category/show_category.dart';
class AddExpense extends StatefulWidget {
    Cat? category;

   AddExpense({Key? key, this.category,  required this.tripid
   }) : super(key: key);
    final int tripid;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
   static int tripId = 0 ;
  late final CollectionReference _expense;
  final TextEditingController amount=TextEditingController();
  final TextEditingController expenseCat=TextEditingController();
  final TextEditingController date=TextEditingController();
   int iconId = 0;

  @override
  void initState(){
    tripId = widget.tripid;
    expenseCat.text = widget.category?.name ?? "";
    iconId = widget.category?.icon ?? 0;

    _expense = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("expense");
    super.initState();
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
                controller: expenseCat,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  prefixIcon:  iconId == 0? null :Icon(IconDataSolid(iconId)),
                  border: UnderlineInputBorder(),
                  labelText: 'Category ',
                  labelStyle: const TextStyle(
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
                        return  CategoryScreen(tripid: tripId,);
                      });

                },
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amount,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
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
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: date,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
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
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: ElevatedButton(
                onPressed: ()async{
                  Map<String,dynamic> data={
                    'amount': double.parse(amount.text),
                    'expenseCat': expenseCat.text,
                    'date': date.text,
                  };
                  if (kDebugMode) {
                    print("addExpense   $data");
                  }
                  _expense.add(data).then((value) {
                    amount.clear();
                    expenseCat.clear();
                    date.clear();
                  });
                  Navigator.pop(context);


                },

              child: const Text("Submit"),),
            )
          ],

        ),
      )
    );
  }
}

