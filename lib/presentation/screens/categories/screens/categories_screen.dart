import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem/presentation/screens/categories/widgets/categories5_grid.dart';
import 'package:fahem/presentation/screens/categories/widgets/categories6_grid.dart';
import 'package:fahem/presentation/screens/home/widgets/main_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/accounts/widgets/account_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

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
    categoriesProvider.accountsAddListenerScrollController();
    categoriesProvider.categoriesAddListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        categoriesProvider.fetchAccounts(),
        categoriesProvider.fetchCategories(),
      ]);
    });
  }

  String _getTitle() {
    if(categoriesProvider.mainCategory.mainCategoryId == 1) {
      return Methods.getText(StringsManager.fahemLawyers).toTitleCase();
    }
    if(categoriesProvider.mainCategory.mainCategoryId == 2) {
      return Methods.getText(StringsManager.publicRelationsFromFahem).toTitleCase();
    }
    return MyProviders.appProvider.isEnglish ? categoriesProvider.mainCategory.nameEn : categoriesProvider.mainCategory.nameAr;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async {
            await Future.wait([
              categoriesProvider.reFetchAccounts(),
              categoriesProvider.reFetchCategories(),
            ]);
          },
          scrollController: provider.accountsScrollController,
          goToInsertScreen: null,
          appBarColor: Colors.transparent,
          pinned: false,
          customTitle: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Methods.getText(StringsManager.atYourService).toCapitalized(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeightManager.black),
                ),
                Text(
                  _getTitle(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.black),
                ),
              ],
            ),
          ),
          scaffoldColor: ColorsManager.white,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          totalResults: null,
          // totalResults: provider.accountsPaginationModel == null ? 0 : provider.accountsPaginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.accountsViewStyle,
          changeViewStyleToList: () => provider.changeAccountsViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeAccountsViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => AccountListItem(
            accountModel: provider.accounts[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.accountsDataState,
          hasMore: provider.accountsHasMore,
          noDataMsgInScreen: StringsManager.thereAreNoAccounts,
          isSupportEmptyScreen: provider.categories.isEmpty && provider.accounts.isEmpty,
          isShowBackground: true,
          extraWidget: Padding(
            padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s16),
            child: Column(
              children: [
                if (provider.mainCategory.mainCategoryId == 1 && categoriesProvider.categories.isNotEmpty) const Categories6Grid(),
                if (provider.mainCategory.mainCategoryId == 2 && categoriesProvider.categories.isNotEmpty) const Categories5Grid(),
                if(categoriesProvider.accounts.isNotEmpty) ...[
                  const SizedBox(height: SizeManager.s16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    child: MainTitle(
                      title: StringsManager.highestRating,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.black),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // extraWidget: CategoriesExtraWidget(mainCategory: provider.mainCategory),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    categoriesProvider.setIsScreenDisposed(true);
    categoriesProvider.accountsScrollController.dispose();
    categoriesProvider.categoriesScrollController.dispose();
  }
}