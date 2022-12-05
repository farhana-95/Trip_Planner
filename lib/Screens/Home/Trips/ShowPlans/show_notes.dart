import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/constants.dart';

class ShowNotes extends StatefulWidget {
   ShowNotes({Key? key, required this.tripid}) : super(key: key);
  final int tripid;


  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {
  static int tripId = 0;

  late final CollectionReference _addnotes;

  final details = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();
  Future<void> _updateNote([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      details.text = documentSnapshot['details'];
      date.text = documentSnapshot['date'];
      time.text = documentSnapshot['time'];
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Updated!")));
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          date.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: () async {
                      TimeOfDay? tm = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (tm != null) {
                        setState(() {
                          time.text = tm.format(context);
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
                      final String det = details.text;
                      final String ndate = date.text;
                      final String ntime = time.text;
                      await _addnotes.doc(documentSnapshot!.id).update(
                          {"details": det, "date": ndate, "time": ntime});
                      details.text = '';
                      date.text = '';
                      time.text = '';
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
        });
  }

  Future<void> _deleteNote(String productId) async {
    await _addnotes.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Note Deleted!")));
  }

  @override
  void initState() {
    tripId = widget.tripid;
    _addnotes = FirebaseFirestore.instance
        .collection("trip")
        .doc("$tripId")
        .collection("addnotes");
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
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _addnotes.snapshots(),
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
                            leading: Image.asset(
                              "assets/images/img_8.png",
                              height: 32,color: kPrimaryColor,
                            ),
                            title:
                            Text("${documentSnapshot['details']}\n"),
                            subtitle: Text("Date: ${documentSnapshot['date']} "
                                "Time: ${documentSnapshot['time']}"),
                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    // => _updateNote(documentSnapshot),
                                    icon: Icon(
                                      Icons.edit_note,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _updateNote(documentSnapshot),
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
