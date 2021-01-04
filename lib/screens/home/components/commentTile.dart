import 'package:flutter/material.dart';
import 'package:smartsparks/services/sparkService.dart';
import 'package:smartsparks/shared/constants.dart';
import 'iconCount.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/userService.dart';

class CommentTile extends StatefulWidget {

  final Comment comment;
  final String sparkID;
  final String topicID;
  final bool tapEnabled;

  CommentTile({this.comment, this.sparkID, this.topicID, this.tapEnabled});

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    if (user != null && widget.comment.likes.contains(user.uid)) {
      setState(() => isLiked = true);
    } else {
      setState(() => isLiked = false);
    }

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
                title: Text(widget.comment.title),
                subtitle: Text("Posted by " + widget.comment.authorRank),
                trailing: GestureDetector(
                  onTap: () {
                    if (widget.tapEnabled && !widget.comment.isMarked) {
                      SparkService(topicID: widget.topicID, sparkID: widget.sparkID).changeCommentLike(user.uid, isLiked, widget.comment.commentID);
                    }
                  },
                  child: IconCount(count: widget.comment.likes.length, icon: Icons.thumb_up, textColor: black, iconColor: isLiked ? yellow : darkGray),
                ),
                leading: IconButton(
                  icon: Icon(Icons.verified_user, color: widget.comment.isMarked ? green : darkGray),
                  onPressed: () {
                    if (!widget.comment.isMarked && widget.tapEnabled) {
                      SparkService(topicID: widget.topicID, sparkID: widget.sparkID).markCommentAsUseful(widget.comment.commentID);
                      UserService(uid: widget.comment.authorID).addPointsAndUpdateRank(50, 0).then((_) {
                        for (var userID in widget.comment.likes) {
                          UserService(uid: userID).addPointsAndUpdateRank(10, 0);
                        }
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MarkdownBody(data: widget.comment.body),
              )
            ],
          ),
        )
      ),
    );
  }
}