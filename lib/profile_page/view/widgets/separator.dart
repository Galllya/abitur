import 'package:abitur/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final String littleText;
  final String bigText;
  const Separator({Key? key, required this.littleText, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          littleText,
          style: TextStyle(
            fontSize: 14,
            color: Color(0XFF909090),
          ),
        ),
        Text(
          bigText,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
