import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/data/models/user_model.dart';

class EmploymentApplicationModel {
  late final int employmentApplicationId;
  late final int accountId;
  late final int userId;
  late final int jobId;
  late final String cv;
  late final String createdAt;

  late final AccountModel account;
  late final UserModel user;
  late final JobModel job;

  EmploymentApplicationModel({
    required this.employmentApplicationId,
    required this.accountId,
    required this.userId,
    required this.jobId,
    required this.cv,
    required this.createdAt,
  });

  EmploymentApplicationModel.fromJson(Map<String, dynamic> json) {
    employmentApplicationId = int.parse(json['employmentApplicationId'].toString());
    accountId = int.parse(json['accountId'].toString());
    userId = int.parse(json['userId'].toString());
    jobId = int.parse(json['jobId'].toString());
    cv = json['cv'];
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
    user = UserModel.fromJson(json['user']);
    job = JobModel.fromJson(json['job']);
  }
}