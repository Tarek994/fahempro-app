import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/models/user_model.dart';

class UsersResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<UserModel> users;

  UsersResponse({
    required this.base,
    required this.pagination,
    required this.users,
  });

  UsersResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    users = List.from(json['users']).map((e) => UserModel.fromJson(e)).toList();
  }
}