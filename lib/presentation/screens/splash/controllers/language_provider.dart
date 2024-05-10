import 'package:fahem/presentation/screens/splash/controllers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/helper/cache_helper.dart';

class LanguageProvider with ChangeNotifier {

  Future<void> saveLanguage(BuildContext context, bool isEnglish, StartProvider startProvider) async {
    CacheHelper.setData(key: CacheHelper.isEnglishKey, value: isEnglish);

    // Start - Language - Getting Started - On Boarding - Start - Splash or Login
    // Methods.routeTo(context, Routes.gettingStartedScreen);

    // Start - Language - On Boarding - Start - Splash or Login
    // Methods.routeTo(context, Routes.onBoardingScreen);

    // Start - Language - Start - Splash or Login
    CacheHelper.setData(key: CacheHelper.isFirstOpenAppKey, value: false);
    await startProvider.goToInitialRoute(context, startProvider);
  }
}