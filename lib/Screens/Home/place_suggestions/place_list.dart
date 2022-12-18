import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/barisal.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/chittagong.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/dhaka.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/khulna.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/mymensingh.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_model.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_service.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/rajshahi.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/sylhet.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  PlaceService placeService = PlaceService();
  List<PlaceModel> _placeData = [];
  List<PlaceModel> newPlaceList = [];

  @override
  void initState() {
    super.initState();
    placeService.getPlaceListData().then((val) {
      setState(() {
        if (val != null) {
          _placeData = val;
        }
      });
    });
  }

  void _onItemChanged(String value) {
    setState(() {
      newPlaceList = _placeData.where((val) {
        return val.name!.toLowerCase().contains(value.toLowerCase());
      }).toList();
      //  print("search  ${}")
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 17,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/chittagong.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Chittagong',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Chittagong())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/dhaka.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Dhaka',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dhaka())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/khulna.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Khulna',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Khulna())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/syl.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Sylhet',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Sylhet())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/Barisal_alin.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Barisal',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Barisal())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/rajshahiii.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Rajshahi',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Rajshahi())),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/mymen.jpg")),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Text(
                  'Mymensingh',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Mymensingh())),
            ),
          ),
        ],
      ),
    )
        //     Center(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //     child: Column(
        //       children: <Widget>[
        //         TextFormField(
        //           decoration: const InputDecoration(
        //             suffixIcon: Icon(Icons.search),
        //             hintText: 'Search ',
        //           ),
        //           onChanged: _onItemChanged,
        //         ),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         Expanded(
        //           child: ListView.builder(
        //               itemCount: newPlaceList.isEmpty
        //                   ? _placeData.length
        //                   : newPlaceList.length,
        //               itemBuilder: (BuildContext context, int i) {
        //
        //                 return
        //                   GestureDetector(
        //                   child: Container(
        //                     margin:
        //                         const EdgeInsets.only(left: 10, right: 10, top: 10),
        //                     child: Card(
        //                       elevation: 5,
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(20.0),
        //                       ),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           Container(
        //                             clipBehavior: Clip.antiAliasWithSaveLayer,
        //                             decoration: const BoxDecoration(
        //                                 borderRadius: BorderRadius.vertical(
        //                                     top: Radius.circular(22),
        //                                     bottom: Radius.circular(15))),
        //                             child: Image.network(
        //                                 '${newPlaceList.isEmpty ? _placeData[i].image : newPlaceList[i].image}',
        //                                 fit: BoxFit.fill),
        //                           ),
        //                           Container(
        //                             margin:
        //                                 const EdgeInsets.only(left: 12, right: 6),
        //                             child: Text(
        //                               "\n${newPlaceList.isEmpty ? _placeData[i].name : newPlaceList[i].name}",
        //                               style: const TextStyle(
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 16),
        //                             ),
        //                           ),
        //                           const SizedBox(
        //                             height: 8,
        //                           ),
        //                           Container(
        //                             margin:
        //                                 const EdgeInsets.only(left: 10, right: 6),
        //                             child: Text.rich(
        //                               TextSpan(
        //                                 children: [
        //                                   const WidgetSpan(
        //                                     child: Icon(
        //                                       Icons.location_on,
        //                                       color: Color(0xFF868585),
        //                                       size: 17,
        //                                     ),
        //                                   ),
        //                                   TextSpan(
        //                                     text:
        //                                         '${newPlaceList.isEmpty ? _placeData[i].area : newPlaceList[i].area}',
        //                                     style: const TextStyle(
        //                                         fontSize: 15,
        //                                         color: Color(0xFF868585)),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                           const Divider(
        //                             height: 20,
        //                             indent: 10,
        //                             endIndent: 10,
        //                           ),
        //                           Container(
        //                             margin:
        //                                 const EdgeInsets.only(left: 14, right: 6),
        //                             child: Text(
        //                               "Rating: ${newPlaceList.isEmpty ? _placeData[i].rate : newPlaceList[i].rate}",
        //                               style: const TextStyle(
        //                                 fontSize: 14,
        //                                 color: Colors.blue,
        //                               ),
        //                             ),
        //                           ),
        //                           const SizedBox(
        //                             height: 15,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   onTap: () {
        //
        //                     showModalBottomSheet<dynamic>(
        //                         enableDrag: true,
        //                         context: context,
        //                         isScrollControlled: true,
        //                         shape: const RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.only(
        //                             topLeft: Radius.circular(23.0),
        //                             topRight: Radius.circular(23.0),
        //                           ),
        //                         ),
        //                         builder: (BuildContext context) {
        //                           return Container(
        //                             height:
        //                                 MediaQuery.of(context).size.height * .96,
        //                             padding:
        //                                 const EdgeInsets.only(left: 18, right: 15),
        //                             child: SingleChildScrollView(
        //                               scrollDirection: Axis.vertical,
        //                               child: Column(
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: <Widget>[
        //                                   Text(
        //                                     "\n${newPlaceList.isEmpty ? _placeData[i].name : newPlaceList[i].name}",
        //                                     style: const TextStyle(
        //                                         fontWeight: FontWeight.bold,
        //                                         fontSize: 16),
        //                                   ),
        //                                   const Divider(
        //                                     height: 30,
        //                                     indent: 1,
        //                                     endIndent: 180,
        //                                     thickness: 2,
        //                                     color: Colors.blueAccent,
        //                                   ),
        //                                   Text(
        //                                     "${newPlaceList.isEmpty ? _placeData[i].about : newPlaceList[i].about}",
        //                                     style: const TextStyle(
        //                                         fontSize: 16,
        //                                         height: 1.6,
        //                                         wordSpacing: 5,
        //                                         color: Color(0xFF595858)),
        //                                   ),
        //                                   Container(
        //                                     margin: const EdgeInsets.only(top: 28),
        //                                     child: const Text(
        //                                       "Tourist Attractions",
        //                                       style: TextStyle(
        //                                           fontWeight: FontWeight.bold),
        //                                     ),
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   const Divider(
        //                                     height: 30,
        //                                     indent: 160,
        //                                     endIndent: 1,
        //                                     thickness: 2,
        //                                     color: Colors.green,
        //                                   ),
        //                                   Text(
        //                                     "${newPlaceList.isEmpty ? _placeData[i].attractions : newPlaceList[i].attractions}",
        //                                     style: const TextStyle(
        //                                         fontSize: 16,
        //                                         height: 1.6,
        //                                         wordSpacing: 5,
        //                                         color: Color(0xFF595858)),
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Container(
        //                                       margin:
        //                                           const EdgeInsets.only(top: 15),
        //                                       child: const Text(
        //                                         "Tourist Time:",
        //                                         style: TextStyle(
        //                                             fontWeight: FontWeight.bold),
        //                                       )),
        //                                   const Divider(
        //                                     height: 30,
        //                                     indent: 1,
        //                                     endIndent: 265,
        //                                     thickness: 1.5,
        //                                     color: Colors.blue,
        //                                   ),
        //                                   Text(
        //                                     ' ${newPlaceList.isEmpty ? _placeData[i].time : newPlaceList[i].time}',
        //                                     style: const TextStyle(
        //                                         fontSize: 16,
        //                                         wordSpacing: 5,
        //                                         color: Color(0xFF595858)),
        //                                   ),
        //                                   Container(
        //                                     margin: const EdgeInsets.only(
        //                                         left: 216, right: 9, top: 10),
        //                                     child: ElevatedButton(
        //                                       onPressed: () {
        //                                         Navigator.of(context).push(MaterialPageRoute(
        //                                             builder: (context) => AddTrips(
        //                                                 name:
        //                                                     "${_placeData[i].name}",
        //                                                 area:
        //                                                     "${_placeData[i].area}",
        //                                                 image:
        //                                                     "${_placeData[i].image}")));
        //                                       },
        //                                       child: Row(
        //                                         children: const [
        //                                           Text("Add to Trip"),
        //                                           Icon(Icons.add),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           );
        //                         });
        //                   },
        //                 );
        //               }),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        );
  }
}
