import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/Expense/add_expense.dart';
import 'package:trip_planner/Screens/Home/Trips/addplan_details.dart';
import '../../../constants.dart';
import 'package:intl/intl.dart';

class ShowPlans extends StatefulWidget {
  const ShowPlans( {Key? key, required this.tripid}) : super(key: key);
  final int tripid;

  @override
  State<ShowPlans> createState() => _ShowPlansState();
}
class _ShowPlansState extends State<ShowPlans> {

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
  Future<void> _updateActivity([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      activitytitile.text = documentSnapshot['activitytitile'];
      activitynote.text = documentSnapshot['activitynote'];
      acttime.text = documentSnapshot['activitytime'];
      actdate.text = documentSnapshot['activitydate'];
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
            child: Wrap(
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: activitytitile,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Activity: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: activitynote,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Note: ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: actdate,
                    decoration: const InputDecoration(
                      labelText: 'Date: ',
                    ),
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          actdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: acttime,
                    decoration: const InputDecoration(
                      labelText: 'Time: ',
                    ),
                    onTap: ()async{
                      TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(tm != null)
                      {
                        setState(() {
                          acttime.text= tm.format(context);
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
                      final String atitle= activitytitile.text;
                      final String anote =activitynote.text;
                      final String adate =actdate.text;
                      final String atime =acttime.text;
                      await _activityplan
                          .doc(documentSnapshot!.id)
                          .update({"activitytitile": atitle, "activitynote": anote,
                        "activitydate": adate,"activitytime": atime});
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Updated!")
                      ));
                      activitytitile.text='';
                      activitynote.text='';
                      actdate.text='';
                      acttime.text='';
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Activity'),
                    onPressed: () => _deleteActivity(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _deleteActivity(String productId) async{
    await _activityplan.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Activity Deleted!")
    ));
  }
  Future<void> _updateTransport([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      transtype.text = documentSnapshot['transporttype'];
      transdate.text = documentSnapshot['transportdate'];
      transtime.text = documentSnapshot['transporttime'];
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
                    controller: transtype,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Transport: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: transdate,
                    decoration: const InputDecoration(
                      labelText: 'Date: ',
                    ),
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          transdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: transtime,
                    decoration: const InputDecoration(
                      labelText: 'Time: ',
                    ),
                    onTap: ()async{
                      TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(tm != null)
                      {
                        setState(() {
                          transtime.text= tm.format(context);
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
                      final String ttype= transtype.text;
                      final String tdate =transdate.text;
                      final String ttime =transtime.text;
                      await _transport
                          .doc(documentSnapshot!.id)
                          .update({"transporttype": ttype, "transportdate": tdate,
                        "transporttime": ttime,});
                      transtype.text='';
                      transdate.text='';
                      transtime.text='';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Transport'),
                    onPressed: () => _deleteTransport(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _deleteTransport(String productId) async{
    await _transport.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Transport Deleted!")
    ));
  }
  Future<void> _updateRestaurant([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      restname.text = documentSnapshot['restname'];
      resadd.text = documentSnapshot['resadd'];
      restdate.text = documentSnapshot['restdate'];
      restime.text = documentSnapshot['restime'];
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
            child: Wrap(
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restname,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Restaurant: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: resadd,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Address: ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restdate,
                    decoration: const InputDecoration(
                      labelText: 'Date: ',
                    ),
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          restdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restime,
                    decoration: const InputDecoration(
                      labelText: 'Time: ',
                    ),
                    onTap: ()async{
                      TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(tm != null)
                      {
                        setState(() {
                          restime.text= tm.format(context);
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
                      final String rname= restname.text;
                      final String radd =resadd.text;
                      final String rdate =restdate.text;
                      final String rtime =restime.text;
                      await _restaurant
                          .doc(documentSnapshot!.id)
                          .update({"restname": rname, "resadd": radd,
                        "restdate": rdate,"restime": rtime});
                      restname.text='';
                      resadd.text='';
                      restdate.text='';
                      restime.text='';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Restaurant'),
                    onPressed: () => _deleteRestaurant(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _deleteRestaurant(String productId) async{
    await _restaurant.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Restaurant Deleted!")
    ));
  }
  Future<void> _updateAcmd([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      acmtitle.text = documentSnapshot['acmtitle'];
      acmadd.text = documentSnapshot['acmadd'];
      acmin.text = documentSnapshot['acmin'];
      acmout.text = documentSnapshot['acmout'];
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
            child: Wrap(
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: acmtitle,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Accommodation: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: acmadd,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Address: ',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: acmin,
                    decoration: const InputDecoration(
                      labelText: 'Check-in: ',
                    ),
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          acmin.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: acmout,
                    decoration: const InputDecoration(
                      labelText: 'Check-out: ',
                    ),
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickeddate != null)
                      {
                        setState(() {
                          acmout.text= DateFormat('dd-MM-yyyy').format(pickeddate);
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
                      final String acmname= acmtitle.text;
                      final String acmad =acmadd.text;
                      final String acindate =acmin.text;
                      final String acoutdate =acmout.text;
                      await _accomodation
                          .doc(documentSnapshot!.id)
                          .update({"acmtitle": acmname, "acmadd": acmad,
                        "acmin": acindate,"acmout": acoutdate});
                      acmtitle.text='';
                      acmadd.text='';
                      acmin.text='';
                      acmout.text='';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Accomodation'),
                    onPressed: () => _deleteAcmd(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _deleteAcmd(String productId) async{
    await _accomodation.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Accommodation Deleted!")
    ));
  }
  Future<void> _updateNote([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {
      details.text = documentSnapshot['details'];
      date.text = documentSnapshot['date'];
      time.text = documentSnapshot['time'];
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
            child: Wrap(
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: details,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(labelText: 'Details: '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: date,
                    decoration: const InputDecoration(
                      labelText: 'Date: ',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: time,
                    decoration: const InputDecoration(
                      labelText: 'Time: ',
                    ),
                    onTap: ()async{
                      TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if(tm != null)
                      {
                        setState(() {
                          time.text= tm.format(context);
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
                      final String det= details.text;
                      final String ndate =date.text;
                      final String ntime =time.text;
                      await _addnotes
                          .doc(documentSnapshot!.id)
                          .update({"details": det, "date": ndate,
                        "time": ntime});
                      details.text='';
                      date.text='';
                      time.text='';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Note'),
                    onPressed: () => _deleteNote(documentSnapshot!.id),
                  ),
                ),

              ],
            ),
          );
        }
    );
  }
  Future<void> _deleteNote(String productId) async{
    await _addnotes.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Note Deleted!")
    ));
  }
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
                        child: GestureDetector(
                          child: ListTile(
                            leading: Image.asset("assets/images/lifestyle.png"),
                            title: Text("Activity: ${documentSnapshot['activitytitile']}\n"),
                            subtitle: Text("Details: ${documentSnapshot['activitynote']}\n"
                                      "\nDate: ${documentSnapshot['activitydate']} "
                                      "Time: ${documentSnapshot['activitytime']}"),

                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},// => _updateActivity(documentSnapshot),
                                    icon: Icon(Icons.edit_note,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: ()=> _updateActivity(documentSnapshot),
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
                        child: GestureDetector(
                          child: ListTile(
                            leading: Image.asset("assets/images/vehicles.png",height: 52,),
                            title: Text("Transport: ${documentSnapshot['transporttype']}\n"),
                            subtitle:
                                Text("Date: ${documentSnapshot['transportdate']} "
                                    "Time: ${documentSnapshot['transporttime']}"),

                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},// => _updateTransport(documentSnapshot),
                                    icon: Icon(Icons.edit_note,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: ()=> _updateTransport(documentSnapshot),
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
                        child: GestureDetector(
                          child: ListTile(
                            leading:  Image.asset("assets/images/dish.png",height: 60,),
                            title: Text("Restaurant: ${documentSnapshot['restname']}\n"),
                            subtitle:
                                Text("Address: ${documentSnapshot['resadd']}\n"
                                    "\nDate: ${documentSnapshot['restdate']} "
                                     "Time: ${documentSnapshot['restime']}"),

                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},// => _updateRestaurant(documentSnapshot),
                                    icon: Icon(Icons.edit_note,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: ()=> _updateRestaurant(documentSnapshot),
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
                        child: GestureDetector(
                          child: ListTile(
                            leading:  Image.asset("assets/images/guesthouse.png"),
                            title: Text("Accommodation: ${documentSnapshot['acmtitle']}\n"),
                            subtitle:
                                Text("Address: ${documentSnapshot['acmadd']}\n"
                                    "\nCheck-in: ${documentSnapshot['acmin']}\n"
                                     "Check-out: ${documentSnapshot['acmout']}"),
                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},// => _updateAcmd(documentSnapshot),
                                    icon: Icon(Icons.edit_note,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: ()=> _updateAcmd(documentSnapshot),
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
                        child: GestureDetector(
                          child: ListTile(
                            leading: Image.asset("assets/images/note-book.png",height: 50,),
                            title: Text("Note: ${documentSnapshot['details']}\n"
                            ),
                            subtitle: Text("Date: ${documentSnapshot['date']} ""Time: ${documentSnapshot['time']}"),
                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){},// => _updateNote(documentSnapshot),
                                    icon: Icon(Icons.edit_note,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap:() => _updateNote(documentSnapshot),
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
      floatingActionButton: Container(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          //Navigator.pop(context);
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PlanDetails(tripid: tripId);
                },
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddExpense(tripid: tripId);
                },
              ),
            );
          });
          },
        child: const Icon(Icons.add),
      ),
    ),

    );
  }
}
