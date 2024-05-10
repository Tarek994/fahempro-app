import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class JobsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<JobModel> jobs;

  JobsResponse({
    required this.base,
    required this.pagination,
    required this.jobs,
  });

  JobsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    jobs = List.from(json['jobs']).map((e) => JobModel.fromJson(e)).toList();
  }
}