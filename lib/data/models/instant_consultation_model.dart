import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/data/models/user_model.dart';

class InstantConsultationModel {
  late final int instantConsultationId;
  late final int userId;
  late final String consultation;
  late final bool isViewed;
  late final bool isDone;
  late final int? bestInstantConsultationCommentId;
  late final List<String> images;
  late final String createdAt;

  late final UserModel user;
  late final InstantConsultationCommentModel? bestInstantConsultationComment;

  InstantConsultationModel({
    required this.instantConsultationId,
    required this.userId,
    required this.consultation,
    required this.isDone,
    required this.bestInstantConsultationCommentId,
    required this.isViewed,
    required this.images,
    required this.createdAt,
  });

  InstantConsultationModel.fromJson(Map<String, dynamic> json) {
    instantConsultationId = int.parse(json['instantConsultationId'].toString());
    userId = int.parse(json['userId'].toString());
    consultation = json['consultation'];
    isDone = json['isDone'];
    bestInstantConsultationCommentId = json['bestInstantConsultationCommentId'] == null ? null : int.parse(json['bestInstantConsultationCommentId'].toString());
    isViewed = json['isViewed'];
    images = json['images'].toString().isEmpty ? [] : json['images'].toString().split('--');
    createdAt = json['createdAt'];

    user = UserModel.fromJson(json['user']);
    bestInstantConsultationComment = json['bestInstantConsultationComment'] == null ? null : InstantConsultationCommentModel.fromJson(json['bestInstantConsultationComment']);
  }
}