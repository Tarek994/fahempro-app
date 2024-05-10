import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';

class CategoriesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<CategoryModel> categories;

  CategoriesResponse({
    required this.base,
    required this.pagination,
    required this.categories,
  });

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    categories = List.from(json['categories']).map((e) => CategoryModel.fromJson(e)).toList();
  }
}