import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/account_model.dart';

class WithdrawalRequestModel {
  late final int withdrawalRequestId;
  late final int accountId;
  late WithdrawalRequestStatus withdrawalRequestStatus;
  late final String? reasonOfReject;
  late final int balance;
  late final PaymentType paymentType;
  late final String paymentTypeValue;
  late final String createdAt;

  late final AccountModel account;

  WithdrawalRequestModel({
    required this.withdrawalRequestId,
    required this.accountId,
    required this.withdrawalRequestStatus,
    required this.reasonOfReject,
    required this.balance,
    required this.paymentType,
    required this.paymentTypeValue,
    required this.createdAt,
  });

  WithdrawalRequestModel.fromJson(Map<String, dynamic> json) {
    withdrawalRequestId = int.parse( json['withdrawalRequestId'].toString());
    accountId = int.parse( json['accountId'].toString());
    withdrawalRequestStatus = WithdrawalRequestStatus.values.firstWhere((element) => element.name == json['withdrawalRequestStatus']);
    reasonOfReject = json['reasonOfReject'];
    balance = int.parse( json['balance'].toString());
    paymentType = PaymentType.values.firstWhere((element) => element.name == json['paymentType']);
    paymentTypeValue = json['paymentTypeValue'];
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
  }
}