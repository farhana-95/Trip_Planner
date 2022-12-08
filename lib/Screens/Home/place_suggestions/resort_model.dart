import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_list.dart';

class ResortModel {
  String? name;


  ResortModel(
      {this.name,
       });

//receiving data from server
  factory ResortModel.fromMap(map) {
    return ResortModel(
      name: map['name'],

    );
  }

  static fromJson(i) {
    ResortModel resortModel = ResortModel(
      name: i["name"],
      );
    return resortModel;
  }
}
