import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/topicsList.dart';
import 'package:smartsparks/services/auth.dart';
import 'components/optionsTab.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

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
      ),
      endDrawer: OptionsTab(),
    );
  }
}