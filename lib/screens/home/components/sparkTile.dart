import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';
import 'iconCount.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartsparks/screens/home/sparkPage.dart';

class SparkTile extends StatelessWidget {

  final Spark spark;
  final bool tapEnabled;
  final String topicID;

  SparkTile({this.spark, this.tapEnabled, this.topicID});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          if (tapEnabled) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SparkPage(sparkID: spark.sparkID, topicID: topicID)),
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
                  title: Text(spark.title),
                  subtitle: Text("Posted by " + spark.creatorRank),
                  trailing: Container(
                    width: 80,
                    child: IconCount(count: spark.voters.length, icon: Icons.arrow_upward, textColor: black, iconColor: darkGray),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MarkdownBody(data: spark.description),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}