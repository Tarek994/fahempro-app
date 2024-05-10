class PlaylistModel {
  late final int playlistId;
  late final String image;
  late final String playlistNameAr;
  late final String playlistNameEn;
  late final int numberOfVideos;
  late final String createdAt;

  PlaylistModel({
    required this.playlistId,
    required this.image,
    required this.playlistNameAr,
    required this.playlistNameEn,
    required this.numberOfVideos,
    required this.createdAt,
  });

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    playlistId = int.parse(json['playlistId'].toString());
    image = json['image'];
    playlistNameAr = json['playlistNameAr'];
    playlistNameEn = json['playlistNameEn'];
    numberOfVideos = int.parse(json['numberOfVideos'].toString());
    createdAt = json['createdAt'];
  }
}