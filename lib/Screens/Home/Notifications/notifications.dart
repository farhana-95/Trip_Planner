
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trip_planner/Screens/Home/Notifications/notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NotificationAlert extends StatefulWidget {
  const NotificationAlert({Key? key}) : super(key: key);

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  PageController controller=PageController();
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
      children:[
       Container(color: Colors.orangeAccent,),
        Container(color: Colors.brown,),
        Container(color: Colors.purple,),
        ]
    ),
      );
  }
}