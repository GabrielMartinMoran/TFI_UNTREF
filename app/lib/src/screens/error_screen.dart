import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  ErrorScreen({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oops...\nHa ocurrido un error!',
            style: TextStyle(fontSize: 70, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 40, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
