import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

class ShowActivity extends StatefulWidget {
   ShowActivity({Key? key,required this.tripid}) : super(key: key);
  final int tripid;

  @override
  State<ShowActivity> createState() => _ShowActivityState();
}

class _ShowActivityState extends State<ShowActivity> {
  static int tripId = 0;

  late final CollectionReference _activityplan;

  final activitytitile = TextEditingController();
  final activitynote = TextEditingController();
  final acttime = TextEditingController();
  final actdate = TextEditingController();
  Future<void> _updateActivity([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      activitytitile.text = documentSnapshot['activitytitile'];
      activitynote.text = documentSnapshot['activitynote'];
      acttime.text = documentSnapshot['activitytime'];
      actdate.text = documentSnapshot['activitydate'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          actdate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: () async {
                      TimeOfDay? tm = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (tm != null) {
                        setState(() {
                          acttime.text = tm.format(context);
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
                      final String atitle = activitytitile.text;
                      final String anote = activitynote.text;
                      final String adate = actdate.text;
                      final String atime = acttime.text;
                      await _activityplan.doc(documentSnapshot!.id).update({
                        "activitytitile": atitle,
                        "activitynote": anote,
                        "activitydate": adate,
                        "activitytime": atime
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Updated!")));
                      activitytitile.text = '';
                      activitynote.text = '';
                      actdate.text = '';
                      acttime.text = '';
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
        });
  }

  Future<void> _deleteActivity(String productId) async {
    await _activityplan.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Activity Deleted!")));
  }

  @override
  void initState() {
    tripId = widget.tripid;
    _activityplan = FirebaseFirestore.instance
        .collection("trip")
        .doc("$tripId")
        .collection("activityplan");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Activities/Events'),),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _activityplan.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: ListTile(
                            leading: Image.asset("assets/images/img_7.png",color: kPrimaryColor,height: 30,),
                            title: Text(
                                " ${documentSnapshot['activitytitile']}\n"),
                            subtitle: Text(
                                "Details: ${documentSnapshot['activitynote']}\n"
                                    "\nDate: ${documentSnapshot['activitydate']} "
                                    "Time: ${documentSnapshot['activitytime']}"),
                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    // => _updateActivity(documentSnapshot),
                                    icon: Icon(
                                      Icons.edit_note,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _updateActivity(documentSnapshot),
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
