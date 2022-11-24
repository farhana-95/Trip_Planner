import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_model.dart';

class CommonService {
  final DocumentReference<Map<String, dynamic>> _category =
  FirebaseFirestore.instance.collection('category').doc("0");

  Future saveCategories() async {
    try {
      _category.set({
        "Item": catList.map<Map>((e) => e.toMap()).toList(),
      });
    } catch (e) {
      return "false";
    }
  }

  Future<List<Cat>> retrieveCategories() async {
    List<Cat> catList = [];

    try {
      var querySnapshot = await _category.get();
      final Map<String, dynamic>? allData = querySnapshot.data();

      allData?["Item"].forEach((child) {
        Cat cat =  Cat(id: child["id"], name: child["name"], icon: child["icon"]);
        catList.add(cat);
      });
      return catList;
    } catch (e) {
      return catList;
    }
  }
}

final List<Cat> catList = [
  Cat(id: 0, name: 'Meal', icon: 0xf2e7),
  Cat(id: 1, name: 'Transport', icon: 0xe58f),
  Cat(id: 2, name: 'Lodging', icon: 0xe3af),
  Cat(id: 3, name: 'Ticket', icon: 0xf145),
  Cat(id: 4, name: 'Snacks', icon: 0xf818),
  Cat(id: 5, name: 'Tips', icon: 0xf4c0),
  Cat(id: 6, name: 'Event', icon: 0xf7c5),
  Cat(id: 7, name: 'Shopping', icon: 0xf218),
  Cat(id: 8, name: 'Health', icon: 0xf0f1),
  Cat(id: 9, name: 'Others', icon: 0xf53a),
];
