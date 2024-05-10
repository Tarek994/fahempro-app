import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';

class InstantConsultationModel {
  late final int instantConsultationId;
  late final int userId;
  late final String consultation;
  late final bool isViewed;
  late final bool isDone;
  late final int? bestAccountId;
  late final List<String> images;
  late final String createdAt;

  late final UserModel user;
  late final AccountModel? bestAccount;

  InstantConsultationModel({
    required this.instantConsultationId,
    required this.userId,
    required this.consultation,
    required this.isDone,
    required this.bestAccountId,
    required this.isViewed,
    required this.images,
    required this.createdAt,
  });

  InstantConsultationModel.fromJson(Map<String, dynamic> json) {
    instantConsultationId = int.parse(json['instantConsultationId'].toString());
    userId = int.parse(json['userId'].toString());
    consultation = json['consultation'];
    isDone = json['isDone'];
    bestAccountId = json['bestAccountId'] == null ? null : int.parse(json['bestAccountId'].toString());
    isViewed = json['isViewed'];
    images = json['images'].toString().isEmpty ? [] : json['images'].toString().split('--');
    createdAt = json['createdAt'];

    user = UserModel.fromJson(json['user']);
    bestAccount = json['bestAccount'] == null ? null : AccountModel.fromJson(json['bestAccount']);
  }
}