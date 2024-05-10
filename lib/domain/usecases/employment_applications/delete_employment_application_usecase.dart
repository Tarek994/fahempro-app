import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteEmploymentApplicationUseCase extends BaseUseCase<void, DeleteEmploymentApplicationParameters> {
  final BaseRepository _baseRepository;

  DeleteEmploymentApplicationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteEmploymentApplicationParameters parameters) async {
    return await _baseRepository.deleteEmploymentApplication(parameters);
  }
}

class DeleteEmploymentApplicationParameters {
  int employmentApplicationId;

  DeleteEmploymentApplicationParameters({
    required this.employmentApplicationId,
  });
}