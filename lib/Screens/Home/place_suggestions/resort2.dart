import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Resort2 extends StatefulWidget {
  final id;
  const Resort2({Key? key,this.id}) : super(key: key);

  @override
  State<Resort2> createState() => _Resort2State();
}

class _Resort2State extends State<Resort2> {
  late final CollectionReference _resort;
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
      appBar: AppBar(title: Text('Resorts'),),
      body: Column(
        children: [
          Expanded(child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('places').doc(this.widget.id).collection('resort').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

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
