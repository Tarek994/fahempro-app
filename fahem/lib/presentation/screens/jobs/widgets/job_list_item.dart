import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem/presentation/screens/jobs/controllers/jobs_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/views_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class JobListItem extends StatefulWidget {
  final JobModel jobModel;
  final int index;

  const JobListItem({
    super.key,
    required this.jobModel,
    required this.index,
  });

  @override
  State<JobListItem> createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  late JobsProvider jobsProvider;

  @override
  void initState() {
    super.initState();
    jobsProvider = Provider.of<JobsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Hover(
      color: widget.index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
      // color: ColorsManager.grey1,
      // boxShadow: ColorsManager.boxShadow2,
      onTap: () async {
        FocusScope.of(context).unfocus();
        await Methods.routeTo(
          context,
          Routes.jobDetailsScreen,
          arguments: widget.jobModel,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageWidget(
                image: widget.jobModel.image,
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
                        widget.jobModel.jobTitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorsManager.white,
                          fontWeight: FontWeightManager.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: SizeManager.s5),
                      Text(
                        widget.jobModel.companyName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: SizeManager.s5),
                      Text(
                        '${widget.jobModel.minSalary} - ${widget.jobModel.maxSalary} ${Methods.getText(StringsManager.egp).toUpperCase()}',
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: SizeManager.s5,
                  runSpacing: SizeManager.s10,
                  children: List.generate(widget.jobModel.features.length, (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                      decoration: BoxDecoration(
                        // color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(SizeManager.s10),
                        border: Border.all(color: ColorsManager.white),
                      ),
                      child: Text(
                        widget.jobModel.features[index],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorsManager.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              CustomButton(
                onPressed: () => Methods.routeTo(context, Routes.jobApplyScreen, arguments: widget.jobModel),
                // onPressed: () {
                //   Dialogs.getTextFromController(
                //     context: context,
                //     title: StringsManager.enterYourCvLink,
                //   ).then((value) {
                //     if(value != null) {
                //       if(Validator.validateLink(value) == null) {
                //         InsertEmploymentApplicationParameters parameters = InsertEmploymentApplicationParameters(
                //           accountId: widget.jobModel.accountId,
                //           userId: MyProviders.authenticationProvider.currentUser.userId,
                //           jobId: widget.jobModel.jobId,
                //           cv: value,
                //           createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                //         );
                //         jobsProvider.insertEmploymentApplication(
                //           context: context,
                //           insertEmploymentApplicationParameters: parameters,
                //         );
                //       }
                //       else {
                //         Dialogs.failureOccurred(
                //           context: context,
                //           failure: LocalFailure(
                //             messageAr: Validator.validateLink(value)!,
                //             messageEn: Validator.validateLink(value)!,
                //           ),
                //         );
                //       }
                //     }
                //   });
                // },
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.apply2).toCapitalized(),
                buttonColor: widget.index % 2 != 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
                height: SizeManager.s30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}