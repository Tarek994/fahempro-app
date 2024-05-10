import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class ResetAdminPasswordUseCase extends BaseUseCase<AdminModel, ResetAdminPasswordParameters> {
  final BaseRepository _baseRepository;

  ResetAdminPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(ResetAdminPasswordParameters parameters) async {
    return await _baseRepository.resetAdminPassword(parameters);
  }
}

class ResetAdminPasswordParameters {
  String emailAddress;
  String password;

  ResetAdminPasswordParameters({
    required this.emailAddress,
    required this.password,
  });
}