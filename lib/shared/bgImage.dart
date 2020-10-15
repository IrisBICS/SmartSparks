import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BgImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 320, 20, 0),
        child: SvgPicture.asset('assets/images/undraw_working_late_pukg.svg')
      )
    );
  }
}