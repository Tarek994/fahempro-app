import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/domain/usecases/instant_consultations/edit_instant_consultation_usecase.dart';
import 'package:fahem/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem/presentation/screens/transactions/controllers/transactions_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InstantConsultationListItem extends StatefulWidget {
  final InstantConsultationModel instantConsultationModel;
  final Function onEdit;

  const InstantConsultationListItem({
    super.key,
    required this.instantConsultationModel,
    required this.onEdit,
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
        color: widget.instantConsultationModel.isViewed ? ColorsManager.white : ColorsManager.lightSecondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Methods.getText(StringsManager.bookAnInstantConsultation).toCapitalized(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeightManager.black,
                  color: ColorsManager.green,
                ),
              ),
              const SizedBox(width: SizeManager.s5),
              Text(
                Methods.formatDate(milliseconds: int.parse(widget.instantConsultationModel.createdAt)),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeightManager.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          const Divider(color: ColorsManager.grey, height: SizeManager.s0),
          const SizedBox(height: SizeManager.s10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: SizeManager.s5),
              Text(
                '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeightManager.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),

          CustomButton(
            onPressed: () => Methods.routeTo(
              context,
              Routes.instantConsultationsCommentsScreen,
              arguments: InstantConsultationsCommentsArgs(instantConsultation: widget.instantConsultationModel),
            ),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.comments).toCapitalized(),
            iconData: FontAwesomeIcons.comment,
            buttonColor: ColorsManager.lightPrimaryColor,
            iconColor: ColorsManager.white,
            width: double.infinity,
            height: SizeManager.s35,
          ),

          if(widget.instantConsultationModel.isDone) ...[
            const SizedBox(height: SizeManager.s10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.green,
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      Methods.getText(StringsManager.theConsultationHasBeenClosed).toCapitalized(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: SizeManager.s10),
                  const Icon(Icons.check, color: ColorsManager.white, size: SizeManager.s18),
                ],
              ),
            ),
          ]
          else ...[
            const SizedBox(height: SizeManager.s10),
            CustomButton(
              onPressed: () {
                Dialogs.instantConsultationCommentsBottomSheet(
                  context: context,
                  instantConsultationId: widget.instantConsultationModel.instantConsultationId,
                ).then((instantConsultationComment) async {
                  if(instantConsultationComment != null) {
                    setState(() => _isLoading = true);
                    EditInstantConsultationParameters parameters = EditInstantConsultationParameters(
                      instantConsultationId: widget.instantConsultationModel.instantConsultationId,
                      userId: widget.instantConsultationModel.userId,
                      consultation: widget.instantConsultationModel.consultation,
                      isDone: true,
                      bestInstantConsultationCommentId: instantConsultationComment.instantConsultationCommentId,
                      isViewed: widget.instantConsultationModel.isViewed,
                      images: widget.instantConsultationModel.images,
                    );
                    await DependencyInjection.editInstantConsultationUseCase.call(parameters).then((response) {
                      response.fold((failure) {
                        setState(() => _isLoading = false);
                      }, (instantConsultationModel) async {
                        InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
                          userType: UserType.account,
                          accountId: instantConsultationComment.account.accountId,
                          amount: 250,
                          walletTransactionType: WalletTransactionType.bestResponse,
                          textAr: '${"تم اضافة 250 جنية الى حسابك لافضل رد على استشارة فورية رقم#"} ${widget.instantConsultationModel.instantConsultationId}',
                          textEn: '250 EGP has been added to your account for the best response to instant consultation #${widget.instantConsultationModel.instantConsultationId}',
                          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                        );
                        await DependencyInjection.insertWalletHistoryUseCase.call(insertWalletHistoryParameters).then((response) {
                          response.fold((failure) {
                            setState(() => _isLoading = false);
                          }, (walletHistoryModel) {
                            setState(() => _isLoading = false);
                            Methods.sendNotificationToBusiness(
                              accountId: instantConsultationComment.account.accountId,
                              title: 'افضل رد',
                              body: '${"تم اضافة 250 جنية الى حسابك لافضل رد على استشارة فورية رقم#"} ${widget.instantConsultationModel.instantConsultationId}',
                            );
                            Provider.of<TransactionsProvider>(context, listen: false).editInInstantConsultations(instantConsultationModel);
                          });
                        });

                      });
                    });
                  }
                });
              },
              buttonType: ButtonType.preIcon,
              isLoading: _isLoading,
              text: Methods.getText(StringsManager.closeTheConsultation).toCapitalized(),
              iconData: Icons.close,
              buttonColor: ColorsManager.red700,
              iconColor: ColorsManager.white,
              width: double.infinity,
              height: SizeManager.s35,
            ),
          ],

          if(widget.instantConsultationModel.bestInstantConsultationComment != null) ...[
            const SizedBox(height: SizeManager.s10),
            CustomButton(
              onPressed: () {
                Dialogs.showBottomSheet(
                  context: context,
                  child: InfoBtmSheet(
                    title: Methods.getText(StringsManager.bestResponse).toTitleCase(),
                    body: widget.instantConsultationModel.bestInstantConsultationComment!.comment,
                  ),
                );
              },
              buttonType: ButtonType.preImage,
              text: Methods.getText(StringsManager.bestResponse).toTitleCase(),
              imageName: IconsManager.rating,
              buttonColor: ColorsManager.lightSecondaryColor,
              imageColor: ColorsManager.white,
              width: double.infinity,
              height: SizeManager.s35,
            ),
          ],
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Dialogs.showBottomSheet(
                      context: context,
                      child: InfoBtmSheet(
                        title: '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
                        body: widget.instantConsultationModel.consultation,
                        images: widget.instantConsultationModel.images,
                        imageDirectory: ApiConstants.instantConsultationsDirectory,
                      ),
                    );
                  },
                  buttonType: ButtonType.preImage,
                  text: Methods.getText(StringsManager.returnToTransaction).toCapitalized(),
                  imageName: IconsManager.returnToTheTransaction,
                  buttonColor: ColorsManager.lightPrimaryColor,
                  imageColor: ColorsManager.white,
                  width: double.infinity,
                  height: SizeManager.s35,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () => Methods.routeTo(context, Routes.chatRoomRoute),
                  buttonType: ButtonType.preImage,
                  text: Methods.getText(StringsManager.help).toCapitalized(),
                  imageName: IconsManager.helpOutline,
                  buttonColor: ColorsManager.lightSecondaryColor,
                  imageColor: ColorsManager.white,
                  width: double.infinity,
                  height: SizeManager.s35,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.all(SizeManager.s10),
    //   decoration: BoxDecoration(
    //     color: ColorsManager.grey1,
    //     borderRadius: BorderRadius.circular(SizeManager.s10),
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: DateWidget(createdAt: widget.instantConsultationModel.createdAt),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: SizeManager.s10),
    //       Hover(
    //         onTap: () {
    //           Dialogs.showBottomSheet(
    //             context: context,
    //             child: InfoBtmSheet(
    //               title: '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
    //               body: widget.instantConsultationModel.consultation,
    //             ),
    //           );
    //         },
    //         color: ColorsManager.grey100,
    //         child: SizedBox(
    //           width: double.infinity,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
    //               ),
    //               const SizedBox(height: SizeManager.s10),
    //               Text(
    //                 widget.instantConsultationModel.consultation,
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: SizeManager.s10),
    //       CustomButton(
    //         onPressed: () => Methods.routeTo(
    //           context,
    //           Routes.instantConsultationsCommentsScreen,
    //           arguments: InstantConsultationsCommentsArgs(instantConsultation: widget.instantConsultationModel),
    //         ),
    //         buttonType: ButtonType.preIcon,
    //         text: Methods.getText(StringsManager.instantConsultationsComments).toTitleCase(),
    //         iconData: FontAwesomeIcons.comment,
    //         width: double.infinity,
    //         height: SizeManager.s40,
    //       ),
    //       if(widget.instantConsultationModel.isDone) ...[
    //         const SizedBox(height: SizeManager.s10),
    //         Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(SizeManager.s10),
    //           decoration: BoxDecoration(
    //             color: ColorsManager.red,
    //             borderRadius: BorderRadius.circular(SizeManager.s10),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text(
    //                   Methods.getText(StringsManager.theConsultationHasBeenClosed).toCapitalized(),
    //                   style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //               const SizedBox(width: SizeManager.s10),
    //               const Icon(Icons.check, color: ColorsManager.white, size: SizeManager.s18),
    //             ],
    //           ),
    //         ),
    //       ],
    //       if(widget.instantConsultationModel.bestAccount != null) ...[
    //         const SizedBox(height: SizeManager.s10),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             Text(
    //               Methods.getText(StringsManager.bestResponse).toTitleCase(),
    //               style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.bold),
    //             ),
    //             const SizedBox(width: SizeManager.s10),
    //             AccountRowWidget(account: widget.instantConsultationModel.bestAccount!),
    //           ],
    //         ),
    //       ],
    //     ],
    //   ),
    // );
    //
    // return Container(
    //   padding: const EdgeInsets.all(SizeManager.s10),
    //   decoration: BoxDecoration(
    //     color: ColorsManager.white,
    //     borderRadius: BorderRadius.circular(SizeManager.s10),
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: DateWidget(createdAt: widget.instantConsultationModel.createdAt),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: SizeManager.s10),
    //       Hover(
    //         onTap: () {
    //           Dialogs.showBottomSheet(
    //             context: context,
    //             child: InfoBtmSheet(
    //               title: '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
    //               body: widget.instantConsultationModel.consultation,
    //             ),
    //           );
    //         },
    //         color: ColorsManager.grey100,
    //         child: SizedBox(
    //           width: double.infinity,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 '${Methods.getText(StringsManager.consultationId)} #${widget.instantConsultationModel.instantConsultationId}',
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
    //               ),
    //               const SizedBox(height: SizeManager.s10),
    //               Text(
    //                 widget.instantConsultationModel.consultation,
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       if(widget.instantConsultationModel.isDone) ...[
    //         const SizedBox(height: SizeManager.s10),
    //         Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(SizeManager.s10),
    //           decoration: BoxDecoration(
    //             color: ColorsManager.red,
    //             borderRadius: BorderRadius.circular(SizeManager.s10),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text(
    //                   Methods.getText(StringsManager.theConsultationHasBeenClosed).toCapitalized(),
    //                   style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //               const SizedBox(width: SizeManager.s10),
    //               const Icon(Icons.check, color: ColorsManager.white, size: SizeManager.s18),
    //             ],
    //           ),
    //         ),
    //       ],
    //       const SizedBox(height: SizeManager.s10),
    //       CustomButton(
    //         onPressed: () {
    //           Methods.routeTo(
    //             context,
    //             Routes.instantConsultationsCommentsScreen,
    //             arguments: InstantConsultationsCommentsArgs(
    //               instantConsultation: widget.instantConsultationModel,
    //             ),
    //           );
    //         },
    //         buttonType: ButtonType.preIcon,
    //         text: Methods.getText(StringsManager.instantConsultationsComments).toCapitalized(),
    //         iconData: FontAwesomeIcons.comment,
    //         width: double.infinity,
    //         height: SizeManager.s40,
    //       ),
    //       // if(instantConsultationModel.bestAccount != null && instantConsultationModel.bestAccount!.accountId == MyProviders.authenticationProvider.currentAccount.accountId) ...[
    //       //   const SizedBox(height: SizeManager.s10),
    //       //   Row(
    //       //   mainAxisAlignment: MainAxisAlignment.end,
    //       //   children: [
    //       //     Text(
    //       //       Methods.getText(StringsManager.bestResponse).toTitleCase(),
    //       //       style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.bold),
    //       //     ),
    //       //     const SizedBox(width: SizeManager.s10),
    //       //     AccountRowWidget(account: instantConsultationModel.bestAccount!),
    //       //   ],
    //       // ),
    //       // ],
    //     ],
    //   ),
    // );
  }
}