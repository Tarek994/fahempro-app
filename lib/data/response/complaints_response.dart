import 'package:fahem/data/models/complaint_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class ComplaintsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<ComplaintModel> complaints;

  ComplaintsResponse({
    required this.base,
    required this.pagination,
    required this.complaints,
  });

  ComplaintsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    complaints = List.from(json['complaints']).map((e) => ComplaintModel.fromJson(e)).toList();
  }
}