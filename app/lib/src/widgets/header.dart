import 'package:app/src/configs/pallete.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  const Header(this.text, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Text(text,
              style: TextStyle(
                color: Pallete.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ),
        Divider(
          color: Pallete.chartLine,
        )
      ],
    ));
  }
}
