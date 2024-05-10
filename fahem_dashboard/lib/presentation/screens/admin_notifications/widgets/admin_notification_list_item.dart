import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/set_is_viewed_usecase.dart';
import 'package:fahem_dashboard/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/admin_notification_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';

class AdminNotificationListItem extends StatefulWidget {
  final AdminNotificationModel adminNotificationModel;
  final Function onDelete;

  const AdminNotificationListItem({
    super.key,
    required this.adminNotificationModel,
    required this.onDelete,
  });

  @override
  State<AdminNotificationListItem> createState() => _AdminNotificationListItemState();
}

class _AdminNotificationListItemState extends State<AdminNotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        if(!widget.adminNotificationModel.isViewed) {
          SetIsViewedParameters parameters = SetIsViewedParameters(adminNotificationId: widget.adminNotificationModel.adminNotificationId);
          DependencyInjection.setIsViewedUseCase.call(parameters).then((response) {
            response.fold((failure) {}, (isViewed) {
              widget.adminNotificationModel.isViewed = isViewed;
              setState(() {});
            });
          });
        }
        Dialogs.showBottomSheet(
          context: context,
          child: InfoBtmSheet(
            title: widget.adminNotificationModel.title,
            body: widget.adminNotificationModel.body,
          ),
        ).then((value) {
        });
      },
      color: widget.adminNotificationModel.isViewed ? ColorsManager.white : ColorsManager.lightPrimaryColor.withOpacity(0.5),
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
                      child: DateWidget(createdAt: widget.adminNotificationModel.createdAt),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  widget.adminNotificationModel.title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: SizeManager.s5),
                Text(
                  widget.adminNotificationModel.body,
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