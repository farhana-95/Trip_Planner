import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../notification_service.dart';
class SetAlarm {
  static NotificationService notificationService = NotificationService();

  static const String appName = "Alarm Manager Example";
  static const String durationSeconds = "Seconds";
  static const String oneShotAlarm = "oneShot";
  static const String oneShotAtAlarm = "oneShotAt";
  static const String periodicAlarm = "periodic";

  final int _oneShotTaskId = 1;
  final int _oneShotAtTaskId = 2;
  final int _periodicTaskId = 3;


  static void _oneShotTaskCallback() {
    print("One Shot Task Running");
  }

  static void _oneShotAtTaskCallback() {
    print("One Shot At Task Running");
    notificationService.showNotifications();
  }
   void cancelAlarm(){
    AndroidAlarmManager.cancel(_oneShotAtTaskId);
  }

  static void _periodicTaskCallback() {
    print("Periodic Task Running");
  }
   scheduleOneShotAlarm(String dateTime, bool isTimed) async {
     print("dateTime $dateTime");

     DateTime now = DateFormat('dd-MM-yyyy hh:mm a').parse(dateTime);
     print("dateTime $now");
    if (isTimed) {
      //DateTime chosenDate = await _chooseDate("");
      await AndroidAlarmManager.oneShotAt(now, _oneShotAtTaskId, _oneShotAtTaskCallback);
    } else {
      Duration duration = await _chooseDuration();
      await AndroidAlarmManager.oneShot(duration, _oneShotTaskId, _oneShotTaskCallback);
    }
  }
  void _schedulePeriodicAlarm() async {
    Duration duration = await _chooseDuration();
    await AndroidAlarmManager.periodic(duration, _periodicTaskId, _periodicTaskCallback);
  }
  Future<Duration> _chooseDuration() async {
    String duration = "10";
    String durationString = durationSeconds;

    if (duration != null) {
      int time = int.parse(duration);
      if (durationString == durationSeconds) {
        return Duration(seconds: time);
      }
    }
    return const Duration(seconds: 0);
  }

}