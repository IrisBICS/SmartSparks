import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGray,
      child: Center(
        child: SpinKitThreeBounce(
          color: yellow,
          size: 50.0,
        ),
      ),
    );
  }
}