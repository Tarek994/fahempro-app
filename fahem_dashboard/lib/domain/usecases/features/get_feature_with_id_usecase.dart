import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/feature_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetFeatureWithIdUseCase extends BaseUseCase<FeatureModel, GetFeatureWithIdParameters> {
  final BaseRepository _baseRepository;

  GetFeatureWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FeatureModel>> call(GetFeatureWithIdParameters parameters) async {
    return await _baseRepository.getFeatureWithId(parameters);
  }
}

class GetFeatureWithIdParameters {
  int featureId;

  GetFeatureWithIdParameters({
    required this.featureId,
  });
}