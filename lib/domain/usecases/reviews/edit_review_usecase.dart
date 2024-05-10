import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/review_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditReviewUseCase extends BaseUseCase<ReviewModel, EditReviewParameters> {
  final BaseRepository _baseRepository;

  EditReviewUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ReviewModel>> call(EditReviewParameters parameters) async {
    return await _baseRepository.editReview(parameters);
  }
}

class EditReviewParameters {
  int reviewId;
  int accountId;
  int userId;
  String comment;
  double rating;
  List<String> featuresAr;
  List<String> featuresEn;

  EditReviewParameters({
    required this.reviewId,
    required this.accountId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.featuresAr,
    required this.featuresEn,
  });
}