import 'package:fahem_dashboard/data/models/main_category_model.dart';

class CategoryModel {
  late final int categoryId;
  late final int mainCategoryId;
  late final String nameAr;
  late final String nameEn;
  late final String image;
  late final int customOrder;
  late final String createdAt;

  late final MainCategoryModel mainCategory;

  CategoryModel({
    required this.categoryId,
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
    required this.createdAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = int.parse(json['categoryId'].toString());
    mainCategoryId = int.parse(json['mainCategoryId'].toString());
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    image = json['image'];
    customOrder = int.parse(json['customOrder'].toString());
    createdAt = json['createdAt'];

    mainCategory = MainCategoryModel.fromJson(json['mainCategory']);
  }
}