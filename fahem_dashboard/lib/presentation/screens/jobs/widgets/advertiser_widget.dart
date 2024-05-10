import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';

class AdvertiserWidget extends StatelessWidget {
  final JobModel jobModel;

  const AdvertiserWidget({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s16),
      margin: const EdgeInsets.only(bottom: SizeManager.s10),
      width: double.infinity,
      color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Methods.getText(StringsManager.advertiser).toTitleCase(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomButton(
                onPressed: () {
                  Methods.routeTo(context, Routes.accountProfileScreen, arguments: jobModel.account);
                },
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.advertiserPage).toTitleCase(),
                width: SizeManager.s100,
                height: SizeManager.s30,
                borderRadius: SizeManager.s5,
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              ImageWidget(
                image: jobModel.account.personalImage,
                imageDirectory: ApiConstants.accountsDirectory,
                defaultImage: ImagesManager.defaultAvatar,
                width: SizeManager.s50,
                height: SizeManager.s50,
                boxShape: BoxShape.circle,
                isShowFullImageScreen: false,
              ),
              const SizedBox(width: SizeManager.s10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameWidget(
                    fullName: jobModel.account.fullName,
                    isFeatured: jobModel.account.isFeatured,
                    isSupportFeatured: true,
                    isOverflow: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: SizeManager.s5),
                  Text(
                    jobModel.account.jobTitle ?? '',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
