import 'package:flutter/material.dart';
import 'package:smartsparks/shared/bgImage.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/services/auth.dart';
import 'package:smartsparks/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleLogin;

  Register({this.toggleLogin});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              child: Stack(
                children: <Widget>[
                  BgImage(top: 320),
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
                                  'Register',
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.register(email, password);
                                    if(result == null) {
                                      setState(() => loading = false);
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