import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class MainCategoriesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<MainCategoryModel> mainCategories;

  MainCategoriesResponse({
    required this.base,
    required this.pagination,
    required this.mainCategories,
  });

  MainCategoriesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    mainCategories = List.from(json['mainCategories']).map((e) => MainCategoryModel.fromJson(e)).toList();
  }
}