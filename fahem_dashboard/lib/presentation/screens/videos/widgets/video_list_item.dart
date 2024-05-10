import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/video_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoListItem extends StatelessWidget {
  final VideoModel videoModel;
  final Function onEdit;
  final Function onDelete;

  const VideoListItem({
    super.key,
    required this.videoModel,
    required this.onEdit,
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
                child: DateWidget(createdAt: videoModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editVideo) || Methods.checkAdminPermission(AdminPermissions.deleteVideo)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editVideo)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteVideo)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditVideoScreen, arguments: videoModel, then: (video) => onEdit(video)),
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
          const SizedBox(height: SizeManager.s20),
          Text(
            MyProviders.appProvider.isEnglish ? videoModel.titleEn : videoModel.titleAr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: () => Methods.openUrl(url: videoModel.link),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.playVideo).toTitleCase(),
            iconData: FontAwesomeIcons.youtube,
            height: SizeManager.s40,
            width: double.infinity,
            buttonColor: ColorsManager.lightSecondaryColor,
          ),
        ],
      ),
    );
  }
}