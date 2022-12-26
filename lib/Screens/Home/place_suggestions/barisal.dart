import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/Resorts/Mynensingh.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/Resorts/barisal_resorts.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/Restaurants/barisal_restaurants.dart';
import 'package:trip_planner/constants.dart';

import '../Trips/add_trips.dart';
import 'Restaurants/Mymensingh_restaurants.dart';

class Barisal extends StatefulWidget {
  const Barisal({Key? key}) : super(key: key);

  @override
  State<Barisal> createState() => _BarisalState();
}

class _BarisalState extends State<Barisal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places in Barisal'),backgroundColor: kPrimaryColor,),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('barisal').snapshots(),
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
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(22),
                                    bottom: Radius.circular(15))),
                            child: Image.network(
                                '${documentSnapshot['image']}',
                                fit: BoxFit.fill),
                          ),
                          Container(
                            margin:
                            const EdgeInsets.only(left: 12, right: 6),
                            child: Text(
                              "\n${documentSnapshot['name']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            margin:
                            const EdgeInsets.only(left: 10, right: 6),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xFF868585),
                                      size: 17,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    '${documentSnapshot['area']}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF868585)),
                                  ),
                                ],
                              ),
                            ),
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
                              "Rating: ${documentSnapshot['rate']}",
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
                            padding:
                            const EdgeInsets.only(left: 18, right: 15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "\n${documentSnapshot['name']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const Divider(
                                    height: 30,
                                    indent: 1,
                                    endIndent: 180,
                                    thickness: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  Text(
                                    "${documentSnapshot['about']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        wordSpacing: 5,
                                        color: Color(0xFF595858)),
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.only(top: 28),
                                  //   child: const Text(
                                  //     "Tourist Attractions",
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  // const Divider(
                                  //   height: 30,
                                  //   indent: 160,
                                  //   endIndent: 1,
                                  //   thickness: 2,
                                  //   color: Colors.green,
                                  // ),
                                  // Text(
                                  //   "${documentSnapshot['attractions']}",
                                  //   style: const TextStyle(
                                  //       fontSize: 16,
                                  //       height: 1.6,
                                  //       wordSpacing: 5,
                                  //       color: Color(0xFF595858)),
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                      margin:
                                      const EdgeInsets.only(top: 15),
                                      child: const Text(
                                        "Tourist Time:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const Divider(
                                    height: 30,
                                    indent: 1,
                                    endIndent: 265,
                                    thickness: 1.5,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    ' ${documentSnapshot['time']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        wordSpacing: 5,
                                        color: Color(0xFF595858)),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 8,),
                                      GestureDetector(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xE7B578EF),
                                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                              ),

                                              height: 80,
                                              width: 160,

                                              child: Center(child: Text('Resorts',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),))
                                          ),
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => barisal_resorts(id: documentSnapshot.id)));
                                            print("RESORT ID = ${documentSnapshot.id}");
                                          }


                                        //Resort2(id: "$documentSnapshot"),
                                      ),
                                      SizedBox(width: 12,),
                                      GestureDetector(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0x8D319BFF),
                                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                              ),

                                              height: 80,
                                              width: 160,

                                              child: Center(child: Text('Restaurants',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),))
                                          ),
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => BarisalRestaurants(id: documentSnapshot.id)));
                                            print("REST ID = ${documentSnapshot.id}");
                                          }


                                        //Resort2(id: "$documentSnapshot"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),


                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 216, right: 9, top: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => AddTrips(
                                                name:
                                                "${documentSnapshot['name']}",
                                                area:
                                                "${documentSnapshot['area']}",
                                                image:
                                                "${documentSnapshot['image']}")));
                                      },
                                      child: Row(
                                        children: const [
                                          Text("Add to Trip"),
                                          Icon(Icons.add),
                                        ],
                                      ),
                                    ),
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
            child:Text(''),
          );
        },
      ),
    );
  }
}
