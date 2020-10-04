import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartsparks/shared/constants.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: yellow,
        elevation: 0.0,
        title: Text('SmartSparks'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
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
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: white, fontSize: 50, fontWeight: FontWeight.bold)
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