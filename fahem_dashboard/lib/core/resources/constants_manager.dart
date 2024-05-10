import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';
import 'package:flutter/material.dart';

class ConstantsManager {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String fahemDashboardPlayStoreUrl = 'https://play.google.com/store/apps/details?id=com.app.fahem_dashboard';
  static const String fahemDashboardImageFromFile = '/data/user/0/com.app.fahem_dashboard/cache/';
  static const String fahemKeyword = 'fahem';
  static const String fahemBusinessKeyword = 'fahemBusiness';

  // region Prefix & Suffix
  static const String whatsappPrefix = 'https://wa.me/+';
  static const String phoneNumberPrefix = 'tel:+';
  static const String emailAddressSuffix = '@gmail.com';
  static const String emailPrefix = 'mailto:';
  // endregion

  // region Constants
  static const String empty = '';
  static const String space = ' ';
  static const String english = "english";
  static const String arabic = "arabic";
  static const String dialingCodeEgypt = '2';
  static const String countryIdEgypt = 'EG20';
  static const String desc = 'DESC';
  static const String asc = 'ASC';
  static const int maxNumberToShowSliders = 20;
  static const int numberOfStatsItemsInRow = 3;
  static const int numberOfMainItemsInRow = 4;
  // endregion

  // region Scheme
  static const String facebookScheme = 'https://www.facebook.com/PAGE OR PROFILE';
  static const String messengerScheme = 'http://m.me/USERNAME';
  static const String telegramScheme = 'https://t.me/CHANNEL_NAME';
  static const String youtubeScheme = 'https://youtu.be/ID';
  static const String twitterScheme = 'https://twitter.com/NAME';
  static const String gmailScheme = 'abc@example.com';
  static const String phoneScheme = '01111111111';
  // endregion

  // region Durations
  static const int durationBetweenEachCharacter = 80;
  static const int delayedTyperAnimatedText = 100;
  static const int pageTransitionDuration = 300;
  static const int onBoardingPageViewDuration = 300;
  static const int splashScreenDuration = 0;
  static const int splashLoadingDuration = 300;
  static const int drawerAnimationDuration = 300;
  static const int slidersDotsAnimationDuration = 300;
  static const int bottomSheetClosedDuration = 2;
  static const int scrollToMaxChatDuration = 200;
  static const int showCommentDuration = 500;
  static const int goToTopDuration = 300;
  static const int countupDuration = 500;
  // endregion

  static const CountryModel egyptCountryModel = CountryModel(
    countryId: 'EG20',
    countryNameAr: 'مصر',
    countryNameEn: 'Egypt',
    countryCode: 'EG',
    dialingCode: '+2',
    flag: '$flagsImagesPath/eg.png',
  );
}