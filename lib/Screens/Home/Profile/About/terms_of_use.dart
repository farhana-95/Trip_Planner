import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms of Use'),
        backgroundColor: kPrimaryColor,),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            SizedBox(height: 24,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('Terms of Service',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5),),
            ),
            SizedBox(height: 18,),
            Container(
              margin: EdgeInsets.only(left: 20,right: 8),
              child: Text('We have updated our Terms of Use, Data Policy '
                  'and Cookies Policy on 5 November,'
                  ' 2022. Our Data Policy and Terms of Service remain in reffect and updated\n'
                  '\nWe do not charge for using the product and services by this term'
                  '.We do not sell your personal informations or share them. We do not advertise untill your permission. ',
                style: TextStyle(height: 2,fontSize: 16),
                textAlign: TextAlign.left,),
            ),
          ]
      ) ,

    );
  }
}
