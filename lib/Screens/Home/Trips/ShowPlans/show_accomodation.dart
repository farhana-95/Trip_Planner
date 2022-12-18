import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

class ShowAccommodation extends StatefulWidget {
   ShowAccommodation({Key? key, required this.tripid}) : super(key: key);
  final int tripid;


  @override
  State<ShowAccommodation> createState() => _ShowAccommodationState();
}

class _ShowAccommodationState extends State<ShowAccommodation> {
  static int tripId = 0;

  late final CollectionReference _accomodation;

  final acmtitle = TextEditingController();
  final acmadd = TextEditingController();
  final acmin = TextEditingController();
  final acmout = TextEditingController();
  Future<void> _updateAcmd([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      acmtitle.text = documentSnapshot['acmtitle'];
      acmadd.text = documentSnapshot['acmadd'];
      acmin.text = documentSnapshot['acmin'];
      acmout.text = documentSnapshot['acmout'];
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
                    controller: acmtitle,
                    keyboardType: TextInputType.name,
                    decoration:
                    const InputDecoration(labelText: 'Accommodation: '),
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          acmin.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          acmout.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                      final String acmname = acmtitle.text;
                      final String acmad = acmadd.text;
                      final String acindate = acmin.text;
                      final String acoutdate = acmout.text;
                      await _accomodation.doc(documentSnapshot!.id).update({
                        "acmtitle": acmname,
                        "acmadd": acmad,
                        "acmin": acindate,
                        "acmout": acoutdate
                      });
                      acmtitle.text = '';
                      acmadd.text = '';
                      acmin.text = '';
                      acmout.text = '';
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Accomodation'),
                    onPressed: () { _deleteAcmd(documentSnapshot!.id);
                    Navigator.of(context).pop();
                    }
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _deleteAcmd(String productId) async {
    await _accomodation.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Accommodation Deleted!")));
  }

  @override
  void initState() {
    tripId = widget.tripid;

    _accomodation = FirebaseFirestore.instance
        .collection("trip")
        .doc("$tripId")
        .collection("accomodation");
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
        title: Text('Accommodations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _accomodation.snapshots(),
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
                            leading:
                            Image.asset("assets/images/img_3.png",color: kPrimaryColor,height: 42,),
                            title: Text(
                                "${documentSnapshot['acmtitle']}\n"),
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
                                    onPressed: () {},
                                    // => _updateAcmd(documentSnapshot),
                                    icon: Icon(
                                      Icons.edit_note,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _updateAcmd(documentSnapshot),
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
