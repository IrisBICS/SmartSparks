import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';

class TopicTile extends StatelessWidget {

  //Data to be obtained from the caller later
  final String date;
  final String author;
  final String title;
  final String data; //Will be markdown data later

  TopicTile({this.date, this.author, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 370.0,
        color: lightGray.withAlpha(180),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Topic item"), //Container with all the data
        )
      ),
    );
  }
}