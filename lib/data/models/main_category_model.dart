class MainCategoryModel {
  late final int mainCategoryId;
  late final String nameAr;
  late final String nameEn;
  late final String image;
  late final int customOrder;
  late final int numberOfCategories;
  late final String createdAt;

  MainCategoryModel({
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
    required this.numberOfCategories,
    required this.createdAt,
  });

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    mainCategoryId = int.parse(json['mainCategoryId'].toString());
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    image = json['image'];
    customOrder = int.parse(json['customOrder'].toString());
    numberOfCategories = int.parse(json['numberOfCategories'].toString());
    createdAt = json['createdAt'];
  }
}