import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/review_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertReviewUseCase extends BaseUseCase<ReviewModel, InsertReviewParameters> {
  final BaseRepository _baseRepository;

  InsertReviewUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ReviewModel>> call(InsertReviewParameters parameters) async {
    return await _baseRepository.insertReview(parameters);
  }
}

class InsertReviewParameters {
  int accountId;
  int userId;
  String comment;
  double rating;
  List<String> featuresAr;
  List<String> featuresEn;
  String createdAt;

  InsertReviewParameters({
    required this.accountId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.featuresAr,
    required this.featuresEn,
    required this.createdAt,
  });
}