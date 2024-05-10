import 'package:flutter/material.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/my_back_button.dart';

class TopInJobDetails extends StatelessWidget {
  final JobModel jobModel;
  
  const TopInJobDetails({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkSecondaryColor,
      child: Container(
        decoration: BoxDecoration(
          color: MyProviders.appProvider.isLight ? ColorsManager.grey1 : ColorsManager.darkPrimaryColor,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(SizeManager.s30), bottomRight: Radius.circular(SizeManager.s30)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizeManager.s30), bottomRight: Radius.circular(SizeManager.s30)),
                  ),
                  child: ImageWidget(
                    image: jobModel.image,
                    imageDirectory: ApiConstants.jobsDirectory,
                    width: double.infinity,
                    height: SizeManager.s250,
                    isShowFullImageScreen: true,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeManager.s16),
                  child: MyBackButton(),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(SizeManager.s20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobModel.jobTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s20),
                  Wrap(
                    spacing: SizeManager.s5,
                    runSpacing: SizeManager.s10,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                        decoration: BoxDecoration(
                          color: MyProviders.appProvider.isLight ? ColorsManager.grey2 : ColorsManager.darkSecondaryColor,
                          borderRadius: BorderRadius.circular(SizeManager.s10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(IconsManager.coins, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
                            const SizedBox(width: SizeManager.s10),
                            Flexible(
                              child: Text(
                                '${jobModel.minSalary} - ${jobModel.maxSalary} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                        decoration: BoxDecoration(
                          color: MyProviders.appProvider.isLight ? ColorsManager.grey2 : ColorsManager.darkSecondaryColor,
                          borderRadius: BorderRadius.circular(SizeManager.s10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(IconsManager.location, color: ColorsManager.lightPrimaryColor, width: SizeManager.s18, height: SizeManager.s18),
                            const SizedBox(width: SizeManager.s10),
                            Flexible(
                              child: Text(
                                jobModel.jobLocation,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                        decoration: BoxDecoration(
                          color: MyProviders.appProvider.isLight ? ColorsManager.grey2 : ColorsManager.darkSecondaryColor,
                          borderRadius: BorderRadius.circular(SizeManager.s10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(IconsManager.view, color: ColorsManager.lightPrimaryColor, width: SizeManager.s18, height: SizeManager.s18),
                            const SizedBox(width: SizeManager.s10),
                            Flexible(
                              child: Text(
                                jobModel.views.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: SizeManager.s20),
                  Wrap(
                    spacing: SizeManager.s5,
                    runSpacing: SizeManager.s10,
                    children: List.generate(jobModel.features.length, (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.circular(SizeManager.s5),
                        ),
                        child: Text(
                          jobModel.features[index],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}