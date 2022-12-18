import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(title: Text('Resorts'),),
        body: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('dhaka').doc(this.widget.id).collection('resort').snapshots(),
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
