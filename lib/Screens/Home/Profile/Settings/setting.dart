import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),backgroundColor: kPrimaryColor,),
    );
  }
}
