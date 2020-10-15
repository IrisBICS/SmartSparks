import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/optionsTab.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'components/pointGauge.dart';
import 'package:smartsparks/shared/bgImage.dart';

class Profile extends StatefulWidget {

  final SSUser user;

  Profile({this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();

  final int testVal = 150;
  final int testMin = 100;
  final int testMax = 200;
  final String testRank = "Active Contributor";
  final String testUsername = "User 1";

  String newUsername = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Stack(
            children: <Widget>[
              BgImage(),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: SizedBox()),
                          PointGauge(min: testMin, max: testMax, val: testVal, label: "Intuition"),
                          PointGauge(min: testMin, max: testMax, val: testVal, label: "Innovation"),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 50),
                      child: Text(
                        'Rank: ' + testRank,
                        style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]
                            ),
                            TextFormField(
                              validator: (val) => val.isEmpty ? 'Please enter a username' : null,
                              decoration: textInputDecoration.copyWith(hintText: 'Username'),
                              initialValue: testUsername,
                              onChanged: (val) {
                                setState(() => newUsername = val);
                              },
                            ),
                            SizedBox(height: 30,),
                            /* TextFormField(
                              validator: (val) => val.length < 8 ? 'Enter an 8+ character password' : null,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(hintText: 'Old Password'),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                              validator: (val) => val.length < 8 ? 'Enter an 8+ character password' : null,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(hintText: 'New Password'),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 30,), */
                            RaisedButton.icon(
                              icon: Icon(
                                Icons.save, 
                                color: white
                              ),
                              color: yellow,
                              label: Text(
                                'Save',
                                style: TextStyle(color: white, fontSize: 18),
                              ),
                              onPressed: () {
                                _formKey.currentState.validate();
                              },
                            ),
                            SizedBox(height: 50,),
                          ]
                        )
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        )
      ),
      endDrawer: OptionsTab(),
    );
  }
}