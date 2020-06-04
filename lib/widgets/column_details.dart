import 'package:flutter/material.dart';

class ColumnDetails extends StatelessWidget {

  String total;
  String label;

  ColumnDetails(this.total, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          total,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
        )
      ],
    );
  }
}
