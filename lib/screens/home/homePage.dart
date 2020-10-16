import 'package:flutter/material.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/topicsList.dart';
import 'components/optionsTab.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              BgImage(),
              TopicsList(),
            ],
          )
        )
      ),
      endDrawer: OptionsTab(),
    );
  }
}