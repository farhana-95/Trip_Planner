import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Notifications/alarm_manager/alarm_manager.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/Category/category_service.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/add_expense.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/expense.dart';
import 'package:trip_planner/Screens/Home/Trips/show_plans.dart';
import 'package:trip_planner/Screens/Home/Trips/add_trips.dart';
import 'package:trip_planner/constants.dart';
import 'package:intl/intl.dart';
import '../Notifications/LocalDB/Localdb.dart';
import 'Expense/Category/category_model.dart';
import 'allData.dart';
class Trip extends StatefulWidget {
   Trip({Key? key,}) : super(key: key);
  @override
  State<Trip> createState() => _TripState();
}
class _TripState extends State<Trip> {

  Localdb localDb =  Localdb();
  SetAlarm alarm =  SetAlarm();

  final CollectionReference _trip =
      FirebaseFirestore.instance.collection('trip');
  final _location = TextEditingController();
  final _startdate = TextEditingController();
  final _enddate = TextEditingController();
  final _tripname = TextEditingController();
  final _triptime = TextEditingController();



  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _tripname.text = documentSnapshot['tripname'];
      _location.text = documentSnapshot['location'];
      _startdate.text = documentSnapshot['startdate'];
      _enddate.text = documentSnapshot['enddate'];

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
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _tripname,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Trip: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _location,
                    decoration: const InputDecoration(
                      labelText: 'Location: ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _startdate,
                    decoration: const InputDecoration(
                      labelText: 'Startdate ',
                    ),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      TimeOfDay? tpm = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                      if (pickeddate != null && tpm != null) {
                        setState(() {
                          _startdate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate)+ " ${tpm.format(context)}";
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _enddate,
                    decoration: const InputDecoration(
                      labelText: 'Enddate ',
                    ),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          _enddate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  TextField(
                    controller: _triptime,
                    decoration: const InputDecoration(
                        hintText: 'Set Time for Reminder'
                    ),
                    onTap: ()async{
                      TimeOfDay? tpm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(tpm != null)
                      {
                        setState(() {
                          _triptime.text= tpm.format(context);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String tname = _tripname.text;
                      final String tlocation = _location.text;
                      final String tstdate = _startdate.text;
                      final String tedate = _enddate.text;
                      final String tptime = _triptime.text;

                      await _trip.doc(documentSnapshot!.id).update({
                        "tripname": tname,
                        "location": tlocation,
                        "startdate": tstdate,
                        "enddate": tedate,
                        "reminder": tptime
                      });
                      _tripname.text = '';
                      _location.text = '';
                      _startdate.text = '';
                      _enddate.text = '';
                      _triptime.text='';

                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Updated")));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: ElevatedButton(

                    child: const Text('Set Reminder'),
                    onPressed: ()  {
                     localDb.saveData(documentSnapshot!.id, _tripname.text,
                         _location.text, _startdate.text, _triptime.text, _enddate.text, true);
                      // AndroidAlarmManager.periodic(const Duration(minutes: 1), 1, printHello);
                     alarm.scheduleOneShotAlarm(_startdate.text, true);
                     ScaffoldMessenger.of(context)
                         .showSnackBar(const SnackBar(content: Text("Reminder Saved!")));
                     Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _delete(String tripid) async {
    await _trip.doc(tripid).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Trip Deleted!")));
  }
  List<Cat> catList =  [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _trip.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      DateTime dt2 =DateFormat('dd-MM-yyyy').parse(documentSnapshot['enddate']);
                      if(dt2.isAfter(new DateTime.now())){
                        return Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            leading: Image.asset("assets/images/baggage.png"),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Trip: ${documentSnapshot['tripname']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                const SizedBox(height: 7,),
                                Text("Location: ${documentSnapshot['location']} "),
                                const SizedBox(height: 10,)
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Starts: ${documentSnapshot['startdate']}",
                                style: const TextStyle(fontSize: 15.5),),
                                const SizedBox(height: 7,),
                                Text("Ends:  ${documentSnapshot['enddate']}",style: TextStyle(fontSize: 15.5),),
                              ],
                            ),

                            trailing:PopupMenuButton<int>(
                              itemBuilder: (context)=>
                              [
                                PopupMenuItem(
                                  value: 1,
                                  child:
                                Row(
                                  children: const [
                                    Text('Update'),
                                    SizedBox(width: 44,),
                                    Icon(Icons.edit),
                                  ],
                                ),
                                ),
                                PopupMenuItem(
                                  value:2,
                                  child: Row(
                                    children: const [
                                      Text('View Plans'),
                                      SizedBox(width: 17,),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value:3,
                                  child: Row(
                                    children: const [
                                      Text('Expense'),
                                      SizedBox(width: 32,),
                                      Icon(Icons.monetization_on),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 4,
                                  child:  Row(
                                    children: const [
                                      Text('Delete Trip'),
                                      SizedBox(width: 17,),
                                      Icon(Icons.delete),
                                    ],
                                  ),
                                ),
                              ],
                             onSelected:(val){
                                switch (val){
                                  case 1: _update(documentSnapshot);break;
                                   case 2:Navigator.of(context).push(
                                       MaterialPageRoute(
                                           builder: (context) => AllData(
                                               tripid: documentSnapshot[
                                               'tripid'])));break;
                                // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ShowPlans(
                                  //             tripid: documentSnapshot[
                                  //             'tripid'])));break;
                                  case 3:  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Expense(tripid: documentSnapshot[
                                          'tripid'])));
                                  break;
                                  case 4: showDialog(context: context,
                                      builder: (BuildContext context)=>
                                          AlertDialog(
                                            title: Text('Alert!'),
                                            content: Text('Do you want to delete it anyway?'),
                                            actions:<Widget> [
                                              TextButton(onPressed: (){
                                                _delete(documentSnapshot.id);
                                                Navigator.pop(context);
                                              }, child: const Text("Ok")),
                                              TextButton(onPressed: (){ Navigator.pop(context);}, child: const Text("Cancel"))
                                            ],
                                          )
                                  );break;
                                }
                             } ,
                            )
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTrips(name: '', area: '',)));

        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

