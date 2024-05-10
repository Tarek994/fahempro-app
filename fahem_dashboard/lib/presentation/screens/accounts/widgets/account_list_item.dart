import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';

class AccountListItem extends StatelessWidget {
  final AccountModel accountModel;
  final Function onEdit;
  final Function onDelete;

  const AccountListItem({
    super.key,
    required this.accountModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        FocusScope.of(context).unfocus();
        Methods.routeTo(context, Routes.accountProfileScreen, arguments: accountModel);
      },
      child: Row(
        children: [
          ImageWidget(
            image: accountModel.personalImage,
            imageDirectory: ApiConstants.accountsDirectory,
            defaultImage: ImagesManager.defaultAvatar,
            width: SizeManager.s50,
            height: SizeManager.s50,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: false,
          ),
          const SizedBox(width: SizeManager.s10),
          Expanded(
            child: NameWidget(
              fullName: accountModel.fullName,
              isFeatured: accountModel.isFeatured,
              isSupportFeatured: true,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          if(Methods.checkAdminPermission(AdminPermissions.editAccount) || Methods.checkAdminPermission(AdminPermissions.deleteAccount)) ...[
            const SizedBox(width: SizeManager.s10),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editAccount)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteAccount)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditAccountScreen, arguments: accountModel, then: (account) => onEdit(account)),
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
    );
  }
}