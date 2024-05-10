import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class SocialMediaResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<SocialMediaModel> socialMedia;

  SocialMediaResponse({
    required this.base,
    required this.pagination,
    required this.socialMedia,
  });

  SocialMediaResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    socialMedia = List.from(json['socialMedia']).map((e) => SocialMediaModel.fromJson(e)).toList();
  }
}