
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/plan_history.dart';
import 'package:trip_planner/Screens/Home/Trips/show_trip.dart';
import 'package:trip_planner/constants.dart';

import 'Expense/expense.dart';
import 'ShowPlans/show_plans.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  late final CollectionReference _trip;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    return uid;
  }
  late String  Id;
  Trip showTrip = Trip();
  @override
  void initState() {
    Id = getCurrentUser();
    print("ID-   $Id");
    _trip = FirebaseFirestore.instance.collection("trip").doc(Id).collection("trip");
    super.initState();
  }
  Future<void> _delete(String tripid) async {
    await _trip.doc(tripid).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Trip Deleted!")));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const Text('Past Trips'),
      backgroundColor: kPrimaryColor,
      ),
      body:Column(
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
                      DateTime dt3 =DateFormat('dd-MM-yyyy').parse(documentSnapshot['enddate']);
                      if(dt3.isBefore(new DateTime.now())){
                        return
                          Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 3,
                            child: Row(children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 120,
                                  height: 130,
                                  child: Image.network(
                                    '${documentSnapshot['image']}',
                                    fit: BoxFit.cover,
                                  )
                                //Image.asset("assets/images/trip.png",fit: BoxFit.cover,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${documentSnapshot['tripname']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: 190,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 17,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            '${documentSnapshot['location']}\n',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Started: ${documentSnapshot['startdate']}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Ended:  ${documentSnapshot['enddate']}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              Expanded(
                                child: PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 2,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'View Plans',
                                            style: TextStyle(
                                                color: Color(0xFF6C6C6C)),
                                          ),
                                          SizedBox(
                                            width: 21.6,
                                          ),
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Expense',
                                            style: TextStyle(
                                                color: Color(0xFF6C6C6C)),
                                          ),
                                          SizedBox(
                                            width: 37,
                                          ),
                                          Icon(Icons.monetization_on,
                                              color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 4,
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Delete Trip',
                                            style: TextStyle(
                                                color: Color(0xFF6C6C6C)),
                                          ),
                                          SizedBox(
                                            width: 23,
                                          ),
                                          Icon(Icons.delete, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (val) {
                                    switch (val) {
                                      case 2:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => ShowPlans(
                                                    tripid: documentSnapshot[
                                                    'tripid'])));
                                        break;
                                      case 3:
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Expense(
                                                    tripid: documentSnapshot[
                                                    'tripid'])));
                                        break;
                                      case 4:
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text('Alert!'),
                                                  content: const Text(
                                                      'Do you want to delete it anyway?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () {
                                                          _delete(documentSnapshot
                                                              .id);
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text("Ok")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child:
                                                        const Text("Cancel"))
                                                  ],
                                                ));
                                        break;
                                    }
                                  },
                                ),
                              )
                            ]),
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
    );
  }
}
