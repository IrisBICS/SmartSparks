import 'package:flutter/material.dart';
import 'package:smartsparks/screens/home/closeTopicPage.dart';
import 'package:smartsparks/shared/constants.dart';
import 'iconCount.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartsparks/screens/home/topicPage.dart';

class TopicTile extends StatelessWidget {

  final Topic topic;
  final bool tapEnabled;

  TopicTile({this.topic, this.tapEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          if (tapEnabled) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopicPage(topicID: topic.topicID)),
            );
          }
        },
        child: Container(
          width: 370.0,
          color: lightGray.withAlpha(180),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child:  ListView(
              children: <Widget>[
                ListTile(
                  title: Text(topic.title),
                  subtitle: Text("Posted by " + topic.creatorUsername),
                  trailing: IconCount(count: topic.sparksCount, icon: Icons.star, textColor: black, iconColor: yellow),
                  leading: IconButton(
                    icon: Icon(Icons.archive),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CloseTopicPage(topic: topic)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MarkdownBody(data: topic.description),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}