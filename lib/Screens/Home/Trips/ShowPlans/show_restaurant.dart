import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants.dart';

class ShowRestaurant extends StatefulWidget {
   ShowRestaurant({Key? key, required this.tripid}) : super(key: key);
  final int tripid;


  @override
  State<ShowRestaurant> createState() => _ShowRestaurantState();
}

class _ShowRestaurantState extends State<ShowRestaurant> {
  static int tripId = 0;

  late final CollectionReference _restaurant;

  final restname = TextEditingController();
  final resadd = TextEditingController();
  final restdate = TextEditingController();
  final restime = TextEditingController();
  Future<void> _updateRestaurant([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      restname.text = documentSnapshot['restname'];
      resadd.text = documentSnapshot['resadd'];
      restdate.text = documentSnapshot['restdate'];
      restime.text = documentSnapshot['restime'];
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
                    controller: restname,
                    keyboardType: TextInputType.name,
                    decoration:
                    const InputDecoration(labelText: 'Restaurant: '),
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
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          restdate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
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
                    onTap: () async {
                      TimeOfDay? tm = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (tm != null) {
                        setState(() {
                          restime.text = tm.format(context);
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
                      final String rname = restname.text;
                      final String radd = resadd.text;
                      final String rdate = restdate.text;
                      final String rtime = restime.text;
                      await _restaurant.doc(documentSnapshot!.id).update({
                        "restname": rname,
                        "resadd": radd,
                        "restdate": rdate,
                        "restime": rtime
                      });
                      restname.text = '';
                      resadd.text = '';
                      restdate.text = '';
                      restime.text = '';
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Delete Restaurant'),
                    onPressed: () { _deleteRestaurant(documentSnapshot!.id);
                    Navigator.of(context).pop();
                    }
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _deleteRestaurant(String productId) async {
    await _restaurant.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Restaurant Deleted!")));
  }

  @override
  void initState() {
    tripId = widget.tripid;
    _restaurant = FirebaseFirestore.instance
        .collection("trip")
        .doc("$tripId")
        .collection("restaurant");
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
        title: Text('Restuarants/Meals'),
      ),
      body: Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _restaurant.snapshots(),
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
                            "assets/images/img_2.png",
                            color: kPrimaryColor,
                            height: 40,
                          ),
                          title: Text(
                              " ${documentSnapshot['restname']}\n"),
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
                                  onPressed: () {},
                                  // => _updateRestaurant(documentSnapshot),
                                  icon: Icon(
                                    Icons.edit_note,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () => _updateRestaurant(documentSnapshot),
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
    ),);
  }
}
