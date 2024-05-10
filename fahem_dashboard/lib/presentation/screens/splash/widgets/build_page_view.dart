import 'package:fahem_dashboard/presentation/screens/splash/controllers/on_boarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/data/data_source/static/on_boarding_data.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';

class BuildPageView extends StatefulWidget {

  const BuildPageView({super.key});

  @override
  State<BuildPageView> createState() => _BuildPageViewState();
}

class _BuildPageViewState extends State<BuildPageView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingProvider>(
      builder: (context, provider, _) {
        return PageView.builder(
          controller: provider.pageController,
          onPageChanged: (index) => provider.onPageChanged(index),
          itemCount: onBoardingData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Expanded(
                    child: onBoardingData[index].image.split('.').last == 'svg' ? SvgPicture.asset(
                      onBoardingData[index].image,
                      width: SizeManager.s400,
                      height: SizeManager.s400,
                    ) : Image.asset(
                      onBoardingData[index].image,
                      width: SizeManager.s400,
                      height: SizeManager.s400,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: SizeManager.s20),
                      FittedBox(
                        child: Text(
                          MyProviders.appProvider.isEnglish ? onBoardingData[index].titleEn.toTitleCase() : onBoardingData[index].titleAr,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.bold),
                        ),
                      ),
                      const SizedBox(height: SizeManager.s20),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          MyProviders.appProvider.isEnglish ? onBoardingData[index].bodyEn.toCapitalized() : onBoardingData[index].bodyAr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(height: SizeManager.s2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}