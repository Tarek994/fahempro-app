import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/article_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditArticleUseCase extends BaseUseCase<ArticleModel, EditArticleParameters> {
  final BaseRepository _baseRepository;

  EditArticleUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ArticleModel>> call(EditArticleParameters parameters) async {
    return await _baseRepository.editArticle(parameters);
  }
}

class EditArticleParameters {
  int articleId;
  String image;
  String titleAr;
  String titleEn;
  String articleAr;
  String articleEn;
  int customOrder;
  bool isAvailable;

  EditArticleParameters({
    required this.articleId,
    required this.image,
    required this.titleAr,
    required this.titleEn,
    required this.articleAr,
    required this.articleEn,
    required this.customOrder,
    required this.isAvailable,
  });
}