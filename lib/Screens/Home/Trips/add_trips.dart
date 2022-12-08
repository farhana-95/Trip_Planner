import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/main_screen.dart';
import 'package:trip_planner/constants.dart';
import 'package:intl/intl.dart';

class AddTrips extends StatefulWidget {
  final String? name,area,image;
   const AddTrips( {Key? key,
      this.name, this.area,this.image}) : super(key: key);
  @override
  State<AddTrips> createState() => _AddTripsState();
}
class _AddTripsState extends State<AddTrips> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print(uid);
    // _userInfo;
    // print(_userInfo);
    return uid;
  }
  late final CollectionReference _trip;

  final _location=TextEditingController();
  final _startdate=TextEditingController();
  final _enddate=TextEditingController();
  final _tripname=TextEditingController();
  final  img= TextEditingController();

late String  Id;

  @override
  void initState() {
    _tripname.clear();
    _location.clear();
    img.text=widget.image ?? "";
    _tripname.text = widget.name ?? "";
    _location.text = widget.area ?? "";
    Id= getCurrentUser();
    print("Iddd     $Id");
    _trip = FirebaseFirestore.instance.
    collection("trip").doc(Id).collection("trip");
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Add Trips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Column(children:[
              const SizedBox(height: 20,width: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
            controller: _tripname,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Trip Name ',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                hintText: 'Enter Name',
                  ),
                  onSaved: (tripname){
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _location,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Start Date & Time',
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    hintText: 'Enter Date & Time',
                  ),
                  onTap: ()async{
                    DateTime? pickeddate = await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    TimeOfDay? tpm = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    if(pickeddate != null && tpm != null)
                      {
                        setState(() {
                          _startdate.text= DateFormat('dd-MM-yyyy').format(pickeddate) + " ${tpm.format(context)}";
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
                  decoration: const InputDecoration(
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
            ),const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: ElevatedButton(

                  child: const Text('Save',
                    style: TextStyle(color: Colors.white),

                  ),
                  onPressed: ()async{

                        Map<String,dynamic> data={
                      "tripid": Timestamp.now().millisecondsSinceEpoch,
                      "tripname": _tripname.text,
                      "location": _location.text,
                      "startdate":_startdate.text,
                      "enddate": _enddate.text,
                          "image": img.text,
                       };
                    _trip.add(data);
                        _tripname.text='';
                        _location.text='';
                        _startdate.text='';
                        _enddate.text='';
                        img.text='';

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => MainScreen()));

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("New Trip Saved!")));

                          print("IDD $Id");
                  }
              ),
            )
          ],

        ),
      ),
    );
  }
}
