import 'package:fahem_dashboard/data/models/main_category_model.dart';

class ServiceModel {
  late final int serviceId;
  late final int mainCategoryId;
  late final String nameAr;
  late final String nameEn;
  late final String serviceInfoAr;
  late final String serviceInfoEn;
  late final String serviceImage;
  late final String additionalImage;
  late final bool availableForAccount;
  late final bool serviceProviderCanSubscribe;
  late final int customOrder;
  late final String createdAt;

  late final MainCategoryModel mainCategory;

  ServiceModel({
    required this.serviceId,
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.serviceInfoAr,
    required this.serviceInfoEn,
    required this.serviceImage,
    required this.additionalImage,
    required this.availableForAccount,
    required this.serviceProviderCanSubscribe,
    required this.customOrder,
    required this.createdAt,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceId = int.parse(json['serviceId'].toString());
    mainCategoryId = int.parse(json['mainCategoryId'].toString());
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    serviceInfoAr = json['serviceInfoAr'];
    serviceInfoEn = json['serviceInfoEn'];
    serviceImage = json['serviceImage'];
    additionalImage = json['additionalImage'];
    availableForAccount = json['availableForAccount'];
    serviceProviderCanSubscribe = json['serviceProviderCanSubscribe'];
    customOrder = int.parse(json['customOrder'].toString());
    createdAt = json['createdAt'];

    mainCategory = MainCategoryModel.fromJson(json['mainCategory']);
  }
}