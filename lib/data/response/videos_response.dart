import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class VideosResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<VideoModel> videos;

  VideosResponse({
    required this.base,
    required this.pagination,
    required this.videos,
  });

  VideosResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    videos = List.from(json['videos']).map((e) => VideoModel.fromJson(e)).toList();
  }
}