import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/data_source/static/countries_data.dart';
import 'package:fahem/data/models/static/country_model.dart';

class AdminModel {
  late final int adminId;
  late final String fullName;
  late final String? personalImage;
  late final String? coverImage;
  late final String? bio;
  late final String emailAddress;
  late final String password;
  late final String? dialingCode;
  late final String? phoneNumber;
  late final String? birthDate;
  late final String? countryId;
  late final Gender? gender;
  late final List<AdminPermissions> permissions;
  late final bool isSuper;
  late final String createdAt;

  late final CountryModel? country;
  late final CountryModel? dialingCodeModel;

  AdminModel({
    required this.adminId,
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
    required this.permissions,
    required this.isSuper,
    required this.createdAt,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    adminId = int.parse(json['adminId'].toString());
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
    List<String> permissionsString = json['permissions'].toString().isEmpty ? [] : json['permissions'].toString().split('--');
    permissions = List.generate(permissionsString.length, (index) => AdminPermissions.values.firstWhere((element) => element.name == permissionsString[index]));
    isSuper = json['isSuper'];
    createdAt = json['createdAt'];

    country = json['countryId'] == null ? null : countriesData.firstWhere((element) => element.countryId == json['countryId']);
    dialingCodeModel = json['dialingCode'] == null ? null : countriesData.firstWhere((element) => element.dialingCode == json['dialingCode']);
  }
}