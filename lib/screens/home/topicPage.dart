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
            MaterialPageRoute(builder: (context) => NewSparkPage()),
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

  final Spark sampleSpark = Spark(
    creatorID: 'C123',
    creatorRank: 'Novice Contributor',
    title: 'Sample spark',
    parentTopic: 'ID123',
    sparkID: 'S123',
    description: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras aliquet lacinia nisl, sit amet malesuada leo sagittis eget. Aenean maximus convallis lacus, eu ultrices enim convallis ut. Pellentesque sit amet lectus vitae lacus pellentesque consequat at ac augue. Sed efficitur quam a erat pretium, et lacinia dolor bibendum. Fusce eu enim vitae est tristique tincidunt. Integer mattis dolor a est aliquet, ut venenatis mauris faucibus. Fusce ac felis nec urna pharetra lobortis sit amet vel mi. Vivamus ante nisl, hendrerit gravida dolor ac, consequat pretium mi. Fusce scelerisque mollis leo sed malesuada.

Praesent a velit in lectus dictum scelerisque. Sed ultrices vehicula lorem ultricies cursus. Nunc urna ligula, pulvinar eget erat ut, pellentesque imperdiet est. Praesent blandit, lorem sed dictum vestibulum, ex mauris vulputate erat, et imperdiet massa lorem quis mi. Vivamus bibendum id turpis nec viverra. Ut venenatis mi sed massa sollicitudin, non commodo odio maximus. Sed convallis nec mauris eget feugiat. In lacinia massa ac augue pharetra facilisis. Proin efficitur tincidunt faucibus. Nullam vel eleifend dui.
  
Pellentesque non sem fermentum, consequat leo sit amet, pretium odio. Phasellus elementum cursus neque, at euismod risus vestibulum sit amet. Nullam leo sapien, placerat ut aliquam quis, elementum non lorem. Duis varius ligula ac eros condimentum pellentesque. Sed non nisi rhoncus, sodales metus vel, pharetra libero. Nam hendrerit metus velit, at egestas lacus pretium ut. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras vel convallis diam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse potenti.
  ''',
    publishDate: '31/08/2020',
    voters: ['User1', 'User2', 'User3', 'User4'],
    commentsCount: 5,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return SparkTile(spark: sampleSpark, tapEnabled: true);
      },
    );
  }
}