import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/Screens/Home/place_suggestions/resort.dart';
import 'LocalDB/Localdb.dart';
import 'Model/NotificationListModel.dart';
import 'alarm_manager/alarm_manager.dart';

class NotificationAlert extends StatefulWidget {
  const NotificationAlert({Key? key}) : super(key: key);

  @override
  State<NotificationAlert> createState() => _NotificationAlertState();
}

class _NotificationAlertState extends State<NotificationAlert> {
  List<NotificationListModel> _someAsyncData = [];
  Localdb localDb = Localdb();
  SetAlarm alarm = SetAlarm();
  var box = Hive.openBox<NotificationListModel>('TripBox1');

  @override
  void initState() {
    super.initState();
    localDb.getLocalData().then((val) {
      setState(() {
        if (val != null) {
          _someAsyncData = val;
        }
      });
    });
  }

  void deleteTrip(int index) async {
    var box = await Hive.openBox<NotificationListModel>('TripBox1');
    if (box.isNotEmpty) {
      //final  data = box.values;
      List<NotificationListModel> hiveVitals = box.values.toList();
      //print( "hiveData  ${hiveVitals.first.tripname}");
      hiveVitals.removeAt(index);
      box.deleteAt(index);

      _someAsyncData = hiveVitals;
    } else {
      _someAsyncData = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      //Resort();
      Scaffold(
        body:
        _someAsyncData.isEmpty? Container(child: const Center(
            child: Text('No Reminder',style: TextStyle(color: Colors.grey),)),):
        ListView.builder(
            itemCount: _someAsyncData.length,
            itemBuilder: (BuildContext context, int i) {
             DateTime dt3 =DateFormat('dd-MM-yyyy').parse(_someAsyncData[i].startdate);

             return  dt3.isBefore(DateTime.now())?
             const SizedBox()
              :Card(
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                child:
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7,right: 8),
                      child: Container(height: 95,width: 3,color: Colors.blue,),
                    ),
                    Expanded(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 70,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 5, top: 10),
                              child: Text(
                                "Trip '${_someAsyncData[i].tripname}' has been saved for  reminder at '${_someAsyncData[i].startdate}' ",
                                style: TextStyle(fontSize: 16, height: 1.6),softWrap: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 175, ),
                            child: TextButton(
                              child: Row(
                                children: const [
                                  Text(
                                    "Cancel Reminder",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Icon(
                                    Icons.notifications_off_outlined,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                              onPressed: () async {
                                alarm.cancelAlarm();

                                setState(() {
                                  deleteTrip(i);
                                  // _someAsyncData[i].delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Reminder Deleted")));
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
        //SetAlarm()
        );
  }
}
