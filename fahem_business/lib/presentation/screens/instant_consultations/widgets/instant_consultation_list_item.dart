import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/insert_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';

class InstantConsultationListItem extends StatefulWidget {
  final InstantConsultationModel instantConsultationModel;

  const InstantConsultationListItem({
    super.key,
    required this.instantConsultationModel,
  });

  @override
  State<InstantConsultationListItem> createState() => _InstantConsultationListItemState();
}

class _InstantConsultationListItemState extends State<InstantConsultationListItem> {
  bool _isLoading = false;

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
                child: DateWidget(createdAt: widget.instantConsultationModel.createdAt),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Hover(
            onTap: () {
              Dialogs.showBottomSheet(
                context: context,
                child: InfoBtmSheet(
                  title: '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
                  body: widget.instantConsultationModel.consultation,
                ),
              );
            },
            color: ColorsManager.grey100,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    widget.instantConsultationModel.consultation,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: _isLoading ? null : () {
              Dialogs.getTextFromController(
                context: context,
                title: StringsManager.replyToTheConsultation,
              ).then((value) async {
                if(value != null) {
                  setState(() => _isLoading = true);
                  InsertInstantConsultationCommentParameters parameters = InsertInstantConsultationCommentParameters(
                    instantConsultationId: widget.instantConsultationModel.instantConsultationId,
                    accountId: MyProviders.authenticationProvider.currentAccount.accountId,
                    comment: value.trim(),
                    commentStatus: CommentStatus.pending,
                    reasonOfReject: null,
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  await DependencyInjection.insertInstantConsultationCommentUseCase.call(parameters).then((response) async {
                    await response.fold((failure) async {
                      setState(() => _isLoading = false);
                      await Dialogs.failureOccurred(context: context, failure: failure);
                    }, (instantConsultationComment) async {
                      setState(() => _isLoading = false);
                      Methods.sendNotificationToAdmin(
                        title: 'رد على استشارة فورية',
                        body: '${"قام"} ${MyProviders.authenticationProvider.currentAccount.fullName} ${"بالرد على استشارة فورية رقم #"}${instantConsultationComment.instantConsultationId} ${"قم بمراجعة الرد الان"}',
                      );
                      Dialogs.showBottomSheetMessage(
                        context: context,
                        message: Methods.getText(StringsManager.yourReplyToTheConsultationHasBeenSentSuccessfully).toTitleCase(),
                        showMessage: ShowMessage.success,
                      );
                    });
                  });
                }
              });
            },
            buttonType: ButtonType.text,
            isLoading: _isLoading,
            text: Methods.getText(StringsManager.replyToTheConsultation).toCapitalized(),
            width: double.infinity,
            height: SizeManager.s40,
          ),
        ],
      ),
    );
  }
}