import 'package:fahem/data/models/playlist_comment_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class PlaylistsCommentsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<PlaylistCommentModel> playlistsComments;

  PlaylistsCommentsResponse({
    required this.base,
    required this.pagination,
    required this.playlistsComments,
  });

  PlaylistsCommentsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    playlistsComments = List.from(json['playlistsComments']).map((e) => PlaylistCommentModel.fromJson(e)).toList();
  }
}