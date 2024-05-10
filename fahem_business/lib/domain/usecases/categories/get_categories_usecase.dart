import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/categories_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetCategoriesUseCase extends BaseUseCase<CategoriesResponse, GetCategoriesParameters> {
  final BaseRepository _baseRepository;

  GetCategoriesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, CategoriesResponse>> call(GetCategoriesParameters parameters) async {
    return await _baseRepository.getCategories(parameters);
  }
}

class GetCategoriesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetCategoriesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}