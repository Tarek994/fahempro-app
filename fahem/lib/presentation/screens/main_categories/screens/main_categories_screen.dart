import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/main_categories/controllers/main_categories_provider.dart';
import 'package:fahem/presentation/screens/main_categories/widgets/main_category_grid_item.dart';
import 'package:fahem/presentation/screens/main_categories/widgets/main_category_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class MainCategoriesScreen extends StatefulWidget {
  const MainCategoriesScreen({super.key});

  @override
  State<MainCategoriesScreen> createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  late MainCategoriesProvider mainCategoriesProvider;
  
  @override
  void initState() {
    super.initState();
    mainCategoriesProvider = Provider.of<MainCategoriesProvider>(context, listen: false);
    mainCategoriesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await mainCategoriesProvider.fetchData());
  }

  void _onInsert(MainCategoryModel? mainCategory) {
    if(mainCategory != null) {
      mainCategoriesProvider.insertInMainCategories(mainCategory);
      if(mainCategoriesProvider.paginationModel != null) mainCategoriesProvider.paginationModel!.total++;
    }
  }

  void _onEdit(MainCategoryModel? mainCategory) {
    if(mainCategory != null) {
      mainCategoriesProvider.editInMainCategories(mainCategory);
    }
  }

  void _onDelete(int mainCategoryId) {
    mainCategoriesProvider.deleteMainCategory(context: context, mainCategoryId: mainCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainCategoriesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addMainCategory) ? () {
            Methods.routeTo(context, Routes.insertEditMainCategoryScreen, arguments: null, then: (mainCategory) => _onInsert(mainCategory));
          } : null,
          screenTitle: StringsManager.mainCategories,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.mainCategoriesNewestFirst, OrderByType.mainCategoriesOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.mainCategories.isNotEmpty,
          dataCount: provider.mainCategories.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => MainCategoryListItem(mainCategoryModel: provider.mainCategories[index], onEdit: (mainCategory) => _onEdit(mainCategory), onDelete: () => _onDelete(provider.mainCategories[index].mainCategoryId)),
          gridItemBuilder: (context, index) => MainCategoryGridItem(mainCategoryModel: provider.mainCategories[index], onEdit: (mainCategory) => _onEdit(mainCategory), onDelete: () => _onDelete(provider.mainCategories[index].mainCategoryId)),
          itemHeightInGrid: SizeManager.s100,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoMainCategories,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    mainCategoriesProvider.setIsScreenDisposed(true);
    mainCategoriesProvider.scrollController.dispose();
  }
}