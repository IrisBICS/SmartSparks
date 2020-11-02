import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {

  final int count;
  final IconData icon;
  final Color textColor;
  final Color iconColor;

  IconCount({this.count, this.icon, this.textColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: 45,
            child: Text(count.toString(), style: TextStyle(color: textColor)),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(icon, color: iconColor),
          )
        ],
      ),
    );
  }
}