import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/topicsList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Home'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: white,
            ),
            label: Text(
              'Options',
              style: TextStyle(color: white),
            ),
          )
        ]
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 600,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 320, 20, 0),
                    child: SvgPicture.asset('assets/images/undraw_working_late_pukg.svg')
                  )
                ),
              TopicsList(),
              ],
            )
          )
        ]
      )
    );
  }
}