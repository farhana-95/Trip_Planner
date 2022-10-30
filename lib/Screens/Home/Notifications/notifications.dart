
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trip_planner/Screens/Home/Notifications/notifications.dart';


class NotificationAlert extends StatefulWidget {
  const NotificationAlert({Key? key}) : super(key: key);

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  @override

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          children: [

          ],
        )
        ,)
      );
  }
}