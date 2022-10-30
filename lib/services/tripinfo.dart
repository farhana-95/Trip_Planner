
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/addtripModel.dart';

showtrip(String tripname,String location,String startdate, String enddate) async {
  // calling our firestore
  // calling our user model
  // sedning these values
  final CollectionReference _trip=
  FirebaseFirestore.instance.collection('trip');


  tripModel tripmodel = tripModel();

  // writing all the values
  tripmodel.tripname = tripname;
  tripmodel.location= location;
  tripmodel.startdate = startdate;
  tripmodel.enddate=enddate;


  await firebaseFirestore
      .collection("trip")
      .set(tripmodel.toMap());

  return "success!";
}*/