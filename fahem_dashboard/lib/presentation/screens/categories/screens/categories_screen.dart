import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem_dashboard/presentation/screens/categories/widgets/category_grid_item.dart';
import 'package:fahem_dashboard/presentation/screens/categories/widgets/category_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesProvider categoriesProvider;
  
  @override
  void initState() {
    super.initState();
    categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await categoriesProvider.fetchData());
  }

  void _onInsert(CategoryModel? category) {
    if(category != null) {
      categoriesProvider.insertInCategories(category);
      if(categoriesProvider.paginationModel != null) categoriesProvider.paginationModel!.total++;
    }
  }

  void _onEdit(CategoryModel? category) {
    if(category != null) {
      categoriesProvider.editInCategories(category);
    }
  }

  void _onDelete(int categoryId) {
    categoriesProvider.deleteCategory(context: context, categoryId: categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addCategory) ? () {
            Methods.routeTo(context, Routes.insertEditCategoryScreen, arguments: null, then: (category) => _onInsert(category));
          } : null,
          screenTitle: StringsManager.categories,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.categoriesNewestFirst, OrderByType.categoriesOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.mainCategory],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.categories.isNotEmpty,
          dataCount: provider.categories.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => CategoryListItem(categoryModel: provider.categories[index], onEdit: (category) => _onEdit(category), onDelete: () => _onDelete(provider.categories[index].categoryId)),
          gridItemBuilder: (context, index) => CategoryGridItem(categoryModel: provider.categories[index], onEdit: (category) => _onEdit(category), onDelete: () => _onDelete(provider.categories[index].categoryId)),
          itemHeightInGrid: SizeManager.s100,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoCategories,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    categoriesProvider.setIsScreenDisposed(true);
    categoriesProvider.scrollController.dispose();
  }
}