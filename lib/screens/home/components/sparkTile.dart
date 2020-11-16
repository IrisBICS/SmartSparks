import 'package:flutter/material.dart';
import 'package:smartsparks/services/sparkService.dart';
import 'package:smartsparks/shared/constants.dart';
import 'iconCount.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartsparks/screens/home/sparkPage.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';

class SparkTile extends StatefulWidget {

  final Spark spark;
  final bool tapEnabled;
  final String topicID;

  SparkTile({this.spark, this.tapEnabled, this.topicID});

  @override
  _SparkTileState createState() => _SparkTileState();
}

class _SparkTileState extends State<SparkTile> {

  bool isUpVoted = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    if (user != null && widget.spark.voters.contains(user.uid)) {
      setState(() => isUpVoted = true);
    } else {
      setState(() => isUpVoted = false);
    }

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          if (widget.tapEnabled) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SparkPage(sparkID: widget.spark.sparkID, topicID: widget.topicID)),
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
                  title: Text(widget.spark.title),
                  subtitle: Text("Posted by " + widget.spark.creatorRank),
                  trailing: GestureDetector(
                    onTap: () {
                      if (widget.tapEnabled) {
                        SparkService(topicID: widget.topicID, sparkID: widget.spark.sparkID).changeSparkVote(user.uid, isUpVoted);
                      }
                    },
                    child: IconCount(count: widget.spark.voters.length, icon: Icons.arrow_upward, textColor: black, iconColor: isUpVoted ? yellow : darkGray)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MarkdownBody(data: widget.spark.description),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}