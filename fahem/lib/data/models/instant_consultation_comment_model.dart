import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';

class InstantConsultationCommentModel {
  late final int instantConsultationCommentId;
  late final int instantConsultationId;
  late final int accountId;
  late final String comment;
  late final CommentStatus commentStatus;
  late final String? reasonOfReject;
  late final String createdAt;

  late final InstantConsultationModel instantConsultation;
  late final AccountModel account;

  InstantConsultationCommentModel({
    required this.instantConsultationCommentId,
    required this.instantConsultationId,
    required this.accountId,
    required this.comment,
    required this.commentStatus,
    required this.reasonOfReject,
    required this.createdAt,
  });

  InstantConsultationCommentModel.fromJson(Map<String, dynamic> json) {
    instantConsultationCommentId = int.parse(json['instantConsultationCommentId'].toString());
    instantConsultationId = int.parse(json['instantConsultationId'].toString());
    accountId = int.parse(json['accountId'].toString());
    comment = json['comment'];
    commentStatus = CommentStatus.values.firstWhere((element) => element.name == json['commentStatus']);
    reasonOfReject = json['reasonOfReject'];
    createdAt = json['createdAt'];

    instantConsultation = InstantConsultationModel.fromJson(json['instantConsultation']);
    account = AccountModel.fromJson(json['account']);
  }
}