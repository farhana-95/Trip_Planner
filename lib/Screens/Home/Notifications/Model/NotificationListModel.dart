import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class NotificationListModel extends HiveObject {

  @HiveField(0)
   String tripid = "";

  @HiveField(1)
  String tripname = "";

  @HiveField(2)
   String location = "";

  @HiveField(3)
  String startdate = "";

  @HiveField(4)
  String enddate = "";


  @HiveField(5)
  String startdateTime = "";

  @HiveField(5)
   bool isReminder = false;

  NotificationListModel({
    required this.tripid,
    required this.tripname,
    required this.location,
    required this.startdate,
    required this.enddate,
    required this.startdateTime,

  });

  static fromJson(i) {
    NotificationListModel notificationListModel = NotificationListModel(tripid: i["tripid"], tripname: i["tripname"], location: i["location"], startdate: i["startdate"], enddate: i["enddate"], startdateTime: i["startdateTime"]);
    return notificationListModel;

  }
}

