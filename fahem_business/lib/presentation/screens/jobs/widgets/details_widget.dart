import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DetailsWidget extends StatelessWidget {
  final JobModel jobModel;

  const DetailsWidget({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SizeManager.s16),
          margin: const EdgeInsets.only(bottom: SizeManager.s10),
          width: double.infinity,
          color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkSecondaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Methods.getText(StringsManager.jobDetails).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
              ),
              const SizedBox(height: SizeManager.s5),
              Directionality(
                textDirection: Methods.getDirectionFromText(jobModel.details),
                child: SizedBox(
                  width: double.infinity,
                  child: ReadMoreText(
                    jobModel.details,
                    trimMode: TrimMode.Line,
                    trimLines: 20,
                    trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
                    trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s2),
                    moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                    lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(SizeManager.s16),
          margin: const EdgeInsets.only(bottom: SizeManager.s10),
          width: double.infinity,
          color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkSecondaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Methods.getText(StringsManager.aboutCompany).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
              ),
              const SizedBox(height: SizeManager.s5),
              Directionality(
                textDirection: Methods.getDirectionFromText(jobModel.aboutCompany),
                child: SizedBox(
                  width: double.infinity,
                  child: ReadMoreText(
                    jobModel.aboutCompany,
                    trimMode: TrimMode.Line,
                    trimLines: 20,
                    trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
                    trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s2),
                    moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                    lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
