import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/features_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetFeaturesUseCase extends BaseUseCase<FeaturesResponse, GetFeaturesParameters> {
  final BaseRepository _baseRepository;

  GetFeaturesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, FeaturesResponse>> call(GetFeaturesParameters parameters) async {
    return await _baseRepository.getFeatures(parameters);
  }
}

class GetFeaturesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetFeaturesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}