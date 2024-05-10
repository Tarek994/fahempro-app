import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditAccountProfileUseCase extends BaseUseCase<AccountModel, EditAccountProfileParameters> {
  final BaseRepository _baseRepository;

  EditAccountProfileUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AccountModel>> call(EditAccountProfileParameters parameters) async {
    return await _baseRepository.editAccountProfile(parameters);
  }
}

class EditAccountProfileParameters {
  int accountId;
  int mainCategoryId;
  String fullName;
  String? personalImage;
  String? coverImage;
  String? bio;
  String emailAddress;
  String password;
  String? dialingCode;
  String? phoneNumber;
  String? birthDate;
  String? countryId;
  Gender? gender;
  double? latitude;
  double? longitude;
  int balance;
  bool isFeatured;
  SignInMethod signInMethod;
  AccountStatus accountStatus;
  String? reasonOfReject;
  String? jobTitle;
  String? address;
  int? consultationPrice;
  List<String> tasks;
  List<String> features;
  List<String> photoGallery;
  String? governorateId;
  bool isBookingByAppointment;
  List<String> availablePeriods;
  List<String> identificationImages;

  List<int> categoriesIds;
  List<int> servicesIds;

  EditAccountProfileParameters({
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

    required this.categoriesIds,
    required this.servicesIds,
  });
}