import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';

MaterialColor buildMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (int i = 0; i < strengths.length; i++) {
    double strength = strengths[i];
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

ThemeData getApplicationTheme({required bool isEnglish, required bool isLight}) {
  if(isLight) {
    return _getApplicationThemeLight(isEnglish: isEnglish);
  }
  else {
    return _getApplicationThemeDark(isEnglish: isEnglish);
  }
}

ThemeData _getApplicationThemeLight({required bool isEnglish}) {
  return ThemeData(
    useMaterial3: false,

    // Main Colors
    primarySwatch: buildMaterialColor(ColorsManager.lightPrimaryColor),
    scaffoldBackgroundColor: ColorsManager.grey1,

    // Font Family
    fontFamily: FontFamilyManager.montserratArabic,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ColorsManager.grey1, statusBarIconBrightness: Brightness.dark),
      backgroundColor: ColorsManager.grey1,
      elevation: SizeManager.s0,
      titleTextStyle: TextStyle(
        color: ColorsManager.black,
        fontSize: SizeManager.s16,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontFamilyManager.montserratArabic,
      ),
      iconTheme: IconThemeData(color: ColorsManager.black),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => ColorsManager.lightPrimaryColor),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => ColorsManager.grey300),
      side: const BorderSide(
        color: ColorsManager.grey300,
      )
    ),

    // Text Theme
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: ColorsManager.lightPrimaryColor, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      titleMedium: TextStyle(color: ColorsManager.lightPrimaryColor, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      titleLarge: TextStyle(color: ColorsManager.lightPrimaryColor, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),

      bodySmall: TextStyle(color: ColorsManager.black, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      bodyMedium: TextStyle(color: ColorsManager.black, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      bodyLarge: TextStyle(color: ColorsManager.black, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),

      displaySmall: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      displayMedium: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      displayLarge: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),
    ),
  );
}

ThemeData _getApplicationThemeDark({required bool isEnglish}) {
  return ThemeData(
    useMaterial3: false,

    // Main Colors
    primarySwatch: buildMaterialColor(ColorsManager.darkPrimaryColor),
    scaffoldBackgroundColor: ColorsManager.darkSecondaryColor,

    // Font Family
    fontFamily: FontFamilyManager.montserratArabic,

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ColorsManager.darkSecondaryColor, statusBarIconBrightness: Brightness.light),
      backgroundColor: ColorsManager.darkSecondaryColor,
      elevation: SizeManager.s0,
      titleTextStyle: TextStyle(
        color: ColorsManager.white,
        fontSize: SizeManager.s16,
        fontWeight: FontWeightManager.medium,
        fontFamily: FontFamilyManager.montserratArabic,
      ),
      iconTheme: IconThemeData(color: ColorsManager.white),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => ColorsManager.darkPrimaryColor),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => ColorsManager.darkPrimaryColor),
    ),

    // Text Theme
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: ColorsManager.darkPrimaryColor, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      titleMedium: TextStyle(color: ColorsManager.darkPrimaryColor, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      titleLarge: TextStyle(color: ColorsManager.darkPrimaryColor, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),

      bodySmall: TextStyle(color: ColorsManager.white, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      bodyMedium: TextStyle(color: ColorsManager.white, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      bodyLarge: TextStyle(color: ColorsManager.white, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),

      displaySmall: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s12, fontWeight: FontWeightManager.regular),
      displayMedium: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s14, fontWeight: FontWeightManager.regular),
      displayLarge: TextStyle(color: ColorsManager.grey, fontSize: SizeManager.s16, fontWeight: FontWeightManager.regular),
    ),
  );
}