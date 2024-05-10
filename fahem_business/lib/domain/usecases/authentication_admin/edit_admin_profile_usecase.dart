import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/admin_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditAdminProfileUseCase extends BaseUseCase<AdminModel, EditAdminProfileParameters> {
  final BaseRepository _baseRepository;

  EditAdminProfileUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(EditAdminProfileParameters parameters) async {
    return await _baseRepository.editAdminProfile(parameters);
  }
}

class EditAdminProfileParameters {
  int adminId;
  String fullName;
  String? personalImage;
  String? coverImage;
  String? bio;
  String emailAddress;
  String? dialingCode;
  String? phoneNumber;
  String? birthDate;
  String? countryId;
  Gender? gender;
  List<AdminPermissions> permissions;
  bool isSuper;

  EditAdminProfileParameters({
    required this.adminId,
    required this.fullName,
    this.personalImage,
    this.coverImage,
    this.bio,
    required this.emailAddress,
    this.dialingCode,
    this.phoneNumber,
    this.birthDate,
    this.countryId,
    this.gender,
    required this.permissions,
    required this.isSuper,
  });
}