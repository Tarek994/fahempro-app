import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteFeatureUseCase extends BaseUseCase<void, DeleteFeatureParameters> {
  final BaseRepository _baseRepository;

  DeleteFeatureUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteFeatureParameters parameters) async {
    return await _baseRepository.deleteFeature(parameters);
  }
}

class DeleteFeatureParameters {
  int featureId;

  DeleteFeatureParameters({
    required this.featureId,
  });
}