import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/complaint_model.dart';
import 'package:fahem_business/presentation/shared/widgets/date_widget.dart';

class ComplaintListItem extends StatefulWidget {
  final ComplaintModel complaintModel;
  final Function onDelete;

  const ComplaintListItem({
    super.key,
    required this.complaintModel,
    required this.onDelete,
  });

  @override
  State<ComplaintListItem> createState() => _ComplaintListItemState();
}

class _ComplaintListItemState extends State<ComplaintListItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DateWidget(createdAt: widget.complaintModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.deleteComplaint)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.deleteComplaint)) PopupMenu.delete,
                  ],
                  onPressedDelete: () {
                    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                      if(value) {
                        widget.onDelete();
                      }
                    });
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Text(
            widget.complaintModel.complaint,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_5),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              UserRowWidget(user: widget.complaintModel.user),
            ],
          ),
        ],
      ),
    );
  }
}