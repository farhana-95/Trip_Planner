import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_model.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_service.dart';
import '../Trips/add_trips.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}
class _PlaceListState extends State<PlaceList> {

 PlaceService placeService = new PlaceService();
  List<PlaceModel> _placeData = [];
 List<PlaceModel> newPlaceList = [];

 final TextEditingController _searchController = TextEditingController();
 List<PlaceModel> placeList = [];
 final FocusNode _textFocusNode = FocusNode();

 @override
 void initState() {
   super.initState();
   placeService.getPlaceListData().then((val) {
     setState(() {
       if(val!= null){
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
      body:
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children:<Widget> [
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search ',
                ),
                onChanged: _onItemChanged,
              ),
              const SizedBox(height: 10,),
              Expanded(
                child:
                ListView.builder(itemCount: newPlaceList.isEmpty ? _placeData.length : newPlaceList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration:const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(22))),
                                  child: Image.network('${newPlaceList.isEmpty ? _placeData[i].image : newPlaceList[i].image}',
                                      fit: BoxFit.fill),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 7),
                                  child: Text(
                                    "\n${newPlaceList.isEmpty ? _placeData[i].name : newPlaceList[i].name }",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 7),
                                  child: Text(
                                    "Location: ${newPlaceList.isEmpty ? _placeData[i].area : newPlaceList[i].area }",
                                    style: const TextStyle(fontSize: 15,color: Color(0xFF868585)),
                                  ),

                                ),const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 7),
                                  child: Text(
                                    "Rating: ${newPlaceList.isEmpty ? _placeData[i].rate : newPlaceList[i].rate }",
                                    style: const TextStyle(fontSize: 14,color: Colors.blue),
                                  ),

                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          showModalBottomSheet(context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(23.0),
                                  topRight: Radius.circular(23.0),
                                ),
                              ),
                              builder: (BuildContext context){

                                return Container(
                                  padding: const EdgeInsets.only(left: 16,top: 10,right: 13),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Description:\n\n",
                                        style: TextStyle(color: Color(0xFF868585),fontWeight: FontWeight.bold,fontSize: 16),),
                                      Expanded(child: Text("${newPlaceList.isEmpty ? _placeData[i].about : newPlaceList[i].about }",
                                        style: const TextStyle(fontSize: 16,height: 1.5),)),
                                      Text('Tourist Time: ${newPlaceList.isEmpty ? _placeData[i].time : newPlaceList[i].time }',style: TextStyle(fontSize: 16),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 230,top: 18),
                                        child: ElevatedButton(onPressed: (){
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                              builder: (context) => AddTrips(name: "${_placeData[i].name}",area: "${_placeData[i].area}",)));

                                        },
                                            child: Row(
                                              children: const [
                                                Text("Add to Trip"),
                                                Icon(Icons.add),
                                              ],
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      )
    );

  }
}
