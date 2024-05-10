import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/data/models/version_model.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/get_admin_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/is_admin_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/get_version_usecase.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/helper/cache_helper.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';

class StartProvider with ChangeNotifier {

  Future<void> goToInitialRoute(BuildContext context, StartProvider startProvider) async {
    bool isFirstOpenApp = CacheHelper.getData(key: CacheHelper.isFirstOpenAppKey) ?? true;
    int? currentAdminIdCached = CacheHelper.getData(key: CacheHelper.currentAdminIdKey);
    int? currentAdminId = currentAdminIdCached;

    if(isFirstOpenApp) {
      Methods.routeTo(context, Routes.languageScreen, isPushReplacement: true);
    }
    else {
      Either<Failure, VersionModel> response = await DependencyInjection.getVersionUseCase.call(GetVersionParameters(app: App.fahemDashboard));
      await response.fold((failure) async {
        Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
      }, (versionModel) async {
        await PackageInfo.fromPlatform().then((packageInfo) async {
          if(versionModel.isMaintenanceNow && packageInfo.version == versionModel.version) {
            Methods.routeTo(context, Routes.maintenanceScreen, isPushReplacement: true);
          }
          else {
            if(currentAdminId == null) {
              _goTo(context: context, versionModel: versionModel);
            }
            else {
              Either<Failure, bool> response = await DependencyInjection.isAdminExistUseCase.call(IsAdminExistParameters(adminId: currentAdminId));
              await response.fold((failure) {
                Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
              }, (isAdminExistInDatabase) async {
                if(isAdminExistInDatabase) {
                  Either<Failure, AdminModel> response = await DependencyInjection.getAdminWithIdUseCase.call(GetAdminWithIdParameters(adminId: currentAdminId));
                  await response.fold((failure) {
                    Methods.routeTo(context, Routes.failureScreen, arguments: failure, isPushReplacement: true);
                  }, (admin) async {
                    MyProviders.authenticationProvider.setCurrentAdmin(admin);
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
    bool isLogged = CacheHelper.getData(key: CacheHelper.currentAdminIdKey) == null ? false : true;

    await PackageInfo.fromPlatform().then((packageInfo) async {
      bool isOpenFromUserDevice = packageInfo.version == versionModel.version;
      bool isOpenFromGooglePlayDevice = versionModel.inReview && packageInfo.version != versionModel.version;
      if(isOpenFromUserDevice || isOpenFromGooglePlayDevice) {
        Navigator.of(context).pushNamedAndRemoveUntil(isLogged ? Routes.splashScreen : Routes.loginScreen, (route) => false);
      }
      else {
        if(versionModel.isClearCache) { //  && MyProviders.authenticationProvider.currentAdmin != null
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