import 'package:flutter/material.dart';
import 'package:smartsparks/shared/constants.dart';
import 'package:smartsparks/services/auth.dart';
import 'package:smartsparks/screens/home/profile.dart';

class OptionsTab extends StatefulWidget {
  @override
  _OptionsTabState createState() => _OptionsTabState();
}

class _OptionsTabState extends State<OptionsTab> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: yellow,
            ),
            child: Text(
              'Options',
              style: TextStyle(
                color: white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.swap_horiz),
            title: Text('Switch view'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage accounts'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Logout'),
            onTap: () {
              dynamic result = _auth.logout();
              if (result == null) {
                print('Unsuccessful');
              }
            },
          ),
        ],
      ),
    );
  }
}