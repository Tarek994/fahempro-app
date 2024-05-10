import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class IsAccountExistUseCase extends BaseUseCase<bool, IsAccountExistParameters> {
  final BaseRepository _baseRepository;

  IsAccountExistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(IsAccountExistParameters parameters) async {
    return await _baseRepository.isAccountExist(parameters);
  }
}

class IsAccountExistParameters {
  int accountId;

  IsAccountExistParameters({
    required this.accountId,
  });
}