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

 PlaceService placeService = PlaceService();
  List<PlaceModel> _placeData = [];
 List<PlaceModel> newPlaceList = [];
 List<PlaceModel> placeList = [];

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
                decoration: const InputDecoration(
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
                          margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
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
                                          top: Radius.circular(22),bottom: Radius.circular(15))),
                                  child: Image.network('${newPlaceList.isEmpty ? _placeData[i].image : newPlaceList[i].image}',
                                      fit: BoxFit.fill),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12,right: 6),
                                  child: Text(
                                    "\n${newPlaceList.isEmpty ? _placeData[i].name : newPlaceList[i].name }",
                                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10,right: 6),

                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Icon(Icons.location_on,color: Color(0xFF868585),size: 17,),
                                        ),
                                        TextSpan(
                                          text: '${newPlaceList.isEmpty ? _placeData[i].area : newPlaceList[i].area}',
                                          style: const TextStyle(fontSize: 15,color: Color(0xFF868585)
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(height: 20,indent: 10,endIndent: 10,),
                                Container(
                                  margin: const EdgeInsets.only(left: 14,right: 6),
                                  child: Text(
                                    "Rating: ${newPlaceList.isEmpty ? _placeData[i].rate : newPlaceList[i].rate }",
                                    style: const TextStyle(fontSize: 14,color: Colors.blue,),
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
                          showModalBottomSheet<dynamic>(context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(23.0),
                                  topRight: Radius.circular(23.0),
                                ),
                              ),
                              builder: (BuildContext context){

                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.78,

                                  padding: const EdgeInsets.only(left: 18,right: 15),
                                  child: SingleChildScrollView(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children:<Widget> [
                                         Text( "\n${newPlaceList.isEmpty ? _placeData[i].name : newPlaceList[i].name }",
                                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                                        const Divider(height: 20,indent: 1,endIndent: 180,thickness: 2,color: Colors.blueAccent,),

                                        Text("${newPlaceList.isEmpty ? _placeData[i].about : newPlaceList[i].about }",
                                          style: const TextStyle(fontSize: 16,height: 1.5),),

                                        Container(
                                          margin: const EdgeInsets.only(top: 28),
                                          child: const Text("Tourist Attractions",style: TextStyle(fontWeight: FontWeight.bold),),),
                                        const Divider(height: 20,indent: 160,endIndent: 1,thickness: 2,color: Colors.green,),

                                        Text("${newPlaceList.isEmpty ? _placeData[i].attractions : newPlaceList[i].attractions }",
                                          style: const TextStyle(fontSize: 16,height: 1.5),),

                                        Container(margin: const EdgeInsets.only(top: 15),
                                            child: const Text("Tourist Time:",style: TextStyle(fontWeight: FontWeight.bold),)),
                                        const Divider(height: 20,indent: 1,endIndent: 265,thickness: 1.5,color: Colors.blue,),
                                        Text(' ${newPlaceList.isEmpty ? _placeData[i].time : newPlaceList[i].time }',style: const TextStyle(fontSize: 16),),
                                        Container(
                                          margin: const EdgeInsets.only(left: 216,right: 9,top: 10),
                                          child: ElevatedButton(
                                              onPressed: (){
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (context) => AddTrips(name: "${_placeData[i].name}",
                                                  area: "${_placeData[i].area}",
                                                    image: "${_placeData[i].image}")));
                                          },
                                              child: Row(
                                                children: const [
                                                  Text("Add to Trip"),
                                                  Icon(Icons.add),
                                                ],
                                              ),
                                          ),
                                        ),
                                      ],
                                    ),
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
