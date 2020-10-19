import 'package:flutter/material.dart';
import 'package:smartsparks/services/database.dart';
import 'home/homePage.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/models/dataModels.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return user != null ? StreamProvider<List<Topic>>.value(
      value: DatabaseService(uid: user.uid).topics,
      child: HomePage()
    ) : Authenticate();
  }
}