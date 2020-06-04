import 'package:flutter/material.dart';

class RowDetails extends StatelessWidget {

  String text;
  IconData icon;

  RowDetails(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey,
          size: 16,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
        )
      ],
    );
  }
}
