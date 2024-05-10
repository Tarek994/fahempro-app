import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/user_model.dart';

class ReviewModel {
  late final int reviewId;
  late final int accountId;
  late final int userId;
  late final String comment;
  late final double rating;
  late final List<String> featuresAr;
  late final List<String> featuresEn;
  late final String createdAt;

  late final AccountModel account;
  late final UserModel user;

  ReviewModel({
    required this.reviewId,
    required this.accountId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.featuresAr,
    required this.featuresEn,
    required this.createdAt,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    reviewId = int.parse(json['reviewId'].toString());
    accountId = int.parse(json['accountId'].toString());
    userId = int.parse(json['userId'].toString());
    comment = json['comment'];
    rating = double.parse(json['rating'].toString());
    featuresAr = json['featuresAr'].toString().isEmpty ? [] : json['featuresAr'].toString().split('--');
    featuresEn = json['featuresEn'].toString().isEmpty ? [] : json['featuresEn'].toString().split('--');
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
    user = UserModel.fromJson(json['user']);
  }
}