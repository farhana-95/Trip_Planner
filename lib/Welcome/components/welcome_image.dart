import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatefulWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  State<WelcomeImage> createState() => _WelcomeImageState();
}

class _WelcomeImageState extends State<WelcomeImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "WELCOME",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/welcome.jpg",
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}


