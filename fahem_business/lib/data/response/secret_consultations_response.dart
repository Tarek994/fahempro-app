import 'package:fahem_business/data/models/secret_consultation_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class SecretConsultationsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<SecretConsultationModel> secretConsultations;

  SecretConsultationsResponse({
    required this.base,
    required this.pagination,
    required this.secretConsultations,
  });

  SecretConsultationsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    secretConsultations = List.from(json['secretConsultations']).map((e) => SecretConsultationModel.fromJson(e)).toList();
  }
}