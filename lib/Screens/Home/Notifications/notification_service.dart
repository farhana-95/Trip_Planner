import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');


    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
                macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);

  }

  AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    'channel ID',
    'channel name',
    //'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Are You Ready?",
      "You have an upcoming trip ",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification( payload) async {
  //handle your logic here
}

// class NotificationService {
//   //NotificationService a singleton object
//   static final NotificationService _notificationService =
//   NotificationService();
//
//   factory NotificationService() {
//     return _notificationService;
//   }
//
//   static const channelId = '123';
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         //iOS: initializationSettingsIOS,
//         macOS: null);
//
//     tz.initializeTimeZones();
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     );
//   }
//
//   static const AndroidNotificationDetails _androidNotificationDetails =
//    AndroidNotificationDetails(
//     'channel ID',
//     'channel name',
//     //'channel description',
//     playSound: true,
//     priority: Priority.high,
//     importance: Importance.high,
//   );
//
//   Future<void> showNotifications() async {
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       "Notification Title",
//       "This is the Notification Body!",
//       const NotificationDetails(android: _androidNotificationDetails),
//     );
//   }
//
//   Future<void> scheduleNotifications() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         "scheduled",
//         "This is the Notification Body!",
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
//         const NotificationDetails(android: _androidNotificationDetails),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//   }
//
//   // Future<void> cancelNotifications(int id) async {
//   //   await flutterLocalNotificationsPlugin.cancel(id);
//   // }
//
//   // Future<void> cancelAllNotifications() async {
//   //   await flutterLocalNotificationsPlugin.cancelAll();
//   // }
// }
//
// Future<void> onSelectNotification(String? payload) async {
//  }
