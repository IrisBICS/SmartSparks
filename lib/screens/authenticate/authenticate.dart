import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showLogin = true;

  void toggleLogin() {
    setState(() => showLogin = !showLogin);
  }
  
  @override

  Widget build(BuildContext context) {
    return showLogin ? Login(toggleLogin: toggleLogin,) : Register(toggleLogin: toggleLogin,);
  }
}