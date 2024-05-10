import 'package:fahem_business/data/models/feature_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class FeaturesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<FeatureModel> features;

  FeaturesResponse({
    required this.base,
    required this.pagination,
    required this.features,
  });

  FeaturesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    features = List.from(json['features']).map((e) => FeatureModel.fromJson(e)).toList();
  }
}