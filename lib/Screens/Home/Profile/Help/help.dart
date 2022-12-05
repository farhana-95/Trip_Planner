import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/Screens/Home/Profile/Help/get_help.dart';
import '../../../../constants.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String  Id;
  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    //final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print(uid);
    // print(_userInfo);
    return uid;
  }
  late final CollectionReference _help;

  final _helpQuestions =TextEditingController();
  @override
  void initState() {

    Id= getCurrentUser();
    print("Iddd     $Id");
    _help = FirebaseFirestore.instance.collection("help").doc(Id).collection("help");
    super.initState();

  }
  Widget Report(){
    return Container(
      height: 230.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: <Widget>[
          Text("Report",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: _helpQuestions,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(

              border: UnderlineInputBorder(),
              //labelText: 'Question ',
              labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
              hintText: 'Question/Problem',
            ),
            onSaved: (questions){},
          ),
          SizedBox(height: 20,),
          MaterialButton(
              color: kPrimaryColor,
              child: const Text('Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: ()async{
                if(_helpQuestions.text!='')
                {Map<String,dynamic> hp={
                  "questions": _helpQuestions.text,};
                _help.add(hp);
                }
                _helpQuestions.text='';
              }
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Help'),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                textColor: Colors.blue,
                leading: Icon(Icons.question_mark),
                title: Text('How do I add new Trips/ Tours?'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GetHelp()));
              },
            ),
          ),
          Container(
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                textColor: Colors.blue,
                leading: Icon(Icons.question_mark),
                title: Text('How to add tour plans?'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GetHelp()));
              },
            ),
          ),
          Container(
            height: 60,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                textColor: Colors.blue,
                leading: Icon(Icons.question_mark),
                title: Text('Why the profile picture is not uploading?'),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GetHelp()));
              },
            ),
          ),
          Container(
            height: 80,
            width: 100,
            child: GestureDetector(
              child: ListTile(
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                title: Text('Having an issue?\nReport a problem here..'),
              ),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext ctx) {return Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 18,
                          right: 18,
                          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                      child: Report(),
                    );}
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
