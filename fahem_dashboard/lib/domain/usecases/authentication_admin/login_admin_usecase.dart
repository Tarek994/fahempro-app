import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class LoginAdminUseCase extends BaseUseCase<AdminModel, LoginAdminParameters> {
  final BaseRepository _baseRepository;

  LoginAdminUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminModel>> call(LoginAdminParameters parameters) async {
    return await _baseRepository.loginAdmin(parameters);
  }
}

class LoginAdminParameters {
  String emailAddress;
  String password;

  LoginAdminParameters({
    required this.emailAddress,
    required this.password,
  });
}