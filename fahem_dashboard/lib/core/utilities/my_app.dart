import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/theme_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_behavior.dart';
import 'package:fahem_dashboard/presentation/shared/controllers/app_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // Named Constructor

  static const MyApp _instance = MyApp._internal(); // Singleton

  factory MyApp() => _instance; // Factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Methods.getText(StringsManager.appName).toTitleCase(),
          theme: getApplicationTheme(isEnglish: provider.isEnglish, isLight: provider.isLight),
          themeMode: provider.isLight ? ThemeMode.light : ThemeMode.dark,
          onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
          navigatorKey: ConstantsManager.navigatorKey,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
        );
      }
    );
  }
}