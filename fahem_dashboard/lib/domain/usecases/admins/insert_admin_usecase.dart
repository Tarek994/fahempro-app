import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertAdminUseCase extends BaseUseCase<AdminModel, InsertAdminParameters> {
  final BaseRepository _baseRepository;

  InsertAdminUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(InsertAdminParameters parameters) async {
    return await _baseRepository.insertAdmin(parameters);
  }
}

class InsertAdminParameters {
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
  String createdAt;

  InsertAdminParameters({
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
    required this.createdAt,
  });
}