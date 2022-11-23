import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_list.dart';
import 'package:trip_planner/Screens/page_appbar.dart';
import 'package:trip_planner/constants.dart';
import 'Notifications/notifications.dart';
import 'Profile/profile.dart';
import 'Trips/show_trip.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex= 0;
  List<Widget> pages = const [
    Trip(),
    PlaceList(),
    NotificationAlert(),
    profile(),
  ];
  List<Widget> pageAppbar = const [
    TripAppbar(),
    SuggestionAppBar(),
    NotificationAppbar(),
    ProfileAppbar(),
  ];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  pageAppbar[currentIndex],//Text("Home Page"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body:pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: kPrimaryLightColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.backpack, color: kPrimaryColor,),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color: kPrimaryColor ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_on,color: kPrimaryColor ),
                label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,color: kPrimaryColor),
              label: '',)
          ],

          onTap: (value) async{
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn',false);

            setState(() {
              currentIndex =  value;

            });}
      ),
    );

  }
}
