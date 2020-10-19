import 'package:flutter/material.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/topicsList.dart';
import 'components/optionsTab.dart';
import 'newTopicPage.dart';
import 'package:smartsparks/services/database.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
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