import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/response/social_media_response.dart';
import 'package:fahem/domain/usecases/social_media/get_social_media_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';

class SplashProvider with ChangeNotifier {

  bool _isGetDataDone = false;
  setIsGetDataDone(bool isGetDataDone) => _isGetDataDone = isGetDataDone;

  bool _isAnimationDone = true;
  setIsAnimationDone(bool isAnimationDone) => _isAnimationDone = isAnimationDone;

  bool _isErrorOccurred = false;
  bool get isErrorOccurred => _isErrorOccurred;
  changeIsErrorOccurred(bool isErrorOccurred) {_isErrorOccurred = isErrorOccurred; notifyListeners();}

  Future<void> getData(BuildContext context) async {
    await Future.wait([
      _getSocialMedia(context),
    ]).then((_) async {
      Future.delayed(const Duration(seconds: ConstantsManager.splashScreenDuration)).then((_) {
        setIsGetDataDone(true);
        if(_isGetDataDone && _isAnimationDone && !_isErrorOccurred) {
          Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
        }
      });
    });
  }

  Future<void> _getSocialMedia(BuildContext context) async {
    GetSocialMediaParameters parameters = GetSocialMediaParameters(
      filtersMap: jsonEncode({'isAvailable': true}),
    );
    Either<Failure, SocialMediaResponse> response = await DependencyInjection.getSocialMediaUseCase.call(parameters);
    await response.fold((failure) async {
      changeIsErrorOccurred(true);
      Dialogs.failureOccurred(context: context, failure: failure);
    }, (socialMediaResponse) async {
      MyProviders.socialMediaProvider.setSocialMedia(socialMediaResponse.socialMedia);
    });
  }

  Future<void> onAnimatedTextKitFinished(BuildContext context) async {
    setIsAnimationDone(true);
    if(_isGetDataDone && _isAnimationDone && !_isErrorOccurred) {
      Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
    }
  }

  Future<void> onPressedTryAgain(BuildContext context) async {
    changeIsErrorOccurred(false);
    await getData(context);
  }
}