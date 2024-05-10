import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/articles_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetArticlesUseCase extends BaseUseCase<ArticlesResponse, GetArticlesParameters> {
  final BaseRepository _baseRepository;

  GetArticlesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ArticlesResponse>> call(GetArticlesParameters parameters) async {
    return await _baseRepository.getArticles(parameters);
  }
}

class GetArticlesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetArticlesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}