import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
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

class JobGridItem extends StatelessWidget {
  final JobModel jobModel;
  final Function onEdit;
  final Function onDelete;

  const JobGridItem({
    super.key,
    required this.jobModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
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
          Stack(
            children: [
              ImageWidget(
                image: jobModel.image,
                imageDirectory: ApiConstants.jobsDirectory,
                width: double.infinity,
                height: SizeManager.s100,
                borderRadius: SizeManager.s10,
                isShowFullImageScreen: false,
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.all(SizeManager.s8),
                  child: ViewsWidget(views: jobModel.views),
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          SizedBox(
            height: SizeManager.s40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    jobModel.jobTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.semiBold, height: SizeManager.s1_8),
                  ),
                ),
                if(Methods.checkAdminPermission(AdminPermissions.editJob) || Methods.checkAdminPermission(AdminPermissions.deleteJob)) ...[
                  const SizedBox(width: SizeManager.s5),
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
    );
  }
}