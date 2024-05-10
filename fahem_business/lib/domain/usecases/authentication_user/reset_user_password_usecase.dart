import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class ResetUserPasswordUseCase extends BaseUseCase<UserModel, ResetUserPasswordParameters> {
  final BaseRepository _baseRepository;

  ResetUserPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(ResetUserPasswordParameters parameters) async {
    return await _baseRepository.resetUserPassword(parameters);
  }
}

class ResetUserPasswordParameters {
  String emailAddress;
  String password;

  ResetUserPasswordParameters({
    required this.emailAddress,
    required this.password,
  });
}