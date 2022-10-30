import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'package:trip_planner/constants.dart';
import 'package:trip_planner/services/auth.dart';

import 'Welcome/welcome_screen.dart';
=======
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/Screens/Home/main_screen.dart';
import 'package:trip_planner/Screens/Login/components/login_form.dart';

import 'package:trip_planner/constants.dart';

import 'Screens/Welcome/welcome_screen.dart';

>>>>>>> f193b94 (first commit)

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
<<<<<<< HEAD
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
=======
  final prefs =await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn')?? false;
  runApp( MyApp(isLoggedIn: isLoggedIn));}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
>>>>>>> f193b94 (first commit)

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
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
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
<<<<<<< HEAD
      home: const WelcomeScreen(),
=======
      home: isLoggedIn? const WelcomeScreen():const MainScreen() ,
>>>>>>> f193b94 (first commit)
    );
  }
}
