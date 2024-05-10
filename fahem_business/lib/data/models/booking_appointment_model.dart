import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/user_model.dart';

class BookingAppointmentModel {
  late final int bookingAppointmentId;
  late final int accountId;
  late final int userId;
  late final String bookingDate;
  late final bool isViewed;
  late final String createdAt;

  late final AccountModel account;
  late final UserModel user;

  BookingAppointmentModel({
    required this.bookingAppointmentId,
    required this.accountId,
    required this.userId,
    required this.bookingDate,
    required this.isViewed,
    required this.createdAt,
  });

  BookingAppointmentModel.fromJson(Map<String, dynamic> json) {
    bookingAppointmentId = int.parse(json['bookingAppointmentId'].toString());
    accountId = int.parse(json['accountId'].toString());
    userId = int.parse(json['userId'].toString());
    bookingDate = json['bookingDate'];
    isViewed = json['isViewed'];
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
    user = UserModel.fromJson(json['user']);
  }
}