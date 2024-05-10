import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class InstantConsultationsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<InstantConsultationModel> instantConsultations;

  InstantConsultationsResponse({
    required this.base,
    required this.pagination,
    required this.instantConsultations,
  });

  InstantConsultationsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    instantConsultations = List.from(json['instantConsultations']).map((e) => InstantConsultationModel.fromJson(e)).toList();
  }
}