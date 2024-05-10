import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class PhoneNumberRequestsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<PhoneNumberRequestModel> phoneNumberRequests;

  PhoneNumberRequestsResponse({
    required this.base,
    required this.pagination,
    required this.phoneNumberRequests,
  });

  PhoneNumberRequestsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    phoneNumberRequests = List.from(json['phoneNumberRequests']).map((e) => PhoneNumberRequestModel.fromJson(e)).toList();
  }
}