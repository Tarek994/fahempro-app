class StatisticModel {
  late final String label;
  late final String titleAr;
  late final String titleEn;
  late final int count;
  late final bool inMain;
  late final bool inFinancialAccounts;

  StatisticModel({
    required this.label,
    required this.titleAr,
    required this.titleEn,
    required this.count,
    required this.inMain,
    required this.inFinancialAccounts,
  });

  StatisticModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    count = int.parse(json['count'].toString());
    inMain = json['inMain'] ?? false;
    inFinancialAccounts = json['inFinancialAccounts'] ?? false;
  }
}