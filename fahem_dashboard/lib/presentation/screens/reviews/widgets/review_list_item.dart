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
import 'package:fahem_dashboard/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/data/models/review_model.dart';

class ReviewListItem extends StatelessWidget {
  final ReviewModel reviewModel;
  final Function onEdit;
  final Function onDelete;

  const ReviewListItem({
    super.key,
    required this.reviewModel,
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
                child: DateWidget(createdAt: reviewModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editReview) || Methods.checkAdminPermission(AdminPermissions.deleteReview)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editReview)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteReview)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditReviewScreen, arguments: reviewModel, then: (review) => onEdit(review)),
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
            padding: const EdgeInsets.all(SizeManager.s10),
            decoration: BoxDecoration(
              color: ColorsManager.grey100,
              borderRadius: BorderRadius.circular(SizeManager.s10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reviewModel.comment,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    Column(
                      children: [
                        const Icon(Icons.star, color: ColorsManager.amber, size: SizeManager.s18),
                        const SizedBox(height: SizeManager.s5),
                        Text(reviewModel.rating.toInt().toString()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s5),
                Wrap(
                  spacing: SizeManager.s5,
                  runSpacing: SizeManager.s5,
                  children: MyProviders.appProvider.isEnglish
                    ? List.generate(reviewModel.featuresEn.length, (index) => _FeatureItem(text: reviewModel.featuresEn[index]))
                    : List.generate(reviewModel.featuresAr.length, (index) => _FeatureItem(text: reviewModel.featuresAr[index])),
                ),
              ],
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UserRowWidget(user: reviewModel.user)),
              const SizedBox(width: SizeManager.s10),
              Expanded(child: AccountRowWidget(account: reviewModel.account)),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
