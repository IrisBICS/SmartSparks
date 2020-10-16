import 'package:flutter/material.dart';
import 'topicTile.dart';
import 'package:smartsparks/models/dataModels.dart';

class TopicsList extends StatefulWidget {
  @override
  _TopicsListState createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {

  //Get topics data from firebase

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: 5, //Count of all topics
      itemBuilder: (BuildContext context, int index) {
        return TopicTile(); //Pass in topics data
      },
    );
  }
}