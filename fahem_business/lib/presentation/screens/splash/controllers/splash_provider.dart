import 'dart:async';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';

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

    ]).then((_) async {
      Future.delayed(const Duration(seconds: ConstantsManager.splashScreenDuration)).then((_) {
        setIsGetDataDone(true);
        if(_isGetDataDone && _isAnimationDone && !_isErrorOccurred) {
          Methods.routeTo(context, Routes.mainScreen, isPushNamedAndRemoveUntil: true);
        }
      });
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