import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:fahem_business/presentation/shared/widgets/views_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobListItem extends StatelessWidget {
  final JobModel jobModel;
  final Function onEdit;
  final Function onDelete;

  const JobListItem({
    super.key,
    required this.jobModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        FocusScope.of(context).unfocus();
        Methods.routeTo(context, Routes.jobDetailsScreen, arguments: jobModel);
      },
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                image: jobModel.image,
                imageDirectory: ApiConstants.jobsDirectory,
                width: SizeManager.s100,
                height: SizeManager.s100,
                borderRadius: SizeManager.s10,
                isShowFullImageScreen: false,
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            jobModel.jobTitle,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.semiBold, height: SizeManager.s1_8),
                          ),
                        ),
                        ViewsWidget(views: jobModel.views),
                        if(Methods.checkAdminPermission(AdminPermissions.editJob) || Methods.checkAdminPermission(AdminPermissions.deleteJob)) ...[
                          const SizedBox(width: SizeManager.s10),
                          CustomPopupMenu(
                            items: [
                              if(Methods.checkAdminPermission(AdminPermissions.editJob)) PopupMenu.edit,
                              if(Methods.checkAdminPermission(AdminPermissions.deleteJob)) PopupMenu.delete,
                            ],
                            onPressedEdit: () => Methods.routeTo(context, Routes.insertEditJobScreen, arguments: jobModel, then: (job) => onEdit(job)),
                            onPressedDelete: () {
                              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                                if(value) {
                                  onDelete();
                                }
                              });
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.profile, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            jobModel.account.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.location, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            jobModel.jobLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Row(
                      children: [
                        Image.asset(IconsManager.coins, color: ColorsManager.lightPrimaryColor, width: SizeManager.s12, height: SizeManager.s12),
                        const SizedBox(width: SizeManager.s5),
                        Expanded(
                          child: Text(
                            '${jobModel.minSalary} - ${jobModel.maxSalary} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: () => Methods.routeTo(
              context,
              Routes.employmentApplicationsScreen,
              arguments: EmploymentApplicationsArgs(job: jobModel),
            ),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.employmentApplications).toTitleCase(),
            iconData: FontAwesomeIcons.file,
            width: double.infinity,
            height: SizeManager.s40,
          ),
          const SizedBox(height: SizeManager.s10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(SizeManager.s10),
            decoration: BoxDecoration(
              color: JobStatus.getColor(jobModel.jobStatus).withOpacity(0.8),
              borderRadius: BorderRadius.circular(SizeManager.s10),
            ),
            child: Row(
              children: [
                Icon(
                  JobStatus.getIcon(jobModel.jobStatus),
                  color: ColorsManager.white,
                  size: SizeManager.s16,
                ),
                const SizedBox(width: SizeManager.s10),
                Text(
                  JobStatus.toText(jobModel.jobStatus),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                ),
              ],
            ),
          ),
          if(jobModel.jobStatus == JobStatus.rejected && jobModel.reasonOfReject != null) ...[
            const SizedBox(height: SizeManager.s10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    jobModel.reasonOfReject!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}