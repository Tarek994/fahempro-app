import 'package:fahem_business/data/models/review_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class ReviewsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<ReviewModel> reviews;

  ReviewsResponse({
    required this.base,
    required this.pagination,
    required this.reviews,
  });

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    reviews = List.from(json['reviews']).map((e) => ReviewModel.fromJson(e)).toList();
  }
}