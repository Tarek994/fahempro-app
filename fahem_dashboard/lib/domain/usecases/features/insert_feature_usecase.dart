import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/feature_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertFeatureUseCase extends BaseUseCase<FeatureModel, InsertFeatureParameters> {
  final BaseRepository _baseRepository;

  InsertFeatureUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FeatureModel>> call(InsertFeatureParameters parameters) async {
    return await _baseRepository.insertFeature(parameters);
  }
}

class InsertFeatureParameters {
  int mainCategoryId;
  String featureAr;
  String featureEn;
  String createdAt;

  InsertFeatureParameters({
    required this.mainCategoryId,
    required this.featureAr,
    required this.featureEn,
    required this.createdAt,
  });
}