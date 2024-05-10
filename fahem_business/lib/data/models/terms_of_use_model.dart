class TermsOfUseModel {
  late final String textAr;
  late final String textEn;

  TermsOfUseModel({
    required this.textAr,
    required this.textEn,
  });

  TermsOfUseModel.fromJson(Map<String, dynamic> json) {
    textAr = json['textAr'];
    textEn = json['textEn'];
  }
}