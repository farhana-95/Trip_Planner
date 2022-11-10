
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/Screens/Home/Trips/plan_history.dart';
import 'package:trip_planner/constants.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  final CollectionReference _trip =
  FirebaseFirestore.instance.collection('trip');
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
                      //DateTime dt1 = DateTime.parse(documentSnapshot['enddate']);
                      DateTime dt3 =DateFormat('dd-MM-yyyy').parse(documentSnapshot['enddate']);
                      //var t=DateFormat('dd-MM-yyyy').parse(documentSnapshot['enddate']);
                      if(dt3.isBefore(new DateTime.now())){
                        return GestureDetector(
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Image.asset("assets/images/baggage.png"),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Trip: ${documentSnapshot['tripname']}",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  SizedBox(height: 7,),
                                  Text("Location: ${documentSnapshot['location']} "),
                                  SizedBox(height: 10,)
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Started: ${documentSnapshot['startdate']}"
                                    ,
                                    style: TextStyle(fontSize: 15.5),),
                                  SizedBox(height: 7,),
                                  Text("Ended:  ${documentSnapshot['enddate']}",style: TextStyle(fontSize: 15.5),),
                                ],
                              ),
                            ),
                            elevation: 3,
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PlanHistory(
                                        tripid: documentSnapshot[
                                        'tripid'])));
                          },
                        );
                        //print(documentSnapshot['tripname']);
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
