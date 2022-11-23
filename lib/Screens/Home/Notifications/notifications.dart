import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_planner/Screens/Home/Notifications/notification_service.dart';
import 'package:trip_planner/constants.dart';

import 'LocalDB/Localdb.dart';
import 'Model/NotificationListModel.dart';
import 'alarm_manager/alarm_manager.dart';
class NotificationAlert extends StatefulWidget {
  const NotificationAlert({Key? key}) : super(key: key);
  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  // NotificationService _notificationService = NotificationService();
  List<NotificationListModel> _someAsyncData = [];
  Localdb localDb =  Localdb();
  SetAlarm alarm =  SetAlarm();
  var box =  Hive.openBox<NotificationListModel>('TripBox1');

  @override
  void initState() {
    super.initState();
    localDb.getLocalData().then((val) {
      setState(() {
        if(val!= null){
          _someAsyncData = val;

        }
      });
    });
  }
  void deleteTrip(int index)  async {

    var box = await Hive.openBox<NotificationListModel>('TripBox1');
    // var _taskBox =  await Hive.openBox<Task>('taskbox');
    if(box.isNotEmpty) {
      //final  data = box.values;
      List<NotificationListModel> hiveVitals = box.values.toList();
      //print( "hiveData  ${hiveVitals.first.tripname}");
      hiveVitals.removeAt(index);
//      box.clear();
      box.deleteAt(index);

      _someAsyncData = hiveVitals;

    }else{
      _someAsyncData = [];
    }
  }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
       body:
       ListView.builder(itemCount: _someAsyncData.length,
           itemBuilder: (BuildContext context, int i) {
             return Card(
               child:
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(height: 7,),
                   Container(height: 70,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 20,right: 15,top: 10),
                       child: Text(" Trip '${_someAsyncData[i].tripname}' from '${_someAsyncData[i].startdate}' has been saved for reminder. "
                           ,style: TextStyle(fontSize: 16,height: 1.6),),
                     ),),
                   Padding(
                     padding: const EdgeInsets.only(left: 215,right: 10),
                     child: TextButton(
                         child: Row(
                         children: [
                           Text("Cancel Reminder",style: TextStyle(color: Colors.black54),),
                           Icon(Icons.notifications_off_outlined,color:Colors.black54 ,)
                       ],
                     ),
                       onPressed: () async {
                         alarm.cancelAlarm();

                      setState(() {
                        deleteTrip(i);
                       // _someAsyncData[i].delete();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Reminder Deleted")));
                      });
                       },
                     ),
                   )
                 ],
               ),
             );
           }
       )
       //SetAlarm()
    );
  }

}

