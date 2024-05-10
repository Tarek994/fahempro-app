import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/presentation/screens/jobs/widgets/advertiser_widget.dart';
import 'package:fahem/presentation/screens/jobs/widgets/details_widget.dart';
import 'package:fahem/presentation/screens/jobs/widgets/share_job_widget.dart';
import 'package:fahem/presentation/screens/jobs/widgets/top_in_job_details.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel jobModel;

  const JobDetailsScreen({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFullLoading(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorsManager.grey1,
          body: CustomFullLoading(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: TopInJobDetails(jobModel: jobModel)),
                SliverToBoxAdapter(child: DetailsWidget(jobModel: jobModel)),
                SliverToBoxAdapter(child: ShareJobWidget(jobModel: jobModel)),
                SliverToBoxAdapter(child: AdvertiserWidget(jobModel: jobModel)),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                onPressed: () => Methods.routeTo(context, Routes.jobApplyScreen, arguments: jobModel),
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.apply2).toCapitalized(),
                buttonColor: ColorsManager.lightSecondaryColor,
                width: double.infinity,
                borderRadius: SizeManager.s0,
                textFontWeight: FontWeightManager.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}