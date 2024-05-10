import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteAccountUseCase extends BaseUseCase<void, DeleteAccountParameters> {
  final BaseRepository _baseRepository;

  DeleteAccountUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteAccountParameters parameters) async {
    return await _baseRepository.deleteAccount(parameters);
  }
}

class DeleteAccountParameters {
  int accountId;

  DeleteAccountParameters({
    required this.accountId,
  });
}