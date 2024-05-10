import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class LoginUserUseCase extends BaseUseCase<UserModel, LoginUserParameters> {
  final BaseRepository _baseRepository;

  LoginUserUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(LoginUserParameters parameters) async {
    return await _baseRepository.loginUser(parameters);
  }
}

class LoginUserParameters {
  String emailAddress;
  String password;

  LoginUserParameters({
    required this.emailAddress,
    required this.password,
  });
}