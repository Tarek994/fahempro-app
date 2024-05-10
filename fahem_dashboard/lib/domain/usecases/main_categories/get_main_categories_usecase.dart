import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/main_categories_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetMainCategoriesUseCase extends BaseUseCase<MainCategoriesResponse, GetMainCategoriesParameters> {
  final BaseRepository _baseRepository;

  GetMainCategoriesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, MainCategoriesResponse>> call(GetMainCategoriesParameters parameters) async {
    return await _baseRepository.getMainCategories(parameters);
  }
}

class GetMainCategoriesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetMainCategoriesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}