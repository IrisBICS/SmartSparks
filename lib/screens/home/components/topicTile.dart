import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';

class TopicTile extends StatelessWidget {

  //Data to be obtained from the caller later
  final String date = '24/08/2020';
  final String author = 'Admin1';
  final String title = 'Spark1';
  final String data = 'This is the body'; //Will be markdown data later

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 370.0,
        color: lightGray,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Item"), //Container with all the data
        )
      ),
    );
  }
}