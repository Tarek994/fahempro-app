class PrivacyPolicyModel {
  late final String textAr;
  late final String textEn;

  PrivacyPolicyModel({
    required this.textAr,
    required this.textEn,
  });

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    textAr = json['textAr'];
    textEn = json['textEn'];
  }
}