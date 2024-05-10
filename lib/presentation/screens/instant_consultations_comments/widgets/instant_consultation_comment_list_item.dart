import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:flutter/material.dart';

class InstantConsultationCommentListItem extends StatelessWidget {
  final InstantConsultationCommentModel instantConsultationCommentModel;

  const InstantConsultationCommentListItem({
    super.key,
    required this.instantConsultationCommentModel,
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
            children: [
              Expanded(
                child: DateWidget(createdAt: instantConsultationCommentModel.createdAt),
              ),
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
                Text(
                  '${Methods.getText(StringsManager.consultationId)} #${instantConsultationCommentModel.instantConsultationId}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                ),
                const SizedBox(height: SizeManager.s10),
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
              Expanded(
                flex: 2,
                child: AccountRowWidget(account: instantConsultationCommentModel.account),
              ),
            ],
          ),
        ],
      ),
    );
  }
}