import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_business/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/date_widget.dart';
import 'package:flutter/material.dart';

class InstantConsultationCommentListItem extends StatelessWidget {
  final InstantConsultationCommentModel instantConsultationCommentModel;
  final Function onEdit;
  final Function onDelete;
  final bool showConsultationId;
  final bool showAccount;

  const InstantConsultationCommentListItem({
    super.key,
    required this.instantConsultationCommentModel,
    required this.onEdit,
    required this.onDelete,
    required this.showConsultationId,
    required this.showAccount,
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
                child: DateWidget(createdAt: instantConsultationCommentModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editInstantConsultationComment) || Methods.checkAdminPermission(AdminPermissions.deleteInstantConsultationComment)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editInstantConsultationComment)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteInstantConsultationComment)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditInstantConsultationCommentScreen, arguments: instantConsultationCommentModel, then: (instantConsultationComment) => onEdit(instantConsultationComment)),
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
                if(showConsultationId) ...[
                  Text(
                    '${Methods.getText(StringsManager.consultationId)} #${instantConsultationCommentModel.instantConsultationId}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                ],
                Text(
                  instantConsultationCommentModel.comment,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
                ),
              ],
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(showAccount) ...[
                Expanded(
                  flex: 2,
                  child: AccountRowWidget(account: instantConsultationCommentModel.account),
                ),
                const SizedBox(width: SizeManager.s10),
              ],
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: CommentStatus.getColor(instantConsultationCommentModel.commentStatus).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(SizeManager.s10),
                  ),
                  child: Text(
                    CommentStatus.toText(instantConsultationCommentModel.commentStatus),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          if(instantConsultationCommentModel.commentStatus == CommentStatus.rejected && instantConsultationCommentModel.reasonOfReject != null) ...[
            const SizedBox(height: SizeManager.s10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    instantConsultationCommentModel.reasonOfReject!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}