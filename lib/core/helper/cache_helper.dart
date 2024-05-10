import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String isFirstOpenAppKey = "isFirstOpenApp";
  static const String isEnglishKey = "isEnglish";
  static const String isLightKey = "isLight";
  static const String currentUserIdKey = "currentUserId";

  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    // clearData();
  }

  static Future<bool> setData({required String key, required dynamic value}) async {
    if(value.runtimeType == String) {return await _sharedPreferences.setString(key, value);}
    if(value.runtimeType == bool) {return await _sharedPreferences.setBool(key, value);}
    if(value.runtimeType == int) {return await _sharedPreferences.setInt(key, value);}
    return await _sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}