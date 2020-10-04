import 'package:flutter/material.dart';

const yellow = Color(0xFFffc559);
const lightBrown = Color(0xFFb38a3e);
const darkBrown = Color(0xFF6b5325);
const lightGray = Color(0xFFd4dfec);
const middleGray = Color(0xFF65617d);
const darkGray = Color(0xFF3f3d56);
const skintone = Color(0xFFfbbebe);
const white = Color(0xFFFFFFFF);

const textInputDecoration = InputDecoration(
  fillColor: white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightGray, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: yellow, width: 2.0),
  ),
);