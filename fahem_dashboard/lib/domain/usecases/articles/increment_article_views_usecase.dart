import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/article_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

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