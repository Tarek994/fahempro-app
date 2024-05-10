import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/network/firebase_constants.dart';
import 'package:fahem_business/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/services/notification_service.dart';
import 'package:fahem_business/core/helper/cache_helper.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/my_app.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/shared/controllers/app_provider.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  DependencyInjection.init();
  await NotificationService.init();
  await NotificationService.subscribeToTopic(FirebaseConstants.fahemBusinessTopic);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  await FirebaseFirestore.instance.collection('configs').doc('base_url').get().then((documentSnapshot) async {
    ApiConstants.baseUrl = documentSnapshot.data()!['base_url'];
  });

  await initializeDateFormatting().then((value) {
    runApp(
      Phoenix(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppProvider(
              isEnglish: CacheHelper.getData(key: CacheHelper.isEnglishKey) ?? false,
              isLight: CacheHelper.getData(key: CacheHelper.isLightKey) ?? true,
              version: packageInfo.version,
            )),
            ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
          ],
          child: Builder(
            builder: (context) {
              MyProviders.init(context);
              return MyApp();
            },
          ),
        ),
      ),
    );
  });
}