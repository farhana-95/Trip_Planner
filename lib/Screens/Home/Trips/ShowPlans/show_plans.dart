import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/addplan_details.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_accomodation.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_activity.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_notes.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_restaurant.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_transport.dart';
import '../../../../constants.dart';

class ShowPlans extends StatefulWidget {
  const ShowPlans({Key? key, required this.tripid}) : super(key: key);
  final int tripid;

  @override
  State<ShowPlans> createState() => _ShowPlansState();
}

class _ShowPlansState extends State<ShowPlans> {
  static int tripId = 0;

  @override
  void initState() {
    tripId = widget.tripid;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                    alignment: Alignment.center,

                    image: AssetImage("assets/images/events.jpg")
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                height: 120,
                width: 350,
                child: Center(child: Text("Activities/\nEvents",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowActivity(tripid: widget.tripid))),
            ),
            const Divider(height: 1,indent: 15,endIndent: 15,),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      image: AssetImage("assets/images/tsport.jpg")
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.only(left: 18, right: 18, top: 15),
                height: 120,
                width: 350,
                child: Center(child: Text("Transports",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowTransport(tripid: widget.tripid))),
            ),
            const Divider(height: 1,indent: 15,endIndent: 15,),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      image: AssetImage("assets/images/res.jpg")
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(left: 18, right: 18, top: 15),
                height: 120,
                width: 350,
                child: Center(child: Text("Restaurants/Meals",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowRestaurant(tripid: widget.tripid))),
            ),
            const Divider(height: 1,indent: 15,endIndent: 15,),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      image: AssetImage("assets/images/hotels.jpg")
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(left: 18, right: 18, top: 15),
                height: 120,
                width: 350,
                child: Center(child: Text("Accommodations",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowAccommodation(tripid: widget.tripid))),
            ),
            const Divider(height: 1,indent: 15,endIndent: 15,),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      image: AssetImage("assets/images/note.jpg")
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.only(left: 18, right: 18, top: 15),
                height: 120,
                width: 350,
                child: Center(child: Text("Notes",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowNotes(tripid: widget.tripid))),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            //Navigator.pop(context);
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PlanDetails(tripid: tripId);
                  },
                ),
              );
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
