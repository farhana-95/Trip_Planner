import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/place_list.dart';
import 'package:trip_planner/Screens/page_appbar.dart';
import 'package:trip_planner/constants.dart';
import 'Notifications/notifications.dart';
import 'Profile/profile.dart';
import 'Trips/Expense/Category/category_model.dart';
import 'Trips/show_trip.dart';

class MainScreen extends StatefulWidget {
   MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  List<Cat> catList =  [];
  int currentIndex= 0;

  List<Widget> pages =  [
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
  void initState() {

    // uId= getCurrentUser();
    // print("Iddd     $uId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: pageAppbar[currentIndex]),//Text("Home Page"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body:pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.cases_rounded, color: kPrimaryColor,),
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
