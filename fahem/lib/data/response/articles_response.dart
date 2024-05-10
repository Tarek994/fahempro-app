import 'package:fahem/data/models/article_model.dart';
import 'package:fahem/data/models/static/base_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';

class ArticlesResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<ArticleModel> articles;

  ArticlesResponse({
    required this.base,
    required this.pagination,
    required this.articles,
  });

  ArticlesResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    articles = List.from(json['articles']).map((e) => ArticleModel.fromJson(e)).toList();
  }
}