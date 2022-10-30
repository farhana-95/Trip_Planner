import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/show_plans.dart';
import 'package:trip_planner/Screens/Home/Trips/add_trips.dart';
import 'package:trip_planner/Screens/Home/main_screen.dart';
import 'package:trip_planner/constants.dart';
import 'package:intl/intl.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  final CollectionReference _trip=
  FirebaseFirestore.instance.collection('trip');
  final _location=TextEditingController();
  final _startdate=TextEditingController();
  final _enddate=TextEditingController();
  final _tripname=TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      _tripname.text = documentSnapshot['tripname'];
      _location.text = documentSnapshot['location'];
      _startdate.text = documentSnapshot['startdate'];
      _enddate.text = documentSnapshot['enddate'];
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Updated!")
      ));
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
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
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          _startdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          _enddate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () async {
                        final String tname= _tripname.text;
                        final String tlocation =_location.text;
                        final String tstdate =_startdate.text;
                        final String tedate =_enddate.text;
                          await _trip
                              .doc(documentSnapshot!.id)
                              .update({"tripname": tname, "location": tlocation,
                            "startdate": tstdate,"enddate": tedate});
                        _tripname.text='';
                        _location.text='';
                        _startdate.text='';
                        _enddate.text='';

                      },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text('Delete Trip'),
                      onPressed: () => _delete(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _delete(String productId) async{
    await _trip.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Trip Deleted!")
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget> [
          Expanded(child: StreamBuilder(
            stream: _trip.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
              if(streamSnapshot.hasData){
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    final DocumentSnapshot documentSnapshot=
                    streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.travel_explore),
                        title: Text("Trip: ${documentSnapshot['tripname']}\n"),
                        subtitle: Text("Location: ${documentSnapshot['location']} \n"
                            "Starts: ${documentSnapshot['startdate']}\n"
                            "Ends:  ${documentSnapshot['enddate']}"),
                        trailing: SizedBox(
                          width: 100,
                          height: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => _update(documentSnapshot),
                                icon: Icon(Icons.edit,),
                              ),
                              IconButton(
                                  onPressed: (){
                                    //Navigator.pop(context);
                                    setState(() {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => ShowPlans(
                                              tripid: documentSnapshot['tripid'])));
                                    });
                                  },
                                  icon: Icon(Icons.arrow_forward_ios,),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 3,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        tooltip: 'Increment',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTrips()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}