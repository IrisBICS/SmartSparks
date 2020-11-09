import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';
import 'iconCount.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CommentTile extends StatelessWidget {

  final Comment comment;
  final String sparkID;
  final String topicID;

  CommentTile({this.comment, this.sparkID, this.topicID});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 370.0,
        color: lightGray.withAlpha(180),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child:  ListView(
            children: <Widget>[
              ListTile(
                title: Text(comment.title),
                subtitle: Text("Posted by " + comment.authorRank),
                trailing: Container(
                  width: 80,
                  child: IconCount(count: comment.likes.length, icon: Icons.arrow_upward, textColor: black, iconColor: darkGray),
                )
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MarkdownBody(data: comment.body),
              )
            ],
          ),
        )
      ),
    );
  }
}