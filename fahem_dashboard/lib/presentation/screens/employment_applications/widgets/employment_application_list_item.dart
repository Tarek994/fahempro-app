import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/data/models/employment_application_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmploymentApplicationListItem extends StatelessWidget {
  final EmploymentApplicationModel employmentApplicationModel;
  final Function onDelete;

  const EmploymentApplicationListItem({
    super.key,
    required this.employmentApplicationModel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DateWidget(createdAt: employmentApplicationModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.deleteEmploymentApplication)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.deleteEmploymentApplication)) PopupMenu.delete,
                  ],
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
          CustomButton(
            onPressed: () => Methods.openUrl(url: employmentApplicationModel.cv),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.showCv),
            iconData: FontAwesomeIcons.link,
            height: SizeManager.s40,
            width: double.infinity,
            buttonColor: ColorsManager.grey1,
            textColor: ColorsManager.black,
            iconColor: ColorsManager.black,
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UserRowWidget(user: employmentApplicationModel.user)),
              const SizedBox(width: SizeManager.s10),
              Expanded(child: AccountRowWidget(account: employmentApplicationModel.account)),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Hover(
            onTap: () => Methods.routeTo(context, Routes.jobDetailsScreen, arguments: employmentApplicationModel.job),
            color: ColorsManager.grey100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(FontAwesomeIcons.briefcase, size: SizeManager.s14),
                const SizedBox(width: SizeManager.s10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: SizeManager.s2),
                    child: Text(
                      '${Methods.getText(StringsManager.job)}: ${employmentApplicationModel.job.jobTitle}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}