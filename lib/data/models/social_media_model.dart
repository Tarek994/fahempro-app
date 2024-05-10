class SocialMediaModel {
  late final int socialMediaId;
  late final String image;
  late final String nameAr;
  late final String nameEn;
  late final String link;
  late final bool isAvailable;
  late final String createdAt;

  SocialMediaModel({
    required this.socialMediaId,
    required this.image,
    required this.nameAr,
    required this.nameEn,
    required this.link,
    required this.isAvailable,
    required this.createdAt,
  });

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    socialMediaId = int.parse(json['socialMediaId'].toString());
    image = json['image'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    link = json['link'];
    isAvailable = json['isAvailable'];
    createdAt = json['createdAt'];
  }
}