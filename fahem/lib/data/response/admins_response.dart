import 'package:fahem/data/models/admin_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class AdminsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<AdminModel> admins;

  AdminsResponse({
    required this.base,
    required this.pagination,
    required this.admins,
  });

  AdminsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    admins = List.from(json['admins']).map((e) => AdminModel.fromJson(e)).toList();
  }
}