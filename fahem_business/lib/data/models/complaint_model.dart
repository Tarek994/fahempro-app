import 'package:fahem_business/data/models/user_model.dart';

class ComplaintModel {
  late final int complaintId;
  late final int userId;
  late final String complaint;
  late final String createdAt;
  late final UserModel user;

  ComplaintModel({
    required this.complaintId,
    required this.userId,
    required this.complaint,
    required this.createdAt,
    required this.user,
  });

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    complaintId = int.parse(json['complaintId'].toString());
    userId = int.parse(json['userId'].toString());
    complaint = json['complaint'];
    createdAt = json['createdAt'];
    user = UserModel.fromJson(json['user']);
  }
}