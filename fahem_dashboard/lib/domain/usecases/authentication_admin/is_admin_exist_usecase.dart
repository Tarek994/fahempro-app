import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class IsAdminExistUseCase extends BaseUseCase<bool, IsAdminExistParameters> {
  final BaseRepository _baseRepository;

  IsAdminExistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(IsAdminExistParameters parameters) async {
    return await _baseRepository.isAdminExist(parameters);
  }
}

class IsAdminExistParameters {
  int adminId;

  IsAdminExistParameters({
    required this.adminId,
  });
}