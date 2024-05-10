// import 'dart:convert';
// import 'package:fahem/core/helper/cache_helper.dart';
// import 'package:fahem/data/models/education/teacher_model.dart';
//
// abstract class BaseLocalDataSource {
//   Future<void> saveCurrentTeacherToCache(TeacherModel teacherModel);
//   Future<void> deleteCurrentTeacherFromCache();
// }
//
// class LocalDataSource extends BaseLocalDataSource {
//
//   @override
//   Future<void> saveCurrentTeacherToCache(TeacherModel teacherModel) async {
//     await CacheHelper.setData(key: CacheHelper.currentTeacherKey, value: json.encode(teacherModel.toJson()));
//   }
//
//   @override
//   Future<void> deleteCurrentTeacherFromCache() async {
//     await CacheHelper.removeData(key: CacheHelper.currentTeacherKey);
//   }
// }