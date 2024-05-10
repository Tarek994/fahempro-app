import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class ChangeAdminPasswordUseCase extends BaseUseCase<AdminModel, ChangeAdminPasswordParameters> {
  final BaseRepository _baseRepository;

  ChangeAdminPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(ChangeAdminPasswordParameters parameters) async {
    return await _baseRepository.changeAdminPassword(parameters);
  }
}

class ChangeAdminPasswordParameters {
  int adminId;
  String oldPassword;
  String newPassword;

  ChangeAdminPasswordParameters({
    required this.adminId,
    required this.oldPassword,
    required this.newPassword,
  });
}