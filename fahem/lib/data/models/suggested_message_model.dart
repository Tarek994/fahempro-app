class SuggestedMessageModel {
  late final int suggestedMessageId;
  late final String messageAr;
  late final String messageEn;
  late final String answerAr;
  late final String answerEn;
  late final String createdAt;

  SuggestedMessageModel({
    required this.suggestedMessageId,
    required this.messageAr,
    required this.messageEn,
    required this.answerAr,
    required this.answerEn,
    required this.createdAt,
  });

  SuggestedMessageModel.fromJson(Map<String, dynamic> json) {
    suggestedMessageId = int.parse(json['suggestedMessageId'].toString());
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    answerAr = json['answerAr'];
    answerEn = json['answerEn'];
    createdAt = json['createdAt'];
  }
}