import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/home/controllers/home_provider.dart';
import 'package:fahem/presentation/screens/home/widgets/main_title.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/my_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesWidget extends StatelessWidget {

  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          return ConditionalBuilder(
            condition: homeProvider.services.isNotEmpty,
            builder: (_) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    child: MainTitle(
                      onPressed: () {
                        Methods.routeTo(context, Routes.servicesScreen);
                      },
                      title: StringsManager.fahemServices,
                    ),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  SizedBox(
                    height: SizeManager.s100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                      itemBuilder: (context, index) => SizedBox(
                        width: SizeManager.s225,
                        child: InkWell(
                          onTap: () {
                            Methods.routeTo(
                              context,
                              Routes.serviceDetailsScreen,
                              arguments: ServiceDetailsArgs(
                                service: homeProvider.services[index],
                                color: index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
                                  borderRadius: BorderRadius.circular(SizeManager.s10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(SizeManager.s10),
                                        child: Center(
                                          child: Text(
                                            MyProviders.appProvider.isEnglish ? homeProvider.services[index].nameEn : homeProvider.services[index].nameAr,
                                            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ImageWidget(
                                      image: homeProvider.services[index].serviceImage,
                                      imageDirectory: ApiConstants.servicesDirectory,
                                      width: SizeManager.s100,
                                      height: SizeManager.s100,
                                      isShowFullImageScreen: false,
                                    ),
                                  ],
                                ),
                              ),
                              // Image.asset(
                              //   ImagesManager.lines3,
                              //   fit: BoxFit.fill,
                              //   width: double.infinity,
                              //   height: double.infinity,
                              //   color: index % 2 != 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                      itemCount: homeProvider.services.length,
                    ),
                  ),
                ],
              );
            },
            fallback: (_) {
              if(homeProvider.servicesDataState == DataState.loading) {
                return _Loading();
              }
              if(homeProvider.servicesDataState == DataState.empty) {
                return _Empty();
              }
              if(homeProvider.servicesDataState == DataState.error) {
                return MyErrorWidget(onPressed: () => homeProvider.reFetchServices());
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
    //       Methods.getText(StringsManager.thereAreNoServices).toCapitalized(),
    //       style: Theme.of(context).textTheme.bodySmall,
    //     ),
    //   ),
    // );
  }
}