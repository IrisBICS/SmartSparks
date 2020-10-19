import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/services/database.dart';
import 'components/newTopic.dart';

class NewTopicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProviderUser>(context);

    return StreamProvider<SSUser>.value(
      value: DatabaseService(uid: user.uid).ssuser,
      child: NewTopic(),
    );
  }
}