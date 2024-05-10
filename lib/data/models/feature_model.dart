import 'package:fahem/data/models/main_category_model.dart';

class FeatureModel {
  late final int featureId;
  late final int mainCategoryId;
  late final String featureAr;
  late final String featureEn;
  late final String createdAt;

  late final MainCategoryModel mainCategory;

  FeatureModel({
    required this.featureId,
    required this.mainCategoryId,
    required this.featureAr,
    required this.featureEn,
    required this.createdAt,
  });

  FeatureModel.fromJson(Map<String, dynamic> json) {
    featureId = int.parse(json['featureId'].toString());
    mainCategoryId = int.parse(json['mainCategoryId'].toString());
    featureAr = json['featureAr'];
    featureEn = json['featureEn'];
    createdAt = json['createdAt'];

    mainCategory = MainCategoryModel.fromJson(json['mainCategory']);
  }
}