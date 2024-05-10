import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/version_model.dart';
import 'package:fahem_business/domain/usecases/authentication_account/get_account_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/is_account_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/version/get_version_usecase.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/helper/cache_helper.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';

class StartProvider with ChangeNotifier {

  Future<void> goToInitialRoute(BuildContext context, StartProvider startProvider) async {
    bool isFirstOpenApp = CacheHelper.getData(key: CacheHelper.isFirstOpenAppKey) ?? true;
    int? currentAccountIdCached = CacheHelper.getData(key: CacheHelper.currentAccountIdKey);
    int? currentAccountId = currentAccountIdCached;

    if(isFirstOpenApp) {
      Methods.routeTo(context, Routes.languageScreen, isPushReplacement: true);
    }
    else {
      if(Platform.isIOS) {
        bool isLogged = CacheHelper.getData(key: CacheHelper.currentAccountIdKey) == null ? false : true;
        Navigator.of(context).pushNamedAndRemoveUntil(isLogged ? Routes.splashScreen : Routes.loginScreen, (route) => false);
        return;
      }

      Either<Failure, VersionModel> response = await DependencyInjection.getVersionUseCase.call(GetVersionParameters(app: App.fahemBusiness));
      await response.fold((failure) async {
        Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
      }, (versionModel) async {
        await PackageInfo.fromPlatform().then((packageInfo) async {
          if(versionModel.isMaintenanceNow && (packageInfo.version != versionModel.version)) {
            Methods.routeTo(context, Routes.maintenanceScreen, isPushReplacement: true);
          }
          else {
            if(currentAccountId == null) {
              _goTo(context: context, versionModel: versionModel);
            }
            else {
              Either<Failure, bool> response = await DependencyInjection.isAccountExistUseCase.call(IsAccountExistParameters(accountId: currentAccountId));
              await response.fold((failure) {
                Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
              }, (isAccountExistInDatabase) async {
                if(isAccountExistInDatabase) {
                  Either<Failure, AccountModel> response = await DependencyInjection.getAccountWithIdUseCase.call(GetAccountWithIdParameters(accountId: currentAccountId));
                  await response.fold((failure) {
                    Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
                  }, (account) async {
                    MyProviders.authenticationProvider.setCurrentAccount(account);
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
        bool isLogged = CacheHelper.getData(key: CacheHelper.currentAccountIdKey) == null ? false : true;
        Navigator.of(context).pushNamedAndRemoveUntil(isLogged ? Routes.splashScreen : Routes.loginScreen, (route) => false);
      }
      else {
        if(versionModel.isClearCache) { //  && MyProviders.authenticationProvider.currentAccount != null
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