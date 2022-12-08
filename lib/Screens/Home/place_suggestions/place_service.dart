import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_model.dart';

class PlaceService {
  Future<List<PlaceModel>?> getPlaceListData() async {
    var data = await FirebaseFirestore.instance.collection("places");

    List<PlaceModel> placeList = [];

    QuerySnapshot addPlaceQuerySnapshot = await data.get();

    final List<dynamic> addPlaceListData =
    addPlaceQuerySnapshot.docs.map((doc) => doc.data()).toList();

    List<PlaceModel> itemsList = List<PlaceModel>.from(addPlaceListData
        .map<PlaceModel>((dynamic i) => PlaceModel.fromJson(i)));
    placeList.addAll(itemsList);

    return placeList;
  }
}
