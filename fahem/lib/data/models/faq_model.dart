class FaqModel {
  late final int faqId;
  late final String questionAr;
  late final String questionEn;
  late final String answerAr;
  late final String answerEn;
  late final String createdAt;

  FaqModel({
    required this.faqId,
    required this.questionAr,
    required this.questionEn,
    required this.answerAr,
    required this.answerEn,
    required this.createdAt,
  });

  FaqModel.fromJson(Map<String, dynamic> json) {
    faqId = int.parse(json['faqId'].toString());
    questionAr = json['questionAr'];
    questionEn = json['questionEn'];
    answerAr = json['answerAr'];
    answerEn = json['answerEn'];
    createdAt = json['createdAt'];
  }
}