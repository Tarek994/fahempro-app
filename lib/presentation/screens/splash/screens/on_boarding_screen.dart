import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/splash/controllers/on_boarding_provider.dart';
import 'package:fahem/presentation/screens/splash/controllers/start_provider.dart';
import 'package:fahem/presentation/screens/splash/widgets/build_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/data_source/static/on_boarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingProvider onBoardingProvider;
  late StartProvider startProvider;

  @override
  void initState() {
    super.initState();
    onBoardingProvider = Provider.of<OnBoardingProvider>(context, listen: false);
    startProvider = Provider.of<StartProvider>(context, listen: false);
    onBoardingProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
              child: TextButton(
                onPressed: () async => await onBoardingProvider.skip(context: context, startProvider: startProvider),
                child: Text(
                  Methods.getText(StringsManager.skip).toUpperCase(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(SizeManager.s16),
          child: BuildPageView(),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: SizeManager.s16),
          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s32),
          width: double.infinity,
          height: SizeManager.s100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<OnBoardingProvider, int>(
                selector: (context, provider) => provider.currentPage,
                builder: (context, currentPage, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onBoardingData.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: ConstantsManager.onBoardingPageViewDuration),
                        margin: const EdgeInsets.only(right: SizeManager.s5),
                        width: currentPage == index ? SizeManager.s40 : SizeManager.s20,
                        height: SizeManager.s10,
                        decoration: BoxDecoration(
                          color: MyProviders.appProvider.isLight
                              ? (currentPage == index ? ColorsManager.lightSecondaryColor : ColorsManager.grey)
                              : (currentPage == index ? ColorsManager.white : ColorsManager.grey),
                          borderRadius: BorderRadius.circular(SizeManager.s10),
                        ),
                      );
                    }),
                  );
                },
              ),
              FloatingActionButton(
                onPressed: () async => await onBoardingProvider.next(context: context, startProvider: startProvider),
                backgroundColor: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
                elevation: SizeManager.s0,
                child: Icon(
                  Icons.navigate_next,
                  size: SizeManager.s30,
                  color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.lightSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    onBoardingProvider.setCurrentPage(0);
    super.dispose();
  }
}