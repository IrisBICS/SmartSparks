import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/services/sparkService.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartsparks/shared/loading.dart';
import 'components/iconCount.dart';

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

    //final spark = Provider.of<Spark>(context);

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Topic'),
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
                    child: BottomContent(),
                  )
                ],
              ),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCommentPage()),
          ); */
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
          trailing: IconCount(count: spark.commentsCount, icon: Icons.star, iconColor: yellow, textColor: white),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: skintone.withAlpha(150)
    );
  }
}

class CommentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}