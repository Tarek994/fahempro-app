import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/user_model.dart';

class PlaylistCommentModel {
  late final int playlistCommentId;
  late final int playlistId;
  late final int userId;
  late final String comment;
  late final String createdAt;

  late final PlaylistModel playlist;
  late final UserModel user;

  PlaylistCommentModel({
    required this.playlistCommentId,
    required this.playlistId,
    required this.userId,
    required this.comment,
    required this.createdAt,
  });

  PlaylistCommentModel.fromJson(Map<String, dynamic> json) {
    playlistCommentId = int.parse(json['playlistCommentId'].toString());
    playlistId = int.parse(json['playlistId'].toString());
    userId = int.parse(json['userId'].toString());
    comment = json['comment'];
    createdAt = json['createdAt'];

    playlist = PlaylistModel.fromJson(json['playlist']);
    user = UserModel.fromJson(json['user']);
  }
}