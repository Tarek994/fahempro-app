import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteReviewUseCase extends BaseUseCase<void, DeleteReviewParameters> {
  final BaseRepository _baseRepository;

  DeleteReviewUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteReviewParameters parameters) async {
    return await _baseRepository.deleteReview(parameters);
  }
}

class DeleteReviewParameters {
  int reviewId;

  DeleteReviewParameters({
    required this.reviewId,
  });
}