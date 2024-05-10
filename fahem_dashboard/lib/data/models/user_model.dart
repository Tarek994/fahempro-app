import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/data_source/static/countries_data.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';

class UserModel {
  late final int userId;
  late final String fullName;
  late final String? personalImage;
  late final String? coverImage;
  late final String? bio;
  late final String? emailAddress;
  late final String? password;
  late final String dialingCode;
  late final String phoneNumber;
  late final String? birthDate;
  late final String? countryId;
  late final Gender? gender;
  late final double? latitude;
  late final double? longitude;
  late int balance;
  late final bool isFeatured;
  late final SignInMethod signInMethod;
  late final String createdAt;

  late final int totalRevenues;
  late final CountryModel? country;
  late final CountryModel? dialingCodeModel;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.personalImage,
    required this.coverImage,
    required this.bio,
    required this.emailAddress,
    required this.password,
    required this.dialingCode,
    required this.phoneNumber,
    required this.birthDate,
    required this.countryId,
    required this.gender,
    required this.latitude,
    required this.longitude,
    required this.balance,
    required this.isFeatured,
    required this.signInMethod,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = int.parse(json['userId'].toString());
    fullName = json['fullName'];
    personalImage = json['personalImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    dialingCode = json['dialingCode'];
    phoneNumber = json['phoneNumber'];
    birthDate = json['birthDate'];
    countryId = json['countryId'];
    gender = json['gender'] == null ? null : Gender.values.firstWhere((element) => element.name == json['gender']);
    latitude = json['latitude'] == null ? null : double.parse(json['latitude'].toString());
    longitude = json['longitude'] == null ? null : double.parse(json['longitude'].toString());
    balance = int.parse(json['balance'].toString());
    isFeatured = json['isFeatured'];
    signInMethod = SignInMethod.values.firstWhere((element) => element.name == json['signInMethod']);
    createdAt = json['createdAt'];

    totalRevenues = int.parse(json['totalRevenues'].toString());
    country = json['countryId'] == null ? null : countriesData.firstWhere((element) => element.countryId == json['countryId']);
    dialingCodeModel = json['dialingCode'] == null ? null : countriesData.firstWhere((element) => element.dialingCode == json['dialingCode']);
  }
}