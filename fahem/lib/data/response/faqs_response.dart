import 'package:fahem/data/models/faq_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class FaqsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<FaqModel> faqs;

  FaqsResponse({
    required this.base,
    required this.pagination,
    required this.faqs,
  });

  FaqsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    faqs = List.from(json['faqs']).map((e) => FaqModel.fromJson(e)).toList();
  }
}