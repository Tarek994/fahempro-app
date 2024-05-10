import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';

class JobGridItem extends StatelessWidget {
  final JobModel jobModel;
  final int index;

  const JobGridItem({
    super.key,
    required this.jobModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      color: index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
      onTap: () async {
        FocusScope.of(context).unfocus();
        await Methods.routeTo(
          context,
          Routes.jobDetailsScreen,
          arguments: jobModel,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageWidget(
                image: jobModel.image,
                imageDirectory: ApiConstants.jobsDirectory,
                width: SizeManager.s70,
                height: SizeManager.s70,
                borderRadius: SizeManager.s10,
                isShowFullImageScreen: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobModel.companyName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorsManager.white,
                          fontWeight: FontWeightManager.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        jobModel.jobLocation,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Text(
            jobModel.jobTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeightManager.black,
              color: ColorsManager.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: SizeManager.s5),
          Text(
            '${jobModel.minSalary} - ${jobModel.maxSalary} ${Methods.getText(StringsManager.egp).toUpperCase()}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorsManager.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: SizeManager.s5,
                  runSpacing: SizeManager.s10,
                  children: List.generate(jobModel.features.length, (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(SizeManager.s10),
                      ),
                      child: Text(
                        jobModel.features[index],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeightManager.black,
                          fontSize: SizeManager.s10,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Text(
                Methods.convertToTimeAgo(DateTime.fromMillisecondsSinceEpoch(int.parse(jobModel.createdAt))),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorsManager.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}