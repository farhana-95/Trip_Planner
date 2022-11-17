import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_planner/Screens/Home/Notifications/Model/NotificationListModel.dart';

class Localdb {

  saveData(String tripid, String tripname, String location, String startdate, String startTime,
      String enddate, bool isReminder) async {

   // var box = await Hive.openBox('TripBox');
    var box = await Hive.openBox<NotificationListModel>('TripBox1');

    var notification = NotificationListModel(tripname: tripname, location: location, startdate: startdate, enddate: enddate, startdateTime: startTime, tripid: tripid);
    box.add(notification);

    print(box.getAt(0)?.tripname); // Dave - 22

    notification.save();

    print(box.getAt(0)) ;// Dave - 30
  }

  Future<List<NotificationListModel>> getLocalData() async {
    //var box = await Hive.openBox('TripBox');
    var box = await Hive.openBox<NotificationListModel>('TripBox1');

    List<NotificationListModel>? notificationList = [];
    if(box.isNotEmpty) {
      //final  data = box.values;
      List<NotificationListModel> hiveVitals = box.values.toList();
      print( "hiveData  ${hiveVitals.first.tripname}");
      notificationList = hiveVitals;


    } else {
      // empty state
      return notificationList;
    }
    return notificationList;
  }


}