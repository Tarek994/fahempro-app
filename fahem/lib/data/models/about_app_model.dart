class AboutAppModel {
  late final String textAr;
  late final String textEn;

  AboutAppModel({
    required this.textAr,
    required this.textEn,
  });

  AboutAppModel.fromJson(Map<String, dynamic> json) {
    textAr = json['textAr'];
    textEn = json['textEn'];
  }
}