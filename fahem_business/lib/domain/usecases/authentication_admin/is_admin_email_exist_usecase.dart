import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class IsAdminEmailExistUseCase extends BaseUseCase<bool, IsAdminEmailExistParameters> {
  final BaseRepository _baseRepository;

  IsAdminEmailExistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(IsAdminEmailExistParameters parameters) async {
    return await _baseRepository.isAdminEmailExist(parameters);
  }
}

class IsAdminEmailExistParameters {
  String emailAddress;

  IsAdminEmailExistParameters({
    required this.emailAddress,
  });
}