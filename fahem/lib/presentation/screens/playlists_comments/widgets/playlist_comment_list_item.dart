import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:fahem/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/data/models/playlist_comment_model.dart';

class PlaylistCommentListItem extends StatelessWidget {
  final PlaylistCommentModel playlistCommentModel;

  const PlaylistCommentListItem({
    super.key,
    required this.playlistCommentModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.grey1,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: UserRowWidget(
                  user: playlistCommentModel.user,
                  color: Colors.transparent,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeightManager.bold,
                    fontSize: SizeManager.s16,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              const SizedBox(width: SizeManager.s5),
              Padding(
                padding: const EdgeInsets.only(top: SizeManager.s10),
                child: Text(
                  Methods.formatDate(milliseconds: int.parse(playlistCommentModel.createdAt)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          // const SizedBox(height: SizeManager.s10),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                playlistCommentModel.comment,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
              ),
            ),
          ),
        ],
      ),
    );
  }
}