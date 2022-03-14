import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xff01569e);
  static const grey = Color(0xff2c3941);
  static const lightgrey = Color(0xffeef2f5);
  static const orange = Color(0xfff65446);
}

class AppFonts {
  static const headline1 = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
  );

  static const headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
}
