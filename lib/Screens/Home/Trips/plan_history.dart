import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class PlanHistory extends StatefulWidget {
  const PlanHistory( {Key? key, required this.tripid}) : super(key: key);
  final int tripid;

  @override
  State<PlanHistory> createState() => _PlanHistoryState();
}
class _PlanHistoryState extends State<PlanHistory> {

  static int tripId = 0 ;
  late final CollectionReference _activityplan;
  late final CollectionReference _transport;
  late final CollectionReference _restaurant;
  late final CollectionReference _accomodation;
  late final CollectionReference _addnotes;
  final activitytitile = TextEditingController();
  final activitynote = TextEditingController();
  final acttime = TextEditingController();
  final actdate = TextEditingController();
  final transtype = TextEditingController();
  final transdate = TextEditingController();
  final transtime = TextEditingController();
  final restname = TextEditingController();
  final resadd = TextEditingController();
  final restdate = TextEditingController();
  final restime = TextEditingController();
  final acmtitle = TextEditingController();
  final acmadd = TextEditingController();
  final acmin = TextEditingController();
  final acmout = TextEditingController();
  final details = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();

  @override
  void initState() {
    tripId = widget.tripid;
    _activityplan = FirebaseFirestore.instance.collection("$tripId").doc("activityplan").collection("$tripId");
    _transport = FirebaseFirestore.instance.collection("$tripId").doc("transport").collection("$tripId");
    _restaurant = FirebaseFirestore.instance.collection("$tripId").doc("restaurant").collection("$tripId");
    _accomodation = FirebaseFirestore.instance.collection("$tripId").doc("accomodation").collection("$tripId");
    _addnotes = FirebaseFirestore.instance.collection("$tripId").doc("addnotes").collection("$tripId");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children:<Widget> [
          Expanded(
            child: StreamBuilder(
              stream: _activityplan.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){

                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot=
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset("assets/images/lifestyle.png"),
                          title: Text("Activity: ${documentSnapshot['activitytitile']}\n"),
                          subtitle: Text("Details: ${documentSnapshot['activitynote']}\n"
                              "\nDate: ${documentSnapshot['activitydate']} "
                              "Time: ${documentSnapshot['activitytime']}"),

                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _transport.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot=
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset("assets/images/vehicles.png",height: 52,),
                          title: Text("Transport: ${documentSnapshot['transporttype']}\n"),
                          subtitle:
                          Text("Date: ${documentSnapshot['transportdate']} "
                              "Time: ${documentSnapshot['transporttime']}"),

                        ),
                      );
                    },

                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _restaurant.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot=
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading:  Image.asset("assets/images/dish.png",height: 60,),
                          title: Text("Restaurant: ${documentSnapshot['restname']}\n"),
                          subtitle:
                          Text("Address: ${documentSnapshot['resadd']}\n"
                              "\nDate: ${documentSnapshot['restdate']} "
                              "Time: ${documentSnapshot['restime']}"),

                        ),
                      );
                    },

                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _accomodation.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot=
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading:  Image.asset("assets/images/guesthouse.png"),
                          title: Text("Accommodation: ${documentSnapshot['acmtitle']}\n"),
                          subtitle:
                          Text("Address: ${documentSnapshot['acmadd']}\n"
                              "\nCheck-in: ${documentSnapshot['acmin']}\n"
                              "Check-out: ${documentSnapshot['acmout']}"),

                        ),
                      );
                    },

                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _addnotes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if(streamSnapshot.hasData){
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot=
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset("assets/images/note-book.png",height: 50,),
                          title: Text("Note: ${documentSnapshot['details']}\n"
                          ),
                          subtitle: Text("Date: ${documentSnapshot['date']} ""Time: ${documentSnapshot['time']}"),

                        ),
                      );
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
