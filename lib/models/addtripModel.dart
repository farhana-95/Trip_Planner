
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_planner/Screens/Home/Trips/add_trips.dart';

class tripModel {
  String? tripname;
  String? location;
  String? startdate;
  String? enddate;
  tripModel({this.tripname, this.location, this.startdate, this.enddate});

 //receiving data from server
  factory tripModel.fromMap(map){
    return tripModel(
      tripname: map['tripname'],
      location: map['location'],
      startdate: map['startdate'],
      enddate: map['enddate'],

    );
  }
//sending data to server
  Map<String, dynamic> toMap(){
    return{
      'tripname': tripname,
      'location': location,
      'startdate': startdate,
      'enddate': enddate
    };
  }

}*/
/*
final CollectionReference _products=
FirebaseFirestore.instance.collection('products');
Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
  if(documentSnapshot != null) {

    _tripname=documentSnapshot['tripname'];
    _location=documentSnapshot['location'];
     _startdate=documentSnapshot['startdate'];
     _enddate=documentSnapshot['enddate'];

  }
*/
