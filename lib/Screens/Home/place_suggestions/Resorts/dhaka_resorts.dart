import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class dhaka_resorts extends StatefulWidget {
  final id;
  const dhaka_resorts({Key? key,this.id}) : super(key: key);

  @override
  State<dhaka_resorts> createState() => _dhaka_resortsState();
}

class _dhaka_resortsState extends State<dhaka_resorts> {
  @override
  void initState(){
    super.initState();
    // rid=widget.id;
    // print("rId  ==== $rid");
    // _resort = FirebaseFirestore.instance
    //     .collection("place")
    //     .doc(rId)
    //     .collection("resort");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Resorts'),backgroundColor: kPrimaryColor,),
        body: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('dhaka_resorts').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, int index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                      return  GestureDetector(
                        child: Container(
                          margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Card(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 12, right: 6),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(
                                            Icons.home_work_outlined,
                                            color: Color(0xFF868585),
                                            size: 19,
                                          ),
                                        ),
                                        TextSpan(text: '    '),
                                        TextSpan(
                                          text:
                                          '${documentSnapshot['name']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF868585)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Divider(
                                  height: 20,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 14, right: 6),
                                  child: Text(
                                    "View Details",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {

                          showModalBottomSheet<dynamic>(
                              enableDrag: true,
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(23.0),
                                  topRight: Radius.circular(23.0),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                  MediaQuery.of(context).size.height * .96,
                                  // padding:
                                  // const EdgeInsets.only(left: 18, right: 15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            child: Image.network('${documentSnapshot['image']}',fit: BoxFit.cover,)),
                                        const Divider(
                                          height: 30,
                                          indent: 1,
                                        ),
                                        Container(
                                          margin:
                                          const EdgeInsets.only(left: 15, right: 6),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.orangeAccent,
                                                    size: 17,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  '${documentSnapshot['address']}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xFF868585)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          margin:
                                          const EdgeInsets.only(left: 15, right: 6),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    Icons.monetization_on,
                                                    color: Colors.orangeAccent,
                                                    size: 17,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  '${documentSnapshot['price']}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xFF868585)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          margin:
                                          const EdgeInsets.only(left: 15, right: 6),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.orangeAccent,
                                                    size: 18,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  '${documentSnapshot['rating']}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xFF868585)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                      // Card(child: Text("Place Name ${documentSnapshot['name']}"));
                    },
                  );
                }
                return const Center(
                  child:Text('No Saved Trip'),
                );
              },
            ),)
          ],
        )
    );
  }
}
