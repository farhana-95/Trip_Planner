import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarisalRestaurants extends StatefulWidget {
  final id;
  const BarisalRestaurants({Key? key,this.id}) : super(key: key);

  @override
  State<BarisalRestaurants> createState() => _BarisalRestaurantsState();
}

class _BarisalRestaurantsState extends State<BarisalRestaurants> {
  late final CollectionReference _restaurant;
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
        appBar: AppBar(title: Text('Restuarants'),),
        body: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('barisal').doc(this.widget.id).collection('restaurants').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      print('NAME    ${documentSnapshot['name']}');

                      return  Card(
                        child: Text('${documentSnapshot['name']}'),
                      );
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