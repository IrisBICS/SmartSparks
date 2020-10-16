import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';
import 'profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return StreamProvider<SSUser>.value(
      value: DatabaseService(uid: user.uid).ssuser,
      child: Profile(),
    );
  }
}