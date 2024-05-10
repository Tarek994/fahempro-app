import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem/presentation/screens/home/widgets/main_title.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/my_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesExtraWidget extends StatelessWidget {
  final MainCategoryModel mainCategory;

  const CategoriesExtraWidget({
    super.key,
    required this.mainCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      width: double.infinity,
      child: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, _) {
          return ConditionalBuilder(
            condition: categoriesProvider.categories.isNotEmpty,
            builder: (_) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5),
                    child: CustomGrid(
                      listLength: categoriesProvider.categories.length,
                      numberOfItemsInRow: 2,
                      horizontalMargin: SizeManager.s5,
                      verticalMargin: SizeManager.s5,
                      child: (index) {
                        return InkWell(
                          onTap: () {
                            Methods.routeTo(
                              context,
                              Routes.accountsScreen,
                              arguments: AccountsArgs(
                                mainCategory: mainCategory,
                                category: categoriesProvider.categories[index],
                              ),
                            );
                          },
                          child: _CategoryItem(
                            categoryModel: categoriesProvider.categories[index],
                            color: index % 3 == 0 ? ColorsManager.lightPrimaryColor : index % 2 == 1 ? ColorsManager.lightSecondaryColor : ColorsManager.lightSecondaryColor,
                            imageLine: index % 3 == 0 ? ImagesManager.lines1 : index % 2 == 1 ? ImagesManager.lines2 : ImagesManager.lines3,
                          ),
                        );
                      },
                    ),
                  ),
                  if(categoriesProvider.accounts.isNotEmpty) ...[
                    const SizedBox(height: SizeManager.s10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeManager.s16),
                      child: MainTitle(
                        title: StringsManager.highestRating,
                      ),
                    ),
                  ],
                ],
              );
            },
            fallback: (_) {
              if(categoriesProvider.categoriesDataState == DataState.loading) {
                return const Padding(
                  padding: EdgeInsets.all(SizeManager.s10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeManager.s25,
                        height: SizeManager.s25,
                        child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
                      ),
                    ],
                  ),
                );
              }
              if(categoriesProvider.categoriesDataState == DataState.empty) {
                return const SizedBox();
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeManager.s10),
                    child: Text(
                      Methods.getText(StringsManager.thereAreNoCategories).toCapitalized(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }
              if(categoriesProvider.categoriesDataState == DataState.error) {
                return const SizedBox();
                return MyErrorWidget(onPressed: () => categoriesProvider.reFetchCategories());
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final String imageLine;
  final Color color;

  const _CategoryItem({
    required this.categoryModel,
    required this.imageLine,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      height: SizeManager.s150,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Stack(
        children: [
          ImageWidget(
            image: categoryModel.image,
            imageDirectory: ApiConstants.categoriesDirectory,
            width: double.infinity,
            height: SizeManager.s150,
            fit: BoxFit.fill,
            borderRadius: SizeManager.s10,
            isShowFullImageScreen: false,
          ),
          Container(
            width: double.infinity,
            height: SizeManager.s150,
            color: ColorsManager.black.withOpacity(0.8),
          ),
          Image.asset(
            imageLine,
            width: double.infinity,
            height: SizeManager.s150,
            fit: BoxFit.fill,
            color: color,
          ),
          Center(
            child: Text(
              MyProviders.appProvider.isEnglish ? categoryModel.nameEn : categoryModel.nameAr,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: ColorsManager.white,
                fontWeight: FontWeightManager.black,
                fontSize: SizeManager.s18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}