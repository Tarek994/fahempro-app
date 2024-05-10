import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteAccountAccountUseCase extends BaseUseCase<void, DeleteAccountAccountParameters> {
  final BaseRepository _baseRepository;

  DeleteAccountAccountUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteAccountAccountParameters parameters) async {
    return await _baseRepository.deleteAccountAccount(parameters);
  }
}

class DeleteAccountAccountParameters {
  int accountId;

  DeleteAccountAccountParameters({
    required this.accountId,
  });
}