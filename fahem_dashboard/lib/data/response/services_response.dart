import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';

class ServicesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<ServiceModel> services;

  ServicesResponse({
    required this.base,
    required this.pagination,
    required this.services,
  });

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    services = List.from(json['services']).map((e) => ServiceModel.fromJson(e)).toList();
  }
}