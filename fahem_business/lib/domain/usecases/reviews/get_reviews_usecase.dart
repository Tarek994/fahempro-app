import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/reviews_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetReviewsUseCase extends BaseUseCase<ReviewsResponse, GetReviewsParameters> {
  final BaseRepository _baseRepository;

  GetReviewsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ReviewsResponse>> call(GetReviewsParameters parameters) async {
    return await _baseRepository.getReviews(parameters);
  }
}

class GetReviewsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetReviewsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}