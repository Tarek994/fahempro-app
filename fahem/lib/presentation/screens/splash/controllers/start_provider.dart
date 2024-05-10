import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/data/models/version_model.dart';
import 'package:fahem/domain/usecases/authentication_user/get_user_with_id_usecase.dart';
import 'package:fahem/domain/usecases/authentication_user/is_user_exist_usecase.dart';
import 'package:fahem/domain/usecases/version/get_version_usecase.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/helper/cache_helper.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/my_providers.dart';

class StartProvider with ChangeNotifier {

  Future<void> goToInitialRoute(BuildContext context, StartProvider startProvider) async {
    bool isFirstOpenApp = CacheHelper.getData(key: CacheHelper.isFirstOpenAppKey) ?? true;
    int? currentUserIdCached = CacheHelper.getData(key: CacheHelper.currentUserIdKey);
    int? currentUserId = currentUserIdCached;

    if(isFirstOpenApp) {
      Methods.routeTo(context, Routes.languageScreen, isPushReplacement: true);
    }
    else {
      if(Platform.isIOS) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.splashScreen, (route) => false);
        return;
      }

      Either<Failure, VersionModel> response = await DependencyInjection.getVersionUseCase.call(GetVersionParameters(app: App.fahem));
      await response.fold((failure) async {
        Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
      }, (versionModel) async {
        await PackageInfo.fromPlatform().then((packageInfo) async {
          if(versionModel.isMaintenanceNow && packageInfo.version == versionModel.version) {
            Methods.routeTo(context, Routes.maintenanceScreen, isPushReplacement: true);
          }
          else {
            if(currentUserId == null) {
              _goTo(context: context, versionModel: versionModel);
            }
            else {
              Either<Failure, bool> response = await DependencyInjection.isUserExistUseCase.call(IsUserExistParameters(userId: currentUserId));
              await response.fold((failure) {
                Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
              }, (isUserExistInDatabase) async {
                if(isUserExistInDatabase) {
                  Either<Failure, UserModel> response = await DependencyInjection.getUserWithIdUseCase.call(GetUserWithIdParameters(userId: currentUserId));
                  await response.fold((failure) {
                    Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
                  }, (user) async {
                    MyProviders.authenticationProvider.setCurrentUser(user);
                    _goTo(context: context, versionModel: versionModel);
                  });
                }
                else {
                  await MyProviders.authenticationProvider.logout(context).then((value) {
                    _goTo(context: context, versionModel: versionModel);
                  }).catchError((error) {
                    LocalFailure failure = LocalFailure(messageAr: 'حدث خطأ', messageEn: 'An error occurred');
                    Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
                  });
                }
              });
            }
          }
        }).catchError((error) {
          debugPrint('PackageInfoError: ${error.toString()}');
          LocalFailure failure = LocalFailure(messageAr: 'حدث خطأ', messageEn: 'An error occurred');
          Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
        });
      });
    }
  }

  Future<void> _goTo({required BuildContext context, required VersionModel versionModel}) async {
    await PackageInfo.fromPlatform().then((packageInfo) async {
      bool isOpenFromUserDevice = packageInfo.version == versionModel.version;
      bool isOpenFromGooglePlayDevice = versionModel.inReview && packageInfo.version != versionModel.version;
      if(isOpenFromUserDevice || isOpenFromGooglePlayDevice) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.splashScreen, (route) => false);
      }
      else {
        if(versionModel.isClearCache) { //  && MyProviders.authenticationProvider.currentUser != null
          await MyProviders.authenticationProvider.logout(context).then((value) {
            Methods.routeTo(context, Routes.updateScreen, arguments: versionModel.isForceUpdate, isPushReplacement: true);
          }).catchError((error) {
            debugPrint('LogoutError: ${error.toString()}');
            LocalFailure failure = LocalFailure(messageAr: 'حدث خطأ', messageEn: 'An error occurred');
            Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
          });
        }
        else {
          Methods.routeTo(context, Routes.updateScreen, arguments: versionModel.isForceUpdate, isPushReplacement: true);
        }
      }
    }).catchError((error) {
      debugPrint('PackageInfoError: ${error.toString()}');
      LocalFailure failure = LocalFailure(messageAr: 'حدث خطأ', messageEn: 'An error occurred');
      Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
    });
  }
}