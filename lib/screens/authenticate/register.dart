import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsparks/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleLogin;

  Register({this.toggleLogin});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('SmartSparks'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleLogin();
            },
            icon: Icon(
              Icons.person,
              color: white,
            ),
            label: Text(
              'Login',
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
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 35, 40, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(color: white, fontSize: 40, fontWeight: FontWeight.bold)
                          )
                        )
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Email'),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'Password'),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 30,),
                            RaisedButton(
                              color: yellow,
                              child: Text(
                                'Register',
                                style: TextStyle(color: white, fontSize: 18),
                              ),
                              onPressed: () {},
                            )
                          ]
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}