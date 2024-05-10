import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/user_model.dart';

class SecretConsultationModel {
  late final int secretConsultationId;
  late final int userId;
  late final String consultation;
  late final bool isViewed;
  late final bool isReplied;
  late final SecretConsultationReplyType secretConsultationReplyType;
  late final String replyTypeValue;
  late final List<String> images;
  late final String createdAt;

  late final UserModel user;

  SecretConsultationModel({
    required this.secretConsultationId,
    required this.userId,
    required this.consultation,
    required this.isViewed,
    required this.isReplied,
    required this.secretConsultationReplyType,
    required this.replyTypeValue,
    required this.images,
    required this.createdAt,
  });

  SecretConsultationModel.fromJson(Map<String, dynamic> json) {
    secretConsultationId = int.parse(json['secretConsultationId'].toString());
    userId = int.parse(json['userId'].toString());
    consultation = json['consultation'];
    isViewed = json['isViewed'];
    isReplied = json['isReplied'];
    secretConsultationReplyType = SecretConsultationReplyType.values.firstWhere((element) => element.name == json['secretConsultationReplyType']);
    replyTypeValue = json['replyTypeValue'];
    images = json['images'].toString().isEmpty ? [] : json['images'].toString().split('--');
    createdAt = json['createdAt'];

    user = UserModel.fromJson(json['user']);
  }
}