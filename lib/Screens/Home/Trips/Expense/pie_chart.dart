import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'expense_model.dart';
import 'expense_service.dart';

class AllExpensePieChart extends StatefulWidget {
  final int tripid;

   AllExpensePieChart({Key? key, required this.tripid}) : super(key: key);

  @override
  State<AllExpensePieChart> createState() => _AllExpensePieChartState();
}

class _AllExpensePieChartState extends State<AllExpensePieChart> {

  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;
  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
   List<ExpenseModel> expenseList = [];

  int key=0;

  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getExpenseData(widget.tripid).then((value) {
      setState(() {
        if(value != null) {
         // expenseList=value;
          for(var listItem in value){
             expenseList.addExpenseIncome(expenseIncome: listItem);
            // if(listItem.expenseCat.contains(listItem.expenseCat)){
            //
            // }

          }
        }
      });
    }) ;

    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Map<String, double> getCategoryData(){
    Map<String,double>catMap={};
    for(var item in expenseList){
      //  print("catMap cat ${item.category}:${item.expense}");
      if(catMap.containsKey(item.expenseCat)==false){
        catMap[item.expenseCat.toString()] = item.amount;
      }
      else{
        double sum = 0;
        if(catMap.containsKey(item.expenseCat)){
          double beforeValue = catMap[item.expenseCat] ?? 0;
          sum = beforeValue + item.amount;
          // print("catMap sum ${item.category}  $beforeValue ${catMap[item.category] ?? 0}    ${double.parse(item.expense ?? "0")}   $sum");
          catMap.update(item.expenseCat.toString(), (double) => sum);
        }
      }
    }
    return catMap;
  }
  List<Color> colorList = [
    Color.fromRGBO(123, 201, 82, 1),
    Color.fromRGBO(255, 171, 67, 1),
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromARGB(255, 245, 156, 120),
    Color.fromRGBO(116, 180, 155, 1),
    Color.fromRGBO(0, 168, 181, 1),
    Color.fromRGBO(73, 76, 162, 1),
  ];

  Widget pieChartOne(){
    return PieChart(
      key: ValueKey(key),
      dataMap: getCategoryData(),
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 800),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width/2.2,
      ringStrokeWidth: 36,
      colorList: colorList,
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: false,
          showChartValues: true,
          decimalPlaces: 2,
          chartValueStyle: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black)),
      centerText: 'Total\nExpense \n${expenseIncomeService.totalExpense} ',
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        // legendLabels:  {},
        legendShape: BoxShape.circle,
        legendPosition: LegendPosition.right,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.normal,fontSize: 12,
          color: Colors.black,

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            if(getCategoryData().isNotEmpty)...[
              Card(
                child: SizedBox(
                    height: 280,
                    child: pieChartOne()),
              ),
            ]else...[
              Center(
                child: Column(
                  children:  [
                    //Icon(Icons.refresh_sharp),
                    Text("No data")

                  ],
                ),
              ),
            ],
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  <Widget>[
                    Container(
                      width: 90,
                      child: Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                      alignment: Alignment.centerRight,),
                    Spacer(),
                    Container(
                      width: 75,
                      child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      alignment: Alignment.centerRight,
                    ),
                    //Spacer(),
                    Container(
                      width: 85,
                      child: Text('%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                      alignment: Alignment.centerRight,
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            Divider(),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: expenseList.length,
                    itemBuilder: (BuildContext ctx, index){
                      return Column(
                        children: <Widget>[
                          //ListTile(
                          // subtitle:
                          Row(
                            children: <Widget>[
                              Container(width: 120,
                                child: Center(
                                  child: Text(
                                    "${expenseList[index].expenseCat}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),Spacer(flex: 1,),
                              Container(width: 100,
                                child: Center(
                                  child: Text("${expenseList[index].amount}",
                                    style: TextStyle(color: Colors.green.shade900,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),Spacer(flex: 1,),
                              Container(width: 85,
                                child: Center(
                                  child: Text("${categoryPercent(expenseList[index].amount ?? 0,
                                      expenseIncomeService.totalExpense).toStringAsFixed(2)} %",
                                    style: TextStyle(color: Colors.black,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),Spacer(),

                            ],
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),

          ],
        )

    );
  }
}
double categoryPercent(double expense, double totalExpense,){

  double percent =  (expense/totalExpense)*100.floor();
  return percent;
}

extension on List<ExpenseModel> {
  void addExpenseIncome({required ExpenseModel expenseIncome}) {
    print("expenses 3 ${expenseIncome.expenseCat}    ${expenseIncome.toMap()}");

    var expenses = 0.0;
    if (isNotEmpty) {
      try {
        var expense = firstWhere((p) => p.expenseCat == expenseIncome.expenseCat);
        expense.amount += (expenseIncome.amount ?? 0);

      } catch(e) {
        add(ExpenseModel(amount: expenseIncome.amount,expenseCat: expenseIncome.expenseCat ,date: expenseIncome.date ));
      }
    } else {

      add(ExpenseModel(amount: expenseIncome.amount,expenseCat: expenseIncome.expenseCat ,date: expenseIncome.date ));
    }
  }
}
