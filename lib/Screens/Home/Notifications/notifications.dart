import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Calender/calendar.dart';
import 'package:trip_planner/Screens/Home/Notifications/notification_service.dart';
class NotificationAlert extends StatefulWidget {
  const NotificationAlert({Key? key}) : super(key: key);
  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  NotificationService _notificationService = NotificationService();

    @override
    Widget build(BuildContext context) {
    return Scaffold(
       body:
       // Calendar(),
       // NewPlan(),
       Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           ElevatedButton(
             child: Text('Show Notification'),
             //padding: const EdgeInsets.all(10),
             onPressed: () async {
               await _notificationService.showNotifications();
             },
           ),
           SizedBox(height: 3),
           ElevatedButton(
             child: Text('Schedule Notification'),
             // padding: const EdgeInsets.all(10),
             onPressed: () async {
               await _notificationService.scheduleNotifications();
             },
           ),
           SizedBox(height: 3),
           ElevatedButton(
             child: Text('Cancel Notification'),
             //padding: const EdgeInsets.all(10),
             onPressed: () async {
               await _notificationService.cancelNotifications(0);
             },
           ),
           SizedBox(height: 3),
           ElevatedButton(
             child: Text('Cancel All Notifications'),
             //padding: const EdgeInsets.all(10),
             onPressed: () async {
               await _notificationService.cancelAllNotifications();
             },
           ),
           SizedBox(height: 3),
         ],
       ),
    );
  }
}

