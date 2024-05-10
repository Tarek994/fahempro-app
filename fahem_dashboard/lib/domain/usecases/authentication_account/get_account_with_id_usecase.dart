import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetAccountWithIdUseCase extends BaseUseCase<AccountModel, GetAccountWithIdParameters> {
  final BaseRepository _baseRepository;

  GetAccountWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AccountModel>> call(GetAccountWithIdParameters parameters) async {
    return await _baseRepository.getAccountWithId(parameters);
  }
}

class GetAccountWithIdParameters {
  int accountId;

  GetAccountWithIdParameters({
    required this.accountId,
  });
}