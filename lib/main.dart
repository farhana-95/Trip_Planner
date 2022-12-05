
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/Notifications/Model/NotifiacationAdopter.dart';
import 'package:trip_planner/Screens/Home/Notifications/notification_service.dart';
import 'package:trip_planner/Screens/Home/main_screen.dart';
import 'package:trip_planner/constants.dart';
import 'package:workmanager/workmanager.dart';

import 'Screens/Welcome/welcome_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  NotificationService().init();
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationAdopter());
  await Hive.openBox('TripBox');

  await AndroidAlarmManager.initialize();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: kPrimaryColor,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        //fillColor: kPrimaryLightColor,
        iconColor: kPrimaryColor,
        prefixIconColor: kPrimaryColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      )
      ),
      home: email == null ? WelcomeScreen() : MainScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
     // home: const WelcomeScreen() ,

    );
  }
}
