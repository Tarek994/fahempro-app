import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_expansion_tile.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem/data/models/suggested_message_model.dart';
import 'package:flutter/material.dart';

class SuggestedMessageListItem extends StatelessWidget {
  final SuggestedMessageModel suggestedMessageModel;
  final Function onEdit;
  final Function onDelete;

  const SuggestedMessageListItem({super.key, required this.suggestedMessageModel, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      titleText: MyProviders.appProvider.isEnglish ? suggestedMessageModel.messageEn : suggestedMessageModel.messageAr,
      trailing: Methods.checkAdminPermission(AdminPermissions.editSuggestedMessage) || Methods.checkAdminPermission(AdminPermissions.deleteSuggestedMessage) ? CustomPopupMenu(
        items: [
          if(Methods.checkAdminPermission(AdminPermissions.editSuggestedMessage)) PopupMenu.edit,
          if(Methods.checkAdminPermission(AdminPermissions.deleteSuggestedMessage)) PopupMenu.delete,
        ],
        onPressedEdit: () => Methods.routeTo(context, Routes.insertEditSuggestedMessageScreen, arguments: suggestedMessageModel, then: (suggestedMessage) => onEdit(suggestedMessage)),
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
          MyProviders.appProvider.isEnglish ? suggestedMessageModel.answerEn : suggestedMessageModel.answerAr,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
        ),
      ],
    );
  }
}