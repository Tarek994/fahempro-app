import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/review_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetReviewWithIdUseCase extends BaseUseCase<ReviewModel, GetReviewWithIdParameters> {
  final BaseRepository _baseRepository;

  GetReviewWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ReviewModel>> call(GetReviewWithIdParameters parameters) async {
    return await _baseRepository.getReviewWithId(parameters);
  }
}

class GetReviewWithIdParameters {
  int reviewId;

  GetReviewWithIdParameters({
    required this.reviewId,
  });
}