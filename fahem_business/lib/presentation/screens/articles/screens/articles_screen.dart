import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/articles/controllers/articles_provider.dart';
import 'package:fahem_business/presentation/screens/articles/widgets/article_grid_item.dart';
import 'package:fahem_business/presentation/screens/articles/widgets/article_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late ArticlesProvider articlesProvider;

  @override
  void initState() {
    super.initState();
    articlesProvider = Provider.of<ArticlesProvider>(context, listen: false);
    articlesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await articlesProvider.fetchData());
  }

  void _onInsert(ArticleModel? article) {
    if(article != null) {
      articlesProvider.insertInArticles(article);
      if(articlesProvider.paginationModel != null) articlesProvider.paginationModel!.total++;
    }
  }

  void _onEdit(ArticleModel? article) {
    if(article != null) {
      articlesProvider.editInArticles(article);
    }
  }

  void _onDelete(int articleId) {
    articlesProvider.deleteArticle(context: context, articleId: articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addArticle) ? () {
            Methods.routeTo(context, Routes.insertEditArticleScreen, arguments: null, then: (article) => _onInsert(article));
          } : null,
          screenTitle: StringsManager.articles,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByTitle,
            ordersItems: const [OrderByType.articlesNewestFirst, OrderByType.articlesOldestFirst, OrderByType.highestViews, OrderByType.lowestViews],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.isAvailable],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.articles.isNotEmpty,
          dataCount: provider.articles.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ArticleListItem(articleModel: provider.articles[index], onEdit: (article) => _onEdit(article), onDelete: () => _onDelete(provider.articles[index].articleId)),
          gridItemBuilder: (context, index) => ArticleGridItem(articleModel: provider.articles[index], onEdit: (article) => _onEdit(article), onDelete: () => _onDelete(provider.articles[index].articleId)),
          itemHeightInGrid: SizeManager.s230,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoArticles,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    articlesProvider.setIsScreenDisposed(true);
    articlesProvider.scrollController.dispose();
  }
}