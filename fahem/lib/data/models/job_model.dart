import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/account_model.dart';

class JobModel {
  late final int jobId;
  late final int accountId;
  late final String image;
  late final String jobTitle;
  late final String companyName;
  late final String aboutCompany;
  late final int minSalary;
  late final int maxSalary;
  late final String jobLocation;
  late final List<String> features;
  late final String details;
  late final int views;
  late JobStatus jobStatus;
  late String? reasonOfReject;
  late final bool isAvailable;
  late final String createdAt;

  late final AccountModel account;

  JobModel({
    required this.jobId,
    required this.accountId,
    required this.image,
    required this.jobTitle,
    required this.companyName,
    required this.aboutCompany,
    required this.minSalary,
    required this.maxSalary,
    required this.jobLocation,
    required this.features,
    required this.details,
    required this.views,
    required this.jobStatus,
    required this.reasonOfReject,
    required this.isAvailable,
    required this.createdAt,
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    jobId = int.parse(json['jobId'].toString());
    accountId = int.parse(json['accountId'].toString());
    image = json['image'];
    jobTitle = json['jobTitle'];
    companyName = json['companyName'];
    aboutCompany = json['aboutCompany'];
    minSalary = int.parse(json['minSalary'].toString());
    maxSalary = int.parse(json['maxSalary'].toString());
    jobLocation = json['jobLocation'];
    features = json['features'].toString().isEmpty ? [] : json['features'].toString().split('--');
    details = json['details'];
    views = int.parse(json['views'].toString());
    jobStatus = JobStatus.values.firstWhere((element) => element.name == json['jobStatus']);
    reasonOfReject = json['reasonOfReject'];
    isAvailable = json['isAvailable'];
    createdAt = json['createdAt'];

    account = AccountModel.fromJson(json['account']);
  }
}