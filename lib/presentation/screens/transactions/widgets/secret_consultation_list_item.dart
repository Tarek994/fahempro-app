import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/secret_consultation_model.dart';
import 'package:fahem/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecretConsultationListItem extends StatelessWidget {
  final SecretConsultationModel secretConsultationModel;

  const SecretConsultationListItem({
    super.key,
    required this.secretConsultationModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: secretConsultationModel.isViewed ? ColorsManager.white : ColorsManager.lightSecondaryColor.withOpacity(0.3),
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
                Methods.formatDate(milliseconds: int.parse(secretConsultationModel.createdAt)),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeightManager.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          const Divider(color: ColorsManager.grey, height: SizeManager.s0),
          const SizedBox(height: SizeManager.s10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeightManager.black,
                      ),
                    ),
                    const SizedBox(height: SizeManager.s5),
                    Text(
                      secretConsultationModel.consultation,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SizeManager.s5),
                    Text(
                      Methods.getText(StringsManager.replyToTheConsultationThrough).toCapitalized(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: SizeManager.s5),
                    Row(
                      children: [
                        Text(
                          '${SecretConsultationReplyType.toText(secretConsultationModel.secretConsultationReplyType)}: ${secretConsultationModel.replyTypeValue}',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                        ),
                        // const SizedBox(width: SizeManager.s10),
                        // if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.call) CustomButton(
                        //   onPressed: () async {
                        //     await Methods.openUrl(url: 'tel:${secretConsultationModel.replyTypeValue}');
                        //   },
                        //   buttonType: ButtonType.preIcon,
                        //   text: secretConsultationModel.replyTypeValue,
                        //   iconData: FontAwesomeIcons.phone,
                        //   buttonColor: ColorsManager.blue,
                        //   height: SizeManager.s30,
                        //   borderRadius: SizeManager.s5,
                        // ),
                        // if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.whatsapp) CustomButton(
                        //   onPressed: () async {
                        //     await Methods.openUrl(url: 'https://wa.me/+2${secretConsultationModel.replyTypeValue}');
                        //   },
                        //   buttonType: ButtonType.preIcon,
                        //   text: secretConsultationModel.replyTypeValue,
                        //   iconData: FontAwesomeIcons.whatsapp,
                        //   buttonColor: ColorsManager.whatsapp,
                        //   height: SizeManager.s30,
                        //   borderRadius: SizeManager.s5,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Dialogs.showBottomSheet(
                      context: context,
                      child: InfoBtmSheet(
                        title: '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
                        body: secretConsultationModel.consultation,
                        images: secretConsultationModel.images,
                        imageDirectory: ApiConstants.secretConsultationsDirectory,
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
    //     color: ColorsManager.white,
    //     borderRadius: BorderRadius.circular(SizeManager.s10),
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: DateWidget(createdAt: secretConsultationModel.createdAt),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: SizeManager.s10),
    //       Hover(
    //         onTap: () {
    //           Dialogs.showBottomSheet(
    //             context: context,
    //             child: InfoBtmSheet(
    //               title: '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
    //               body: secretConsultationModel.consultation,
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
    //                 '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
    //               ),
    //               const SizedBox(height: SizeManager.s10),
    //               Text(
    //                 secretConsultationModel.consultation,
    //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: SizeManager.s10),
    //       if(secretConsultationModel.images.isNotEmpty) ...[
    //         SizedBox(
    //           width: double.infinity,
    //           child: Wrap(
    //             spacing: SizeManager.s10,
    //             runSpacing: SizeManager.s10,
    //             children: List.generate(secretConsultationModel.images.length, (index) => ImageWidget(
    //               image: secretConsultationModel.images[index],
    //               imageDirectory: ApiConstants.secretConsultationsDirectory,
    //               width: SizeManager.s70,
    //               height: SizeManager.s70,
    //               borderRadius: SizeManager.s10,
    //               isShowFullImageScreen: true,
    //             )),
    //           ),
    //         ),
    //         const SizedBox(height: SizeManager.s10),
    //       ],
    //       const SizedBox(height: SizeManager.s10),
    //       Container(
    //         width: double.infinity,
    //         padding: const EdgeInsets.all(SizeManager.s10),
    //         decoration: BoxDecoration(
    //           color: ColorsManager.grey100,
    //           borderRadius: BorderRadius.circular(SizeManager.s10),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               Methods.getText(StringsManager.replyToTheConsultationThrough).toCapitalized(),
    //               style: Theme.of(context).textTheme.bodyMedium,
    //             ),
    //             const SizedBox(height: SizeManager.s10),
    //             Row(
    //               children: [
    //                 Text(
    //                   SecretConsultationReplyType.toText(secretConsultationModel.secretConsultationReplyType),
    //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
    //                 ),
    //                 const SizedBox(width: SizeManager.s10),
    //                 if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.call) CustomButton(
    //                   onPressed: () async {
    //                     await Methods.openUrl(url: 'tel:${secretConsultationModel.replyTypeValue}');
    //                   },
    //                   buttonType: ButtonType.preIcon,
    //                   text: secretConsultationModel.replyTypeValue,
    //                   iconData: FontAwesomeIcons.phone,
    //                   buttonColor: ColorsManager.blue,
    //                   height: SizeManager.s30,
    //                   borderRadius: SizeManager.s5,
    //                 ),
    //                 if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.whatsapp) CustomButton(
    //                   onPressed: () async {
    //                     await Methods.openUrl(url: 'https://wa.me/+2${secretConsultationModel.replyTypeValue}');
    //                   },
    //                   buttonType: ButtonType.preIcon,
    //                   text: secretConsultationModel.replyTypeValue,
    //                   iconData: FontAwesomeIcons.whatsapp,
    //                   buttonColor: ColorsManager.whatsapp,
    //                   height: SizeManager.s30,
    //                   borderRadius: SizeManager.s5,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       if(secretConsultationModel.isReplied) ...[
    //         const SizedBox(height: SizeManager.s10),
    //         Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(SizeManager.s10),
    //           decoration: BoxDecoration(
    //             color: ColorsManager.green,
    //             borderRadius: BorderRadius.circular(SizeManager.s10),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text(
    //                   Methods.getText(StringsManager.theConsultationHasBeenReplied).toCapitalized(),
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
    //     ],
    //   ),
    // );
  }
}