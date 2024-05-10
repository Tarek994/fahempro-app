import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditUserProfileUseCase extends BaseUseCase<UserModel, EditUserProfileParameters> {
  final BaseRepository _baseRepository;

  EditUserProfileUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(EditUserProfileParameters parameters) async {
    return await _baseRepository.editUserProfile(parameters);
  }
}

class EditUserProfileParameters {
  int userId;
  String fullName;
  String? personalImage;
  String? coverImage;
  String? bio;
  String? emailAddress;
  String dialingCode;
  String phoneNumber;
  String? birthDate;
  String? countryId;
  Gender? gender;
  double? latitude;
  double? longitude;

  EditUserProfileParameters({
    required this.userId,
    required this.fullName,
    required this.personalImage,
    required this.coverImage,
    required this.bio,
    required this.emailAddress,
    required this.dialingCode,
    required this.phoneNumber,
    required this.birthDate,
    required this.countryId,
    required this.gender,
    required this.latitude,
    required this.longitude,
  });
}