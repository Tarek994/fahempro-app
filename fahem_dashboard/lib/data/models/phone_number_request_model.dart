import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';

class PhoneNumberRequestModel {
  late final int phoneNumberRequestId;
  late final int accountId;
  late final int userId;
  late final bool isViewed;
  late final String createdAt;

  late final AccountModel account;
  late final UserModel user;

  PhoneNumberRequestModel({
    required this.phoneNumberRequestId,
    required this.accountId,
    required this.userId,
    required this.isViewed,
    required this.createdAt,
  });

  PhoneNumberRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumberRequestId = int.parse(json['phoneNumberRequestId'].toString());
    accountId = int.parse(json['accountId'].toString());
    userId = int.parse(json['userId'].toString());
    isViewed = json['isViewed'];
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
    user = UserModel.fromJson(json['user']);
  }
}