class ServiceDescriptionModel {
  late final String textAr;
  late final String textEn;

  ServiceDescriptionModel({
    required this.textAr,
    required this.textEn,
  });

  ServiceDescriptionModel.fromJson(Map<String, dynamic> json) {
    textAr = json['textAr'];
    textEn = json['textEn'];
  }
}