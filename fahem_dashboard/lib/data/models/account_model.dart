import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/data_source/static/appointment_booking_data.dart';
import 'package:fahem_dashboard/data/data_source/static/countries_data.dart';
import 'package:fahem_dashboard/data/data_source/static/governorates_data.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/data/models/static/appointment_booking_model.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';
import 'package:fahem_dashboard/data/models/static/governorate_model.dart';

class AccountModel {
  late final int accountId;
  late final int mainCategoryId;
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
  late final double? latitude;
  late final double? longitude;
  late int balance;
  late final bool isFeatured;
  late final SignInMethod signInMethod;
  late final AccountStatus accountStatus;
  late final String? reasonOfReject;
  late final String? jobTitle;
  late final String? address;
  late final int? consultationPrice;
  late final List<String> tasks;
  late final List<String> features;
  late final List<String> photoGallery;
  late final String? governorateId;
  late final bool isBookingByAppointment;
  late final List<String> availablePeriods;
  late final List<String> identificationImages;
  late final String? nationalId;
  late final String? nationalImageFrontSide;
  late final String? nationalImageBackSide;
  late final String? cardNumber;
  late final String? cardImage;
  late final String createdAt;

  late final MainCategoryModel mainCategory;
  late final List<CategoryModel> categories;
  late final List<ServiceModel> services;
  late final double rating;
  late final int numberOfReviews;
  late final int numberOfJobs;
  late final int numberOfEmploymentApplications;
  late final int numberOfInstantConsultationsComments;
  late final int numberOfPhoneNumberRequests;
  late final int numberOfBookingAppointments;
  late final int totalExpenses;

  late final CountryModel? country;
  late final CountryModel? dialingCodeModel;
  late final GovernorateModel? governorate;
  late final List<AppointmentBookingModel> appointmentBooking;

  AccountModel({
    required this.accountId,
    required this.mainCategoryId,
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
    required this.accountStatus,
    required this.reasonOfReject,
    required this.jobTitle,
    required this.address,
    required this.consultationPrice,
    required this.tasks,
    required this.features,
    required this.photoGallery,
    required this.governorateId,
    required this.isBookingByAppointment,
    required this.availablePeriods,
    required this.identificationImages,
    required this.nationalId,
    required this.nationalImageFrontSide,
    required this.nationalImageBackSide,
    required this.cardNumber,
    required this.cardImage,
    required this.createdAt,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    accountId = int.parse(json['accountId'].toString());
    mainCategoryId = int.parse(json['mainCategoryId'].toString());
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
    accountStatus = AccountStatus.values.firstWhere((element) => element.name == json['accountStatus']);
    reasonOfReject = json['reasonOfReject'];
    jobTitle = json['jobTitle'];
    address = json['address'];
    consultationPrice = json['consultationPrice'] == null ? null : int.parse(json['consultationPrice'].toString());
    tasks = json['tasks'].toString().isEmpty ? [] : json['tasks'].toString().split('--');
    features = json['features'].toString().isEmpty ? [] : json['features'].toString().split('--');
    photoGallery = json['photoGallery'].toString().isEmpty ? [] : json['photoGallery'].toString().split('--');
    governorateId = json['governorateId'];
    isBookingByAppointment = json['isBookingByAppointment'];
    availablePeriods = json['availablePeriods'].toString().isEmpty ? [] : json['availablePeriods'].toString().split('--');
    identificationImages = json['identificationImages'].toString().isEmpty ? [] : json['identificationImages'].toString().split('--');
    nationalId = json['nationalId'];
    nationalImageFrontSide = json['nationalImageFrontSide'];
    nationalImageBackSide = json['nationalImageBackSide'];
    cardNumber = json['cardNumber'];
    cardImage = json['cardImage'];
    createdAt = json['createdAt'];

    mainCategory = MainCategoryModel.fromJson(json['mainCategory']);
    categories = List.from(json['categories']).map((e) => CategoryModel.fromJson(e)).toList();
    services = List.from(json['services']).map((e) => ServiceModel.fromJson(e)).toList();
    rating = double.parse(json['rating'].toString());
    numberOfReviews = int.parse(json['numberOfReviews'].toString());
    numberOfJobs = int.parse(json['numberOfJobs'].toString());
    numberOfEmploymentApplications = int.parse(json['numberOfEmploymentApplications'].toString());
    numberOfInstantConsultationsComments = int.parse(json['numberOfInstantConsultationsComments'].toString());
    numberOfPhoneNumberRequests = int.parse(json['numberOfPhoneNumberRequests'].toString());
    numberOfBookingAppointments = int.parse(json['numberOfBookingAppointments'].toString());
    totalExpenses = int.parse(json['totalExpenses'].toString());

    country = json['countryId'] == null ? null : countriesData.firstWhere((element) => element.countryId == json['countryId']);
    dialingCodeModel = json['dialingCode'] == null ? null : countriesData.firstWhere((element) => element.dialingCode == json['dialingCode']);
    governorate = json['governorateId'] == null ? null : governoratesData.firstWhere((element) => element.governorateId == json['governorateId']);

    appointmentBooking = [];
    List<String> availablePeriodsList = json['availablePeriods'].toString().split('--');
    for(int i=0; i<availablePeriodsList.length; i++) {
      int index = appointmentBookingData.indexWhere((element) => element.appointmentBookingId == availablePeriodsList[i]);
      if(index != -1) {appointmentBooking.add(appointmentBookingData[index]);}
    }
  }
}