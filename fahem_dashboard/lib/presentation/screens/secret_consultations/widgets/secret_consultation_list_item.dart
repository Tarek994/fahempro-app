import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/presentation/btm_sheets/info_btn_sheet.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecretConsultationListItem extends StatelessWidget {
  final SecretConsultationModel secretConsultationModel;
  final Function onEdit;
  final Function onDelete;

  const SecretConsultationListItem({
    super.key,
    required this.secretConsultationModel,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DateWidget(createdAt: secretConsultationModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editSecretConsultation) || Methods.checkAdminPermission(AdminPermissions.deleteSecretConsultation)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    if(Methods.checkAdminPermission(AdminPermissions.editSecretConsultation)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteSecretConsultation)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditSecretConsultationScreen, arguments: secretConsultationModel, then: (secretConsultation) => onEdit(secretConsultation)),
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
          Hover(
            onTap: () {
              Dialogs.showBottomSheet(
                context: context,
                child: InfoBtmSheet(
                  title: '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
                  body: secretConsultationModel.consultation,
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
                    '${Methods.getText(StringsManager.consultationId)} #${secretConsultationModel.secretConsultationId}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    secretConsultationModel.consultation,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          if(secretConsultationModel.images.isNotEmpty) ...[
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: SizeManager.s10,
                runSpacing: SizeManager.s10,
                children: List.generate(secretConsultationModel.images.length, (index) => ImageWidget(
                  image: secretConsultationModel.images[index],
                  imageDirectory: ApiConstants.secretConsultationsDirectory,
                  width: SizeManager.s70,
                  height: SizeManager.s70,
                  borderRadius: SizeManager.s10,
                  isShowFullImageScreen: true,
                )),
              ),
            ),
            const SizedBox(height: SizeManager.s10),
          ],
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
                  Methods.getText(StringsManager.replyToTheConsultationThrough).toCapitalized(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: SizeManager.s10),
                Row(
                  children: [
                    Text(
                      SecretConsultationReplyType.toText(secretConsultationModel.secretConsultationReplyType),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.call) CustomButton(
                      onPressed: () async {
                        await Methods.openUrl(url: 'tel:${secretConsultationModel.replyTypeValue}');
                      },
                      buttonType: ButtonType.preIcon,
                      text: secretConsultationModel.replyTypeValue,
                      iconData: FontAwesomeIcons.phone,
                      buttonColor: ColorsManager.blue,
                      height: SizeManager.s30,
                      borderRadius: SizeManager.s5,
                    ),
                    if(secretConsultationModel.secretConsultationReplyType == SecretConsultationReplyType.whatsapp) CustomButton(
                      onPressed: () async {
                        await Methods.openUrl(url: 'https://wa.me/+2${secretConsultationModel.replyTypeValue}');
                      },
                      buttonType: ButtonType.preIcon,
                      text: secretConsultationModel.replyTypeValue,
                      iconData: FontAwesomeIcons.whatsapp,
                      buttonColor: ColorsManager.whatsapp,
                      height: SizeManager.s30,
                      borderRadius: SizeManager.s5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserRowWidget(user: secretConsultationModel.user),
            ],
          ),
          if(secretConsultationModel.isReplied) ...[
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
                      Methods.getText(StringsManager.theConsultationHasBeenReplied).toCapitalized(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: SizeManager.s10),
                  const Icon(Icons.check, color: ColorsManager.white, size: SizeManager.s18),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}