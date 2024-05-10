import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/presentation/shared/controllers/app_provider.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';

class MyProviders {
  static late AppProvider appProvider;
  static late AuthenticationProvider authenticationProvider;

  static init(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
  }
}