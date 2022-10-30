import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SendNotification{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin
  =FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings=
  AndroidInitializationSettings('logo');

  void initialiseNotifications()async{
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize((initializationSettings));
  }
  void send(String title, String body)async{
    AndroidNotificationDetails androidNotificationDetails
    = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        notificationDetails);
  }
  void schedule(String title, String body)async{
    AndroidNotificationDetails androidNotificationDetails
    = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        title,
        body,
        RepeatInterval.everyMinute,
        notificationDetails);
  }
}