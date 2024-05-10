import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';

class WithdrawalRequestsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<WithdrawalRequestModel> withdrawalRequests;

  WithdrawalRequestsResponse({
    required this.base,
    required this.pagination,
    required this.withdrawalRequests,
  });

  WithdrawalRequestsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    withdrawalRequests = List.from(json['withdrawalRequests']).map((e) => WithdrawalRequestModel.fromJson(e)).toList();
  }
}