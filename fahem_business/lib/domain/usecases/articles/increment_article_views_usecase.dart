import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/article_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class IncrementArticleViewsUseCase extends BaseUseCase<ArticleModel, IncrementArticleViewsParameters> {
  final BaseRepository _baseRepository;

  IncrementArticleViewsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ArticleModel>> call(IncrementArticleViewsParameters parameters) async {
    return await _baseRepository.incrementArticleViews(parameters);
  }
}

class IncrementArticleViewsParameters {
  int articleId;

  IncrementArticleViewsParameters({
    required this.articleId,
  });
}