import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/home/controllers/home_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/my_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoriesWidget extends StatelessWidget {

  const MainCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          return ConditionalBuilder(
            condition: homeProvider.mainCategories.isNotEmpty,
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                child: CustomGrid(
                  listLength: homeProvider.mainCategories.length,
                  numberOfItemsInRow: 3,
                  horizontalMargin: SizeManager.s5,
                  verticalMargin: SizeManager.s5,
                  child: (index) {
                    return GestureDetector(
                      onTap: () {
                        if(homeProvider.mainCategories[index].numberOfCategories == 0) {
                          Methods.routeTo(
                            context,
                            Routes.accountsScreen,
                            arguments: AccountsArgs(
                              mainCategory: homeProvider.mainCategories[index],
                            ),
                          );

                        }
                        else {
                          Methods.routeTo(
                            context,
                            Routes.categoriesScreen,
                            arguments: homeProvider.mainCategories[index],
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(SizeManager.s10),
                        decoration: BoxDecoration(
                          color: ColorsManager.lightPrimaryColor,
                          borderRadius: BorderRadius.circular(SizeManager.s10),
                        ),
                        child: Column(
                          children: [
                            ImageWidget(
                              image: homeProvider.mainCategories[index].image,
                              imageDirectory: ApiConstants.mainCategoriesDirectory,
                              width: SizeManager.s80,
                              height: SizeManager.s80,
                              fit: BoxFit.fill,
                              isShowFullImageScreen: false,
                            ),
                            SizedBox(
                              height: SizeManager.s40,
                              child: Center(
                                child: Text(
                                  MyProviders.appProvider.isEnglish ? homeProvider.mainCategories[index].nameEn : homeProvider.mainCategories[index].nameAr,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            fallback: (_) {
              if(homeProvider.mainCategoriesDataState == DataState.loading) {
                return _Loading();
              }
              if(homeProvider.mainCategoriesDataState == DataState.empty) {
                return _Empty();
              }
              if(homeProvider.mainCategoriesDataState == DataState.error) {
                return MyErrorWidget(onPressed: () => homeProvider.reFetchMainCategories());
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return const Padding(
    //   padding: EdgeInsets.all(SizeManager.s10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       SizedBox(
    //         width: SizeManager.s25,
    //         height: SizeManager.s25,
    //         child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _Empty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(SizeManager.s10),
    //     child: Text(
    //       Methods.getText(StringsManager.thereAreNoMainCategories).toCapitalized(),
    //       style: Theme.of(context).textTheme.bodySmall,
    //     ),
    //   ),
    // );
  }
}