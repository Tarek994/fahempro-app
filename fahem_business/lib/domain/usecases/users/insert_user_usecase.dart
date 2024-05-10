import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertUserUseCase extends BaseUseCase<UserModel, InsertUserParameters> {
  final BaseRepository _baseRepository;

  InsertUserUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(InsertUserParameters parameters) async {
    return await _baseRepository.insertUser(parameters);
  }
}

class InsertUserParameters {
  String fullName;
  String? personalImage;
  String? coverImage;
  String? bio;
  String? emailAddress;
  String? password;
  String dialingCode;
  String phoneNumber;
  String? birthDate;
  String? countryId;
  Gender? gender;
  double? latitude;
  double? longitude;
  int balance;
  bool isFeatured;
  SignInMethod signInMethod;
  String createdAt;

  InsertUserParameters({
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
}