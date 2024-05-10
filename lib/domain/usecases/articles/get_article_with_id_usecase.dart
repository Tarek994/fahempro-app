import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/article_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetArticleWithIdUseCase extends BaseUseCase<ArticleModel, GetArticleWithIdParameters> {
  final BaseRepository _baseRepository;

  GetArticleWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ArticleModel>> call(GetArticleWithIdParameters parameters) async {
    return await _baseRepository.getArticleWithId(parameters);
  }
}

class GetArticleWithIdParameters {
  int articleId;

  GetArticleWithIdParameters({
    required this.articleId,
  });
}