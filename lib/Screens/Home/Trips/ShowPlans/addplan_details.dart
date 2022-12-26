import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Trips/ShowPlans/show_plans.dart';
import 'package:trip_planner/constants.dart';
import 'package:intl/intl.dart';

class PlanDetails extends StatefulWidget {
  final int? tripid;
  const PlanDetails( {Key? key,  this.tripid }) : super(key: key);
  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}
class _PlanDetailsState extends State<PlanDetails> {

  static int tripId = 0 ;
  late final CollectionReference _activityplan;
  late final CollectionReference _transport;
  late final CollectionReference _restaurant;
  late final CollectionReference _accomodation;
  late final CollectionReference _addnotes;

  @override
  void initState() {
    tripId = widget.tripid ?? 0;
    _activityplan = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("activityplan");
    _transport = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("transport");
    _restaurant = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("restaurant");
    _accomodation = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("accomodation");
    _addnotes = FirebaseFirestore.instance.collection("trip").doc("$tripId").collection("addnotes");

  }
  int _activeCurrentStep = 0;
  final activitytitile = TextEditingController();
  final activitynote = TextEditingController();
  final acttime = TextEditingController();
  final actdate = TextEditingController();
   final transtype = TextEditingController();
  final transdate = TextEditingController();
  final transtime = TextEditingController();
  final restname = TextEditingController();
  final resadd = TextEditingController();
  final restdate = TextEditingController();
  final restime = TextEditingController();
  final acmtitle = TextEditingController();
  final acmadd = TextEditingController();
  final acmin = TextEditingController();
  final acmout = TextEditingController();
  final details = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();
  static List<String>type = ['Select Type', 'Bus','Plane','Others'];
   String  tType ='Select Type ';
  List<Step> stepList() => [
    Step(title: Text('Activities'),
        content: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: activitytitile,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: activitynote,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Note'
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: actdate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      actdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: acttime,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Time'
                ),
                onTap: ()async{
                  TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(tm != null)
                  {
                    setState(() {
                      acttime.text= tm.format(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
    ),
    Step(title: Text('Transport'),
        content: Container(
          child: Column(
            children: [
              TextField(
                controller: transtype,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Transport Type',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: transdate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      transdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: transtime,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Time'
                ),
                onTap: ()async{
                  TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(tm != null)
                  {
                    setState(() {
                      transtime.text= tm.format(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
    ),
    Step(title: Text('Restaurant'),
        content: Container(
          child: Column(
            children: [
              TextField(
                controller: restname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Restaurant Name',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: resadd,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address'
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: restdate,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      restdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: restime,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Time'
                ),
                onTap: ()async{
                  TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(tm != null)
                  {
                    setState(() {
                      restime.text= tm.format(context);

                    });
                  }

                },
              ),
            ],
          ),
        ),
    ),
    Step(title: Text('Accomodation'),
        content: Container(
          child: Column(
            children: [
              TextField(
                controller: acmtitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: acmadd,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address'
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: acmin,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Check-In'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                 if(pickeddate != null)
                  {
                    setState(() {
                      acmin.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }

                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: acmout,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Check-Out'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      acmout.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
            ],
          ),
        ),
    ),
    Step(title: Text('Add Notes'),

        content: Container(
          child: Column(
            children: [
              TextField(
                controller: details,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Details'
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: date,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date'
                ),
                onTap: ()async{
                  DateTime? pickeddate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if(pickeddate != null)
                  {
                    setState(() {
                      date.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: time,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Time'
                ),
                onTap: ()async{
                  TimeOfDay? tm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if(tm != null)
                  {
                    setState(() {
                      time.text= tm.format(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text('Add Plans',),
      ),
      body:
        Column(
          children: <Widget>[
            Expanded(child: Stepper(

              currentStep: _activeCurrentStep,
              steps:stepList(),
             onStepContinue: () {
                if (_activeCurrentStep==0) {
                  setState(() {
                    if(activitytitile.text!= '' || activitynote.text!=''||
                        actdate.text!='' || acttime.text!='')
                    {Map<String, dynamic> acdata = {
                      "activitytitile": activitytitile.text,
                      "activitynote": activitynote.text,
                      "activitydate": actdate.text,
                      "id": widget.tripid,
                      "activitytime": acttime.text};
                    _activityplan.add(acdata);
                  }
                  });
                  activitytitile.text='';
                  activitynote.text='';
                  actdate.text='';
                  acttime.text='';
                }
                else if(_activeCurrentStep==1){
                  setState(() {
                    if(transtype.text!= '' || transdate.text!=''||
                        transtime.text!='')
                    {Map<String,dynamic> transdata={
                      "transporttype": transtype.text,
                      "transportdate": transdate.text,
                      "transporttime":transtime.text,
                      "id": widget.tripid,
                    };
                    _transport.add(transdata);}
                  });
                  transtype.text='';
                  transdate.text='';
               transtime.text='';
                }
                else if(_activeCurrentStep==2){
                  setState(() {
                    if(restname.text!= '' || resadd.text!=''||
                        restdate.text!='' || restime.text!='')
                    {Map<String,dynamic> restdata={
                      "restname": restname.text,
                      "resadd": resadd.text,
                      "restdate":restdate.text,
                      "id": widget.tripid,
                      "restime": restime.text};
                    _restaurant.add(restdata);}
                  });
                  restname.text='';
                  resadd.text='';
                  restdate.text='';
                  restime.text='';
                }
                else if(_activeCurrentStep==3){
                  setState(() {
                    if(acmtitle.text!= '' || acmadd.text!=''||
                        acmin.text!='' || acmout.text!='')
                    {Map<String,dynamic> accmdata={
                      "acmtitle": acmtitle.text,
                      "acmadd": acmadd.text,
                      "acmin":acmin.text,
                      "id": widget.tripid,
                      "acmout": acmout.text};
                    _accomodation.add(accmdata);}
                  });
                  acmtitle.text='';
                  acmadd.text='';
                  acmin.text='';
                  acmout.text='';
                }
                else if(_activeCurrentStep==4){
                  setState(() {
                    if(details.text!= '' || date.text!=''||
                        time.text!='')
                    {Map<String,dynamic> notesdata={
                      "details": details.text,
                      "date":date.text,
                      "id": widget.tripid,
                      "time": time.text};
                    _addnotes.add(notesdata);}
                  });
                  details.text='';
                  date.text='';
                  time.text='';
                }

              },
              // onStepCancel takes us to the previous step
             onStepCancel: () {
                if (_activeCurrentStep == 0) {
                  return;
                }
                setState(() {
                  _activeCurrentStep -= 1;
                });
              },
              controlsBuilder: (BuildContext contex,ControlsDetails controls){
                return Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: controls.onStepContinue,
                        child: Text('Save')),
                    TextButton(
                        onPressed: controls.onStepCancel,
                        child: Text('Cancel')),
                  ],
                );
              },
              // onStepTap allows to directly click on the particular step we want
              onStepTapped: (int index) {

                setState(() {
                  const Color(0xFF399BB4);
                  _activeCurrentStep = index;
                });
              },
            ),
            ),
          ],
        ),
    );
  }
}
