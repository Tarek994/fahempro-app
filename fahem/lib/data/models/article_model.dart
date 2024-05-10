class ArticleModel {
  late final int articleId;
  late final String image;
  late final String titleAr;
  late final String titleEn;
  late final String articleAr;
  late final String articleEn;
  late int views;
  late final int customOrder;
  late final bool isAvailable;
  late final String createdAt;

  ArticleModel({
    required this.articleId,
    required this.image,
    required this.titleAr,
    required this.titleEn,
    required this.articleAr,
    required this.articleEn,
    required this.views,
    required this.customOrder,
    required this.isAvailable,
    required this.createdAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    articleId = int.parse(json['articleId'].toString());
    image = json['image'];
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    articleAr = json['articleAr'];
    articleEn = json['articleEn'];
    views = int.parse(json['views'].toString());
    customOrder = int.parse(json['customOrder'].toString());
    isAvailable = json['isAvailable'];
    createdAt = json['createdAt'];
  }
}