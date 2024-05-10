import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class IsAccountEmailExistUseCase extends BaseUseCase<bool, IsAccountEmailExistParameters> {
  final BaseRepository _baseRepository;

  IsAccountEmailExistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(IsAccountEmailExistParameters parameters) async {
    return await _baseRepository.isAccountEmailExist(parameters);
  }
}

class IsAccountEmailExistParameters {
  String emailAddress;

  IsAccountEmailExistParameters({
    required this.emailAddress,
  });
}