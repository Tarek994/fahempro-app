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
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';

class UserGridItem extends StatelessWidget {
  final UserModel userModel;
  final Function onEdit;
  final Function onDelete;

  const UserGridItem({
    super.key,
    required this.userModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        FocusScope.of(context).unfocus();
        Methods.routeTo(context, Routes.userProfileScreen, arguments: userModel);
      },
      child: Row(
        children: [
          ImageWidget(
            image: userModel.personalImage,
            imageDirectory: ApiConstants.usersDirectory,
            defaultImage: ImagesManager.defaultAvatar,
            width: SizeManager.s40,
            height: SizeManager.s40,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: false,
          ),
          const SizedBox(width: SizeManager.s10),
          Expanded(
            child: NameWidget(
              fullName: userModel.fullName,
              isFeatured: userModel.isFeatured,
              isSupportFeatured: true,
              isOverflow: true,
              maxLines: 2,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          if(Methods.checkAdminPermission(AdminPermissions.editUser) || Methods.checkAdminPermission(AdminPermissions.deleteUser)) ...[
            const SizedBox(width: SizeManager.s5),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editUser)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteUser)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditUserScreen, arguments: userModel, then: (user) => onEdit(user)),
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