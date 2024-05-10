import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class IsUserEmailExistUseCase extends BaseUseCase<bool, IsUserEmailExistParameters> {
  final BaseRepository _baseRepository;

  IsUserEmailExistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(IsUserEmailExistParameters parameters) async {
    return await _baseRepository.isUserEmailExist(parameters);
  }
}

class IsUserEmailExistParameters {
  String emailAddress;

  IsUserEmailExistParameters({
    required this.emailAddress,
  });
}