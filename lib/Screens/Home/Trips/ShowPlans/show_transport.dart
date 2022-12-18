import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

class ShowTransport extends StatefulWidget {
   ShowTransport({Key? key, required this.tripid}) : super(key: key);
  final int tripid;


  @override
  State<ShowTransport> createState() => _ShowTransportState();
}

class _ShowTransportState extends State<ShowTransport> {
  static int tripId = 0;

  late final CollectionReference _transport;

  final transtype = TextEditingController();
  final transdate = TextEditingController();
  final transtime = TextEditingController();
  Future<void> _updateTransport([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      transtype.text = documentSnapshot['transporttype'];
      transdate.text = documentSnapshot['transportdate'];
      transtime.text = documentSnapshot['transporttime'];
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          transdate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: () async {
                      TimeOfDay? tm = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (tm != null) {
                        setState(() {
                          transtime.text = tm.format(context);
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
                      final String ttype = transtype.text;
                      final String tdate = transdate.text;
                      final String ttime = transtime.text;
                      await _transport.doc(documentSnapshot!.id).update({
                        "transporttype": ttype,
                        "transportdate": tdate,
                        "transporttime": ttime,
                      });
                      transtype.text = '';
                      transdate.text = '';
                      transtime.text = '';
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Transport'),
                    onPressed: () { _deleteTransport(documentSnapshot!.id);
                    Navigator.of(context).pop();
                    }
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _deleteTransport(String productId) async {
    await _transport.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Transport Deleted!")));
  }

  @override
  void initState() {
    tripId = widget.tripid;

    _transport = FirebaseFirestore.instance
        .collection("trip")
        .doc("$tripId")
        .collection("transport");
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
        title: Text('Transports'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _transport.snapshots(),
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
                              "assets/images/img_1.png",
                              // "assets/images/vehicles.png",
                              height: 40,
                              color: kPrimaryColor,
                            ),
                            title: Text(
                                " ${documentSnapshot['transporttype']}\n"),
                            subtitle: Text(
                                "Date: ${documentSnapshot['transportdate']} "
                                    "Time: ${documentSnapshot['transporttime']}"),
                            trailing: SizedBox(
                              width: 55,
                              height: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    // => _updateTransport(documentSnapshot),
                                    icon: Icon(
                                      Icons.edit_note,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _updateTransport(documentSnapshot),
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
