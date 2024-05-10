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
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';

class AdminListItem extends StatelessWidget {
  final AdminModel adminModel;
  final Function onEdit;
  final Function onDelete;

  const AdminListItem({
    super.key,
    required this.adminModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        FocusScope.of(context).unfocus();
        Methods.routeTo(context, Routes.adminProfileScreen, arguments: adminModel);
      },
      child: Row(
        children: [
          ImageWidget(
            image: adminModel.personalImage,
            imageDirectory: ApiConstants.adminsDirectory,
            defaultImage: ImagesManager.defaultAvatar,
            width: SizeManager.s50,
            height: SizeManager.s50,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: false,
          ),
          const SizedBox(width: SizeManager.s10),
          Expanded(
            child: NameWidget(
              fullName: adminModel.fullName,
              mainAxisAlignment: MainAxisAlignment.start,
              isSupportFeatured: false,
            ),
          ),
          if(Methods.checkAdminPermission(AdminPermissions.editAdmin) || Methods.checkAdminPermission(AdminPermissions.deleteAdmin)) ...[
            const SizedBox(width: SizeManager.s10),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editAdmin)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteAdmin)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditAdminScreen, arguments: adminModel, then: (admin) => onEdit(admin)),
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