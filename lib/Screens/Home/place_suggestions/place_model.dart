

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_list.dart';

class PlaceModel {
  String? name;
  String? area;
  String? about;
  String? image;
  String? rate;
  String? time;
  String? attractions;


  PlaceModel({this.name, this.area, this.about, this.image, this.rate,this.time,this.attractions});

//receiving data from server
  factory PlaceModel.fromMap(map){
    return PlaceModel(
      name: map['name'],
      area: map['area'],
      about: map['about'],
      image: map['image'],
      rate: map['rate'],
      time: map['time'],
      attractions: map['attractions'],

    );
  }
  static fromJson(i) {
    PlaceModel placeModel = PlaceModel(name: i["name"], area:  i["area"], about:  i["about"], image:  i["image"],rate: i["rate"],time: i["time"],attractions: i["attractions"]);
    return placeModel;

  }
}