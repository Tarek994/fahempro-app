import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/user_model.dart';

class WalletHistoryModel {
  late final int walletHistoryId;
  late final UserType userType;
  late final int? accountId;
  late final int? userId;
  late final int amount;
  late final WalletTransactionType walletTransactionType;
  late final String textAr;
  late final String textEn;
  late final String createdAt;

  late final AccountModel? account;
  late final UserModel? user;

  WalletHistoryModel({
    required this.walletHistoryId,
    required this.userType,
    required this.accountId,
    required this.userId,
    required this.amount,
    required this.walletTransactionType,
    required this.textAr,
    required this.textEn,
    required this.createdAt,
  });

  WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    walletHistoryId = int.parse(json['walletHistoryId'].toString());
    userType = UserType.values.firstWhere((element) => element.name == json['userType']);
    accountId = json['accountId'] == null ? null : int.parse(json['accountId'].toString());
    userId = json['userId'] == null ? null : int.parse(json['userId'].toString());
    amount = int.parse(json['amount'].toString());
    walletTransactionType = WalletTransactionType.values.firstWhere((element) => element.name == json['walletTransactionType']);
    textAr = json['textAr'];
    textEn = json['textEn'];
    createdAt = json['createdAt'];

    account = json['account'] == null ? null : AccountModel.fromJson(json['account']);
    user = json['user'] == null ? null : UserModel.fromJson(json['user']);
  }
}