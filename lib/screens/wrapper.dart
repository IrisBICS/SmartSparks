import 'package:flutter/material.dart';
import 'home/homePage.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return user != null ? HomePage() : Authenticate();
  }
}