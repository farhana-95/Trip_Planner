import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_planner/Screens/Home/Notifications/Model/NotificationListModel.dart';

class Localdb {

  saveData(String tripid, String tripname, String location, String startdate, String startTime,
      String enddate, bool isReminder) async {

   // var box = await Hive.openBox('TripBox');
    var box = await Hive.openBox<NotificationListModel>('TripBox1');

    var notification = NotificationListModel(
        tripname: tripname,
        location: location,
        startdate: startdate,
        enddate: enddate,
        startdateTime: startTime,
        tripid: tripid);
    box.add(notification);
    notification.save();
  }

  Future<List<NotificationListModel>> getLocalData() async {
    //var box = await Hive.openBox('TripBox');
    var box = await Hive.openBox<NotificationListModel>('TripBox1');

    List<NotificationListModel>? notificationList = [];
    if(box.isNotEmpty) {
      List<NotificationListModel> hiveVitals = box.values.toList();
      notificationList = hiveVitals;

    } else {
      // empty state
      return notificationList;
    }
    return notificationList;
  }


}