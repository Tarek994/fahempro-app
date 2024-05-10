import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/feature_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditFeatureUseCase extends BaseUseCase<FeatureModel, EditFeatureParameters> {
  final BaseRepository _baseRepository;

  EditFeatureUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FeatureModel>> call(EditFeatureParameters parameters) async {
    return await _baseRepository.editFeature(parameters);
  }
}

class EditFeatureParameters {
  int featureId;
  int mainCategoryId;
  String featureAr;
  String featureEn;

  EditFeatureParameters({
    required this.featureId,
    required this.mainCategoryId,
    required this.featureAr,
    required this.featureEn,
  });
}