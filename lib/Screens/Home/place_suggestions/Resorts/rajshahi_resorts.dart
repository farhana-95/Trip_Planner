import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class rajshahi_resorts extends StatefulWidget {
  final id;
  const rajshahi_resorts({Key? key,this.id}) : super(key: key);

  @override
  State<rajshahi_resorts> createState() => _rajshahi_resortsState();
}

class _rajshahi_resortsState extends State<rajshahi_resorts> {
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
              stream: FirebaseFirestore.instance.collection('rajshahi').doc(this.widget.id).collection('resort').snapshots(),
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