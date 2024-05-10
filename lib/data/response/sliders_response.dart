import 'package:fahem/data/models/slider_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class SlidersResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<SliderModel> sliders;

  SlidersResponse({
    required this.base,
    required this.pagination,
    required this.sliders,
  });

  SlidersResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    sliders = List.from(json['sliders']).map((e) => SliderModel.fromJson(e)).toList();
  }
}