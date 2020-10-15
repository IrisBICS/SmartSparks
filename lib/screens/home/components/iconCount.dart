import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {

  final int count;
  final IconData icon;

  IconCount({this.count, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: 45,
            child: Text(count.toString()),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(icon),
          )
        ],
      ),
    );
  }
}