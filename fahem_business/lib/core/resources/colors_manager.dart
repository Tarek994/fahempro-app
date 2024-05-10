import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ColorsManager {
  static const Color lightPrimaryColor = Color(0xff5E7CF7);
  static const Color darkPrimaryColor = Color(0xff121b22);
  static const Color lightSecondaryColor = Color(0xffFF8574);
  static const Color darkSecondaryColor = Color(0xff1f2c34);

  static const Color success = Color(0xff148b38);
  static const Color failure = Color(0xffcd141a);

  static const Color facebook = Color(0xff4267B2);
  static const Color messenger = Color(0xff00B2FF);
  static const Color telegram = Color(0xff229ED9);
  static const Color youtube = Color(0xffd50606);
  static const Color whatsapp = Color(0xff54b162);
  static const Color google = Color(0xffea4335);

  static const Color grey1 = Color(0xfff1eff5);
  static const Color grey2 = Color(0xffe6e9ef);
  static const Color grey3 = Color(0xffafb4bf);

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color amber = Colors.amber;
  static const Color blue = Colors.blue;
  static const Color blueGrey = Colors.blueGrey;

  static const Color red700 = Color(0xffD32F2F);
  static const Color white38 = Colors.white38;
  static const Color black38 = Colors.black38;
  static const Color black54 = Colors.black54;
  static const Color black87 = Colors.black87;
  static const Color grey50 = Color(0xffFAFAFA);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color grey200 = Color(0xffEEEEEE);
  static const Color grey300 = Color(0xffE0E0E0);

  static const gradientColor = LinearGradient(colors: [Color(0xff11998e), Color(0xff38ef7d)], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static BoxShadow boxShadow1 = BoxShadow(blurRadius: SizeManager.s2, spreadRadius: SizeManager.s0, color: ColorsManager.black.withOpacity(0.5));
  static BoxShadow boxShadow2 = BoxShadow(blurRadius: SizeManager.s5, spreadRadius: SizeManager.s1, color: ColorsManager.black.withOpacity(0.1));
}