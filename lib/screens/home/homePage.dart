import 'package:flutter/material.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/topicTile.dart';
import 'components/optionsTab.dart';
import 'newTopicPage.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/dataModels.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final topics = Provider.of<List<Topic>>(context);

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Stack(
            children: <Widget>[
              BgImage(top: 320),
              TopicsList(topics: topics,),
            ],
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTopicPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: yellow,
      ),
      endDrawer: OptionsTab(),
    );
  }
}

class TopicsList extends StatelessWidget {

  final List<Topic> topics;

  TopicsList({this.topics});

  @override
  Widget build(BuildContext context) {
    return topics != null ? ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: topics.length,
      itemBuilder: (BuildContext context, int index) {
        return TopicTile(topic: topics[index], tapEnabled: true);
      },
    ) : Center(
      child: Text(
        "Be the first to add a topic !",
        style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
