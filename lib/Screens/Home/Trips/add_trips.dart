import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/main_screen.dart';
import 'package:trip_planner/constants.dart';
import 'package:intl/intl.dart';

class AddTrips extends StatefulWidget {
   const AddTrips( {Key? key}) : super(key: key);
  @override
  State<AddTrips> createState() => _AddTripsState();
}
class _AddTripsState extends State<AddTrips> {
  final CollectionReference _trip=
  FirebaseFirestore.instance.collection('trip');
  final _location=TextEditingController();
  final _startdate=TextEditingController();
  final _enddate=TextEditingController();
  final _tripname=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add Trips'),
      ),
      body: Column(
        children:<Widget> [
          Expanded(
            child:
            Column(children:[
              SizedBox(height: 20,width: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
            controller: _tripname,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Trip Name ',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                hintText: 'Enter Name',
                  ),
                  onSaved: (tripname){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _location,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Location ',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      //fontWeight: FontWeight.bold
                    ),
                    hintText: 'Enter Location',
                  ),
                  onSaved: (location){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startdate,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Start Date ',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    hintText: 'Enter Date',
                  ),
                  onTap: ()async{
                    DateTime? pickeddate = await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if(pickeddate != null)
                      {
                        setState(() {
                          _startdate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _enddate,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'End Date ',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    hintText: 'Enter Date',
                  ),
                  onTap: ()async{
                    DateTime? pickeddate = await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if(pickeddate != null)
                    {
                      setState(() {
                        _enddate.text= DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }

                  },
                ),
              ),
           ]
            ),
          ),
          MaterialButton(
              color: kPrimaryColor,
              child: Text('Save',
                style: TextStyle(color: Colors.white),

              ),
              onPressed: ()async{
                if(_tripname.text!= '' || _location.text!=''||
                    _startdate.text!='' || _enddate.text!='')
                  {
                    Map<String,dynamic> data={
                  "tripid": Timestamp.now().millisecondsSinceEpoch,
                  "tripname": _tripname.text,
                  "location": _location.text,
                  "startdate":_startdate.text,
                  "enddate": _enddate.text};
                _trip.add(data);
                  }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ),
                );
              }
          )
        ],

      ),
    );
  }
}
