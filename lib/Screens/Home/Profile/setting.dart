import 'package:flutter/material.dart';

import '../../../constants.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Settings'),backgroundColor: kPrimaryColor,),
    );
  }
}
