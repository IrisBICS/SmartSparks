import 'package:flutter/material.dart';
import 'home/home.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = null;

    return user != null ? Home() : Authenticate();
  }
}