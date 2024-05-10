import 'package:fahem_dashboard/data/models/employment_application_model.dart';
import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';

class EmploymentApplicationsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<EmploymentApplicationModel> employmentApplications;

  EmploymentApplicationsResponse({
    required this.base,
    required this.pagination,
    required this.employmentApplications,
  });

  EmploymentApplicationsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    employmentApplications = List.from(json['employmentApplications']).map((e) => EmploymentApplicationModel.fromJson(e)).toList();
  }
}