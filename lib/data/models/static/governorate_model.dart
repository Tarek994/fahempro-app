class GovernorateModel {
  final String governorateId;
  final String governorateNameAr;
  final String governorateNameEn;

  const GovernorateModel({
    required this.governorateId,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      governorateId: json['governorateId'],
      governorateNameAr: json['governorateNameAr'],
      governorateNameEn: json['governorateNameEn'],
    );
  }

  static Map<String, dynamic> toMap(GovernorateModel governorateModel) {
    return {
      'governorateId': governorateModel.governorateId,
      'governorateNameAr': governorateModel.governorateNameAr,
      'governorateNameEn': governorateModel.governorateNameEn,
    };
  }

  static List<GovernorateModel> fromJsonList (List<dynamic> list) => list.map<GovernorateModel>((item) => GovernorateModel.fromJson(item)).toList();

  static List<Map<String, dynamic>> toMapList(List<GovernorateModel> list) => list.map<Map<String, dynamic>>((item) => GovernorateModel.toMap(item)).toList();
}