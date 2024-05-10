class CountryModel {
  final String countryId;
  final String countryNameAr;
  final String countryNameEn;
  final String countryCode;
  final String dialingCode;
  final String flag;

  const CountryModel({
    required this.countryId,
    required this.countryNameAr,
    required this.countryNameEn,
    required this.countryCode,
    required this.dialingCode,
    required this.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryId: json['countryId'],
      countryNameAr: json['countryNameAr'],
      countryNameEn: json['countryNameEn'],
      countryCode: json['countryCode'],
      dialingCode: json['dialingCode'],
      flag: json['flag'],
    );
  }

  static Map<String, dynamic> toMap(CountryModel countryModel) {
    return {
      'countryId': countryModel.countryId,
      'countryNameAr': countryModel.countryNameAr,
      'countryNameEn': countryModel.countryNameEn,
      'countryCode': countryModel.countryCode,
      'dialingCode': countryModel.dialingCode,
      'flag': countryModel.flag,
    };
  }

  static List<CountryModel> fromJsonList (List<dynamic> list) => list.map<CountryModel>((item) => CountryModel.fromJson(item)).toList();

  static List<Map<String, dynamic>> toMapList(List<CountryModel> list) => list.map<Map<String, dynamic>>((item) => CountryModel.toMap(item)).toList();
}