class BaseModel {
  late final bool status;
  late final String messageAr;
  late final String messageEn;

  BaseModel({
    required this.status,
    required this.messageAr,
    required this.messageEn,
  });

  BaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
  }
}