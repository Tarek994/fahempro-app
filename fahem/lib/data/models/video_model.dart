import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/user_model.dart';

class VideoModel {
  late final int videoId;
  late final int playlistId;
  late final String titleAr;
  late final String titleEn;
  late final String link;
  late final String aboutVideoAr;
  late final String aboutVideoEn;
  late final String createdAt;

  late final PlaylistModel playlist;

  VideoModel({
    required this.videoId,
    required this.playlistId,
    required this.titleAr,
    required this.titleEn,
    required this.link,
    required this.aboutVideoAr,
    required this.aboutVideoEn,
    required this.createdAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    videoId = int.parse(json['videoId'].toString());
    playlistId = int.parse(json['playlistId'].toString());
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    link = json['link'];
    aboutVideoAr = json['aboutVideoAr'];
    aboutVideoEn = json['aboutVideoEn'];
    createdAt = json['createdAt'];

    playlist = PlaylistModel.fromJson(json['playlist']);
  }
}