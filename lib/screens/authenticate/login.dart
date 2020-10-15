import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/services/auth.dart';

class Login extends StatefulWidget {

  final Function toggleLogin;

  Login({this.toggleLogin});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
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
              'Register',
              style: TextStyle(color: white),
            ),
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
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
                              "Login",
                              style: TextStyle(color: white, fontSize: 40, fontWeight: FontWeight.bold)
                            )
                          )
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) => val.isEmpty ? 'Please enter an email' : null,
                                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                validator: (val) => val.length < 8 ? 'Enter an 8+ character password' : null,
                                obscureText: true,
                                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                              SizedBox(height: 30,),
                              RaisedButton(
                                color: yellow,
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth.login(email, password);
                                    if(result == null) {
                                      print('Unsuccessful');
                                    }
                                  }
                                },
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
        ),
      )
    );
  }
}