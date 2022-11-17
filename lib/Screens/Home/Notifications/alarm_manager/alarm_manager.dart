import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../notification_service.dart';
class SetAlarm {
  //const SetAlarm({Key? key}) : super(key: key);

  //static  DateTime now = (DateTime.now()).add(new Duration(seconds: 10));

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
     DateTime now = (DateFormat('dd-MM-yyyy').parse(dateTime));
     now
       ..subtract(Duration(hours: now.hour, minutes: now.minute))
       ..add(Duration(hours: 13, minutes: 15));
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
    String duration = "1";
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


// class SetAlarm extends StatefulWidget {
//
//   const SetAlarm({Key? key}) : super(key: key);
//
//   @override
//   State<SetAlarm> createState() => _SetAlarmState();
// }
//
// class _SetAlarmState extends State<SetAlarm> {
//   List<NotificationListModel> _someAsyncData = [];
//   Localdb localDb =  Localdb();
//   static final DateTime now = (DateTime.now()).add(new Duration(seconds: 10));
//   //var alarmDate = "16-11-2022";
//  static NotificationService notificationService = NotificationService();
//
//   @override
//   void initState() {
//     super.initState();
//     localDb.getLocalData().then((val) {
//       setState(() {
//         if(val!= null){
//           _someAsyncData = val;
//         }
//       });
//     });
//   }
//   static const String appName = "Alarm Manager Example";
//   static const String durationSeconds = "Seconds";
//   static const String oneShotAlarm = "oneShot";
//   static const String oneShotAtAlarm = "oneShotAt";
//   static const String periodicAlarm = "periodic";
//
//   final int _oneShotTaskId = 1;
//   final int _oneShotAtTaskId = 2;
//   final int _periodicTaskId = 3;
//
//   static void _oneShotTaskCallback() {
//     print("One Shot Task Running");
//   }
//
//   static void _oneShotAtTaskCallback() {
//     print("One Shot At Task Running");
//   notificationService.showNotifications();
//   }
//
//   static void _periodicTaskCallback() {
//     print("Periodic Task Running");
//   }
//   void _scheduleOneShotAlarm(bool isTimed) async {
//     if (isTimed) {
//       //DateTime chosenDate = await _chooseDate("");
//       await AndroidAlarmManager.oneShotAt(now, _oneShotAtTaskId, _oneShotAtTaskCallback);
//     } else {
//       Duration duration = await _chooseDuration();
//       await AndroidAlarmManager.oneShot(duration, _oneShotTaskId, _oneShotTaskCallback);
//     }
//   }
//   void _schedulePeriodicAlarm() async {
//     Duration duration = await _chooseDuration();
//     await AndroidAlarmManager.periodic(duration, _periodicTaskId, _periodicTaskCallback);
//   }
//   Future<Duration> _chooseDuration() async {
//     String duration = "1";
//     String durationString = durationSeconds;
//     // AlertDialog alert = AlertDialog(
//     //   title: const Text("Enter a number for the duration"),
//     //   content:
//     //   StatefulBuilder(
//     //     builder: (BuildContext context, StateSetter setState) {
//     //       return
//     //         Column(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           Expanded(
//     //             child: RadioListTile(
//     //                 title: const Text(durationMinutes),
//     //                 value: durationMinutes,
//     //                 groupValue: durationString,
//     //                 onChanged: (String? value) {
//     //                   if (value != null) {
//     //                     setState(() =>
//     //                     durationString = value
//     //                     );
//     //                   }
//     //                 }),
//     //           ),
//     //           Expanded(
//     //             child: RadioListTile(
//     //                 title: const Text(durationHours),
//     //                 value: durationHours,
//     //                 groupValue: durationString,
//     //                 onChanged: (String? value) {
//     //                   if (value != null) {
//     //                     setState(() =>
//     //                     durationString = value
//     //                     );
//     //                   }
//     //                 }),
//     //           ),
//     //           Row(
//     //             mainAxisAlignment: MainAxisAlignment.center,
//     //             children: [
//     //               Expanded(child:
//     //               TextField(
//     //                 maxLines: 1,
//     //                 keyboardType: TextInputType.number,
//     //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//     //                 onChanged: (String text) {
//     //                   duration = text;
//     //                 },
//     //               ),
//     //               ),
//     //             ],
//     //           ),
//     //         ],
//     //       );
//     //     },
//     //   ),
//     //   actions: [
//     //     TextButton(
//     //       onPressed: () {
//     //         Navigator.of(context).pop(duration);
//     //       },
//     //       child: const Text("Ok"),
//     //     ),
//     //     TextButton(
//     //       onPressed: () {
//     //         Navigator.of(context).pop();
//     //       },
//     //       child: const Text("Cancel"),
//     //     )
//     //   ],
//     // );
//     //
//     // String? enteredText = await showDialog(
//     //     context: context,
//     //     builder: (context) {
//     //       return alert;
//     //     });
//
//     if (duration != null) {
//       int time = int.parse(duration);
//       if (durationString == durationSeconds) {
//         return Duration(seconds: time);
//       }
//     }
//     return const Duration(seconds: 0);
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       body: _scheduleOneShotAlarm(true)
//       // Column(
//       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //   children: <Widget>[
//       //     const Text(
//       //       appName,
//       //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//       //     ),
//       //     Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //       children: [
//       //         Container(
//       //           margin: const EdgeInsets.only(left: 15),
//       //           child:  SizedBox(
//       //             width: 90,
//       //             height: 50,
//       //             child: ElevatedButton.icon(
//       //                 onPressed: () {
//       //                   _scheduleOneShotAlarm(false);
//       //                 },
//       //                 icon: const Icon(Icons.plus_one),
//       //                 label: const Text(
//       //                     oneShotAlarm
//       //                 )
//       //             ),
//       //           ),
//       //         ),
//       //         SizedBox(
//       //           width: 120,
//       //           height: 50,
//       //           child: ElevatedButton.icon(
//       //               onPressed: () {
//       //                 _scheduleOneShotAlarm(true);
//       //
//       //               },
//       //               icon: const Icon(Icons.calendar_today),
//       //               label: const Text(
//       //                   oneShotAtAlarm
//       //               )
//       //           ),
//       //         ),
//       //         Container(
//       //           margin: const EdgeInsets.only(right: 15),
//       //           child: SizedBox(
//       //             width: 112,
//       //             height: 50,
//       //             child:  ElevatedButton.icon(
//       //               onPressed: _schedulePeriodicAlarm,
//       //               icon: const Icon(Icons.watch_later_outlined),
//       //               label: const Text(
//       //                   periodicAlarm
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       ],
//       //     )
//       //   ],
//       // ),
//     );
//   }
// }
//
// DateTime _chooseDate(var date) {
//   DateTime dt =DateFormat('dd-MM-yyyy').parse(date);
//   print (dt);
//   return dt;
// }