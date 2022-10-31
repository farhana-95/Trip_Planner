import 'package:flutter/material.dart';
import 'package:trip_planner/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('About'),backgroundColor: kPrimaryColor,),
    );
  }
}
