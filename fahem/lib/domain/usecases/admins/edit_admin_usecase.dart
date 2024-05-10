import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/admin_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditAdminUseCase extends BaseUseCase<AdminModel, EditAdminParameters> {
  final BaseRepository _baseRepository;

  EditAdminUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(EditAdminParameters parameters) async {
    return await _baseRepository.editAdmin(parameters);
  }
}

class EditAdminParameters {
  int adminId;
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
  List<AdminPermissions> permissions;
  bool isSuper;

  EditAdminParameters({
    required this.adminId,
    required this.fullName,
    this.personalImage,
    this.coverImage,
    this.bio,
    required this.emailAddress,
    required this.password,
    this.dialingCode,
    this.phoneNumber,
    this.birthDate,
    this.countryId,
    this.gender,
    required this.permissions,
    required this.isSuper,
  });
}