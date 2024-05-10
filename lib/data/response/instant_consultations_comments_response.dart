import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class InstantConsultationsCommentsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<InstantConsultationCommentModel> instantConsultationsComments;

  InstantConsultationsCommentsResponse({
    required this.base,
    required this.pagination,
    required this.instantConsultationsComments,
  });

  InstantConsultationsCommentsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    instantConsultationsComments = List.from(json['instantConsultationsComments']).map((e) => InstantConsultationCommentModel.fromJson(e)).toList();
  }
}