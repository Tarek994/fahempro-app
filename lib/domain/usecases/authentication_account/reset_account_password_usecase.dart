import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class ResetAccountPasswordUseCase extends BaseUseCase<AccountModel, ResetAccountPasswordParameters> {
  final BaseRepository _baseRepository;

  ResetAccountPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AccountModel>> call(ResetAccountPasswordParameters parameters) async {
    return await _baseRepository.resetAccountPassword(parameters);
  }
}

class ResetAccountPasswordParameters {
  String emailAddress;
  String password;

  ResetAccountPasswordParameters({
    required this.emailAddress,
    required this.password,
  });
}