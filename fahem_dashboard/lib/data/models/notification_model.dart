import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';

class NotificationModel {
  late final int notificationId;
  late final int? userId;
  late final int? accountId;
  late final NotificationTo notificationTo;
  late final NotificationToApp notificationToApp;
  late final String title;
  late final String body;
  late final String createdAt;

  late final UserModel? user;
  late final AccountModel? account;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.accountId,
    required this.notificationTo,
    required this.notificationToApp,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = int.parse(json['notificationId'].toString());
    userId = json['userId'] == null ? null : int.parse(json['userId'].toString());
    accountId = json['accountId'] == null ? null : int.parse(json['accountId'].toString());
    notificationTo = NotificationTo.values.firstWhere((element) => element.name == json['notificationTo']);
    notificationToApp = NotificationToApp.values.firstWhere((element) => element.name == json['notificationToApp']);
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];

    user = json['user'] == null ? null : UserModel.fromJson(json['user']);
    account = json['account'] == null ? null : AccountModel.fromJson(json['account']);
  }
}