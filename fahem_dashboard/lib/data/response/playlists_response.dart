import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';

class PlaylistsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<PlaylistModel> playlists;

  PlaylistsResponse({
    required this.base,
    required this.pagination,
    required this.playlists,
  });

  PlaylistsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    playlists = List.from(json['playlists']).map((e) => PlaylistModel.fromJson(e)).toList();
  }
}