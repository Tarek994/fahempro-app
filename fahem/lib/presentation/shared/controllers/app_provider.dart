import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {

  AppProvider({required isEnglish, required isLight, required version}) {
    _isEnglish = isEnglish;
    _isLight = isLight;
    _version = version;
  }

  bool _isEnglish = false;
  bool get isEnglish => _isEnglish;
  changeIsEnglish(bool isEnglish) {_isEnglish = isEnglish; notifyListeners();}

  bool _isLight = true;
  bool get isLight => _isLight;
  changeIsLight(bool isLight) {_isLight = isLight; notifyListeners();}

  String _version = '';
  String get version => _version;
  setVersion(String version) => _version = version;
}