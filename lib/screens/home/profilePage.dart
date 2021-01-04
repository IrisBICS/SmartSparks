import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';
import 'package:smartsparks/shared/constants.dart';
import 'components/optionsTab.dart';
import 'components/pointGauge.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'package:smartsparks/shared/loading.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return user != null ? StreamProvider<SSUser>.value(
      value: DatabaseService(uid: user.uid).ssuser,
      child: Profile(),
    ) : Loading();
  }
}

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();

  String newUsername = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<SSUser>(context);

    return user == null ? Loading() : Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Stack(
            children: <Widget>[
              BgImage(top: 320),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: SizedBox()),
                          PointGauge(val: user.smartPoints, label: "Intuition"),
                          PointGauge(val: user.sparkPoints, label: "Innovation"),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 50),
                      child: Text(
                        'Rank: ' + user.rank,
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
                              initialValue: user.username,
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