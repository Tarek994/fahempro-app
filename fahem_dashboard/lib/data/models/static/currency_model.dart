class CurrencyModel {
  final String currencyId;
  final String currencyNameAr;
  final String currencyNameEn;
  final String currencySymbolAr;
  final String isoCode;

  const CurrencyModel({
    required this.currencyId,
    required this.currencyNameAr,
    required this.currencyNameEn,
    required this.currencySymbolAr,
    required this.isoCode,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      currencyId: json['currencyId'],
      currencyNameAr: json['currencyNameAr'],
      currencyNameEn: json['currencyNameEn'],
      currencySymbolAr: json['currencySymbolAr'],
      isoCode: json['isoCode'],
    );
  }

  static Map<String, dynamic> toMap(CurrencyModel currencyModel) {
    return {
      'currencyId': currencyModel.currencyId,
      'currencyNameAr': currencyModel.currencyNameAr,
      'currencyNameEn': currencyModel.currencyNameEn,
      'currencySymbolAr': currencyModel.currencySymbolAr,
      'isoCode': currencyModel.isoCode,
    };
  }

  static List<CurrencyModel> fromJsonList (List<dynamic> list) => list.map<CurrencyModel>((item) => CurrencyModel.fromJson(item)).toList();

  static List<Map<String, dynamic>> toMapList(List<CurrencyModel> list) => list.map<Map<String, dynamic>>((item) => CurrencyModel.toMap(item)).toList();
}