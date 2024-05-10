import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/presentation/shared/controllers/app_provider.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/controllers/social_media_provider.dart';

class MyProviders {
  static late AppProvider appProvider;
  static late AuthenticationProvider authenticationProvider;
  static late SocialMediaProvider socialMediaProvider;

  static init(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context, listen: false);
    authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    socialMediaProvider = Provider.of<SocialMediaProvider>(context, listen: false);
  }
}