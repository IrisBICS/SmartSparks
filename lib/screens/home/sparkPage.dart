import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/screens/home/components/commentTile.dart';
import 'package:smartsparks/services/sparkService.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartsparks/shared/loading.dart';
import 'components/iconCount.dart';
import 'newCommentPage.dart';

class SparkPage extends StatelessWidget {

  final String sparkID;
  final String topicID;

  SparkPage({this.sparkID, this.topicID});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Spark>.value(
      value: SparkService(topicID: topicID, sparkID: sparkID).spark,
      child: SparkPageContent(),
    );
  }
}

class SparkPageContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final spark = Provider.of<Spark>(context);

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Spark'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Stack(
            children: <Widget>[
              BgImage(top: 320),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TopContent(),
                    ),
                  ),
                  Divider(
                    color: white,
                  ),
                  Expanded(
                    child: BottomContent(topicID: spark != null ? spark.parentTopic : null, sparkID: spark != null ? spark.sparkID : null,)
                  )
                ],
              ),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCommentPage(parentSpark: spark)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: yellow,
      ),
      endDrawer: OptionsTab(),
    );
  }
}

class TopContent extends StatelessWidget {

  final TextStyle whiteText = TextStyle(color: white);

  @override
  Widget build(BuildContext context) {
    final spark = Provider.of<Spark>(context);
    final MarkdownStyleSheet mdStyle = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      h1: whiteText,
      h2: whiteText,
      h3: whiteText,
      h4: whiteText,
      h5: whiteText,
      h6: whiteText,
      p: whiteText,
      listBullet: whiteText,
      a: TextStyle(color: yellow),
    );

    return spark != null ? ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            spark.title,
            style: TextStyle(color: white),
          ),
          subtitle: Text(
            "Posted by " + spark.creatorRank,
            style: TextStyle(color: lightGray),
          ),
          trailing: IconCount(count: spark.commentsCount, icon: Icons.comment, iconColor: white, textColor: white),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: MarkdownBody(
            data: spark.description,
            styleSheet: mdStyle,
          ),
        )
      ],
    ) : Loading();
  }
}

class BottomContent extends StatelessWidget {

  final String topicID;
  final String sparkID;

  BottomContent({this.topicID, this.sparkID});

  @override
  Widget build(BuildContext context) {
    return topicID != null && sparkID != null ? StreamProvider<List<Comment>>.value(
      value: SparkService(topicID: topicID, sparkID: sparkID).comments,
      child: CommentsList(topicID: topicID, sparkID: sparkID),
    ) : Loading();
  }
}

class CommentsList extends StatelessWidget {

  final String topicID;
  final String sparkID;

  CommentsList({this.topicID, this.sparkID});

  @override
  Widget build(BuildContext context) {

    final comments = Provider.of<List<Comment>>(context);

    return comments != null && comments.length != 0 ? ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return CommentTile(topicID: topicID, sparkID: sparkID, comment: comments[index]);
      },
    ) : Center(
      child: Text(
        "Be the first to post a comment on this topic !",
        style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}