import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/data/models/playlist_comment_model.dart';

class PlaylistCommentListItem extends StatelessWidget {
  final PlaylistCommentModel playlistCommentModel;
  final Function onEdit;
  final Function onDelete;

  const PlaylistCommentListItem({
    super.key,
    required this.playlistCommentModel,
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
                child: DateWidget(createdAt: playlistCommentModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editPlaylistComment) || Methods.checkAdminPermission(AdminPermissions.deletePlaylistComment)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editPlaylistComment)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deletePlaylistComment)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditPlaylistCommentScreen, arguments: playlistCommentModel, then: (playlistComment) => onEdit(playlistComment)),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(SizeManager.s10),
            decoration: BoxDecoration(
              color: ColorsManager.grey100,
              borderRadius: BorderRadius.circular(SizeManager.s10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(SizeManager.s5),
                  ),
                  child: Text(
                    MyProviders.appProvider.isEnglish ? playlistCommentModel.playlist.playlistNameEn : playlistCommentModel.playlist.playlistNameAr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  playlistCommentModel.comment,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                ),
              ],
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserRowWidget(user: playlistCommentModel.user),
            ],
          ),
        ],
      ),
    );
  }
}