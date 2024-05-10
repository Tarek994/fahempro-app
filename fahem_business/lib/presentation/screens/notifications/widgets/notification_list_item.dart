import 'package:fahem_business/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/notification_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/date_widget.dart';

class NotificationListItem extends StatefulWidget {
  final NotificationModel notificationModel;
  final Function onDelete;

  const NotificationListItem({
    super.key,
    required this.notificationModel,
    required this.onDelete,
  });

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        Dialogs.showBottomSheet(
          context: context,
          child: InfoBtmSheet(
            title: widget.notificationModel.title,
            body: widget.notificationModel.body,
          ),
        ).then((value) {
        });
      },
      color: ColorsManager.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DateWidget(createdAt: widget.notificationModel.createdAt),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  widget.notificationModel.title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: SizeManager.s5),
                Text(
                  widget.notificationModel.body,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: SizeManager.s10),
          CustomPopupMenu(
            items: const [PopupMenu.delete],
            onPressedDelete: () {
              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                if(value) {
                  widget.onDelete();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}