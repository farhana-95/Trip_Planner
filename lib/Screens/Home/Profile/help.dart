import 'package:flutter/material.dart';
import '../../../constants.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Help'),backgroundColor: kPrimaryColor,),
    );
  }
}
