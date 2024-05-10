import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_expansion_tile.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/data/models/faq_model.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';

class FaqListItem extends StatelessWidget {
  final FaqModel faqModel;
  final Function onEdit;
  final Function onDelete;

  const FaqListItem({
    super.key,
    required this.faqModel,
    required this.onEdit,
    required this.onDelete,
  });
  
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      titleText: MyProviders.appProvider.isEnglish ? faqModel.questionEn : faqModel.questionAr,
      trailing: Methods.checkAdminPermission(AdminPermissions.editFaq) || Methods.checkAdminPermission(AdminPermissions.deleteFaq) ? CustomPopupMenu(
        items: [
          if(Methods.checkAdminPermission(AdminPermissions.editFaq)) PopupMenu.edit,
          if(Methods.checkAdminPermission(AdminPermissions.deleteFaq)) PopupMenu.delete,
        ],
        onPressedEdit: () => Methods.routeTo(context, Routes.insertEditFaqScreen, arguments: faqModel, then: (faq) => onEdit(faq)),
        onPressedDelete: () {
          Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
            if(value) {
              onDelete();
            }
          });
        },
      ) : null,
      children: [
        const SizedBox(width: SizeManager.s10),
        Text(
          MyProviders.appProvider.isEnglish ? faqModel.answerEn : faqModel.answerAr,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
        ),
      ],
    );
  }
}