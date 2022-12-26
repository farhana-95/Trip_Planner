import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/expense_service.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../constants.dart';
import 'expense_model.dart';

class ShowExpense extends StatefulWidget {
  final int tripid;
  final String name;
  const ShowExpense({Key? key,required this.tripid, required this.name}) : super(key: key);
  @override
  State<ShowExpense> createState() => _ShowExpenseState();
}
class _ShowExpenseState extends State<ShowExpense> {
  double totalExpense = 0;
  ExpenseService expservice = ExpenseService();
  List<ExpenseModel> _expenseList = [];
  static int tripId = 0 ;
  late final CollectionReference _expense;
  final TextEditingController amount=TextEditingController();
  final TextEditingController expenseCat=TextEditingController();
  final TextEditingController date=TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      amount.text = documentSnapshot['amount'].toString();
      expenseCat.text = documentSnapshot['expenseCat'];
      date.text = documentSnapshot['date'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 18,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: expenseCat,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Category: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: amount,
                    decoration: const InputDecoration(
                      labelText: 'Amount: ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: date,
                    decoration: const InputDecoration(
                      labelText: 'Date ',
                    ),
                    onTap: () async {
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

                Padding(
                  padding:
                  const EdgeInsets.only(left: 75, right: 75, bottom: 10),
                  child: ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String tcat = expenseCat.text;
                      final String tamount = amount.text;
                      final String tdate = date.text;

                      await _expense.doc(documentSnapshot!.id).update({
                        "amount": tamount,
                        "date": tdate,
                        "expenseCat": tcat,
                      });
                      expenseCat.text = '';
                      amount.text = '';
                      date.text = '';

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Updated")));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 75, right: 75, bottom: 10),
                  child: ElevatedButton(onPressed: ()=>_delete(documentSnapshot!.id), child: Text('Delete')),
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String expenseId) async {
    await _expense.doc(expenseId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Expense Deleted Successfully')));
     Navigator.pop(context);
  }
  Future<void> download() async {
    final pdf = pw.Document();
    var data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context )=>[
          pw.Center(
            child: pw.Header(text: '${widget.name} Trip\n\n\n'),

          ),
          pw.Center(
            child: pw.Text('Date: ${DateTime.now()}',style: pw.TextStyle(
              font:  pw.Font.ttf(data),color: PdfColors.black,)),

          ),
          pw.Divider(),
          //pw.Text('expenseIncomeList ${expenseIncomeList.first.expense}'),
          pw.Table.fromTextArray(
            cellStyle: const pw.TextStyle(
            ),
            context: context, data: <List<String>>[
            <String>[
              'Category',
              'Amount',
              'Date',
            ],
            ..._expenseList.map((item) =>
            [
              item.expenseCat,
              item.amount.toString(),
              item.date ,
            ],),
          ],
          ),
          pw.Divider(),
          pw.Table(
              children: [
                pw.TableRow(
                    children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('Total Expense  ${totalExpense}\n',style: pw.TextStyle(font:  pw.Font.ttf(data))),
                              ]
                          )
                      )
                    ]
                )
              ]
          ),
          pw.Footer(
              padding: pw.EdgeInsets.all(8.0)
          )
        ],
      ),
    );
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = '$directory/${widget.name}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    print("file   $file");
  }



  @override
  void initState() {
    tripId = widget.tripid;

    super.initState();
    expservice.getExpenseData(tripId).then((val) {
      if(mounted) {
        setState(() {
          if (val != null) {
            _expenseList = val;
            for(var element in val)
              {
                if(element.amount != null)
                  {
                    totalExpense +=element.amount ?? 0.0;
                  }
              }
          }
        });
      }
    });
    _expense = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("expense");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 45,right: 10,top: 15),
                child: Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 75,right: 10,top: 15),
                child: Text('Category',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80,right: 10,top: 15),
                child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: StreamBuilder(
              stream: _expense.orderBy('date',descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {

                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                      return  Container(
                        margin:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GestureDetector(
                          child: Card(
                            child: ListTile(
                              leading: Text("${documentSnapshot['date']}"),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 45),
                                child: Text("${documentSnapshot['expenseCat']}"),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text("${documentSnapshot['amount']}"),
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: <Widget>[
                              //     Container(
                              //       child: Text("${documentSnapshot['date']}"),
                              //     ),
                              //     Container(
                              //
                              //         child: Text("${documentSnapshot['amount']}")
                              //     ),
                              //     Container(
                              //
                              //       child: Text("${documentSnapshot['amount']}")
                              //     ),
                              //
                              //     // Container(
                              //     //   margin:
                              //     //   const EdgeInsets.only(left: 10, right: 6),
                              //     //   child: Text.rich(
                              //     //     TextSpan(
                              //     //       children: [
                              //     //         const WidgetSpan(
                              //     //           child: Icon(
                              //     //             Icons.location_on,
                              //     //             color: Color(0xFF868585),
                              //     //             size: 17,
                              //     //           ),
                              //     //         ),
                              //     //         TextSpan(
                              //     //           text:
                              //     //           '${documentSnapshot['area']}',
                              //     //           style: const TextStyle(
                              //     //               fontSize: 15,
                              //     //               color: Color(0xFF868585)),
                              //     //         ),
                              //     //       ],
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //
                              //
                              //   ],
                              // ),
                            ),
                          ),
                          onTap: ()=>_update(documentSnapshot),
                        ),
                      );
                      // Card(child: Text("Place Name ${documentSnapshot['name']}"));
                    },
                  );
                }
                return const Center(
                  child:Text(''),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        onPressed: () =>download(),
        child: Icon(Icons.picture_as_pdf_rounded),
      ),
    );
  }
}
