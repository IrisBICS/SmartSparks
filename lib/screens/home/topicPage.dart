import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/services/topicService.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/dataModels.dart';
import 'components/iconCount.dart';
import "package:flutter_markdown/flutter_markdown.dart";
import 'package:smartsparks/shared/loading.dart';
import 'components/sparkTile.dart';
import 'newSparkPage.dart';

class TopicPage extends StatelessWidget {

  final String topicID;

  TopicPage({this.topicID});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Topic>.value(
      value: TopicService(topicID: topicID).topic,
      child: TopicPageContent(),
    );
  }
}

class TopicPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final topic = Provider.of<Topic>(context);

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
                    child: BottomContent(topicID: topic != null ? topic.topicID : null,),
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
            MaterialPageRoute(builder: (context) => NewSparkPage(topic)),
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

    final topic = Provider.of<Topic>(context);
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

    return topic != null ? ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            topic.title,
            style: TextStyle(color: white),
          ),
          subtitle: Text(
            "Posted by " + topic.creatorUsername,
            style: TextStyle(color: lightGray),
          ),
          trailing: IconCount(count: topic.sparksCount, icon: Icons.star, iconColor: yellow, textColor: white),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: MarkdownBody(
            data: topic.description,
            styleSheet: mdStyle,
          ),
        )
      ],
    ) : Loading();
  }
}

class BottomContent extends StatelessWidget {

  final String topicID;

  BottomContent({this.topicID});

  @override
  Widget build(BuildContext context) {
    return topicID != null ? StreamProvider<List<Spark>>.value(
      value: TopicService(topicID: topicID).sparks,
      child: SparksList(topicID: topicID),
    ) : Loading();
  }
}

class SparksList extends StatelessWidget {

  final String topicID;

  SparksList({this.topicID});

  @override
  Widget build(BuildContext context) {

    final sparks = Provider.of<List<Spark>>(context);

    return sparks != null && sparks.length != 0 ? ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: sparks.length,
      itemBuilder: (BuildContext context, int index) {
        return SparkTile(spark: sparks[index], tapEnabled: true, topicID: topicID);
      },
    ) : Center(
      child: Text(
        "Be the first to post a spark on this topic !",
        style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}