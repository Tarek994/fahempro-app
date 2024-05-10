import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/jobs/controllers/jobs_provider.dart';

class ExtraWidgetInTopJobs extends StatelessWidget {
  const ExtraWidgetInTopJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Column(
        children: [
          _JobStatus(),
        ],
      ),
    );
  }
}

class _JobStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, jobsProvider, _) {
        return Padding(
          padding: const EdgeInsets.only(top: SizeManager.s16, left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s8),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    jobsProvider.jobStatus = null;
                    await jobsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.all).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: jobsProvider.jobStatus == null ? ColorsManager.lightPrimaryColor : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    jobsProvider.jobStatus = JobStatus.active;
                    await jobsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.active).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: jobsProvider.jobStatus == JobStatus.active ? ColorsManager.green : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    jobsProvider.jobStatus = JobStatus.pending;
                    await jobsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.pending).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: jobsProvider.jobStatus == JobStatus.pending ? ColorsManager.amber : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    jobsProvider.jobStatus = JobStatus.rejected;
                    await jobsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.rejected).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: jobsProvider.jobStatus == JobStatus.rejected ? ColorsManager.red : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}