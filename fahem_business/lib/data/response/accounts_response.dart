import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class AccountsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<AccountModel> accounts;

  AccountsResponse({
    required this.base,
    required this.pagination,
    required this.accounts,
  });

  AccountsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    accounts = List.from(json['accounts']).map((e) => AccountModel.fromJson(e)).toList();
  }
}