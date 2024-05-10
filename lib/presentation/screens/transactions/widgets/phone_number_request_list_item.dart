import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/data/models/phone_number_request_model.dart';

class PhoneNumberRequestListItem extends StatelessWidget {
  final PhoneNumberRequestModel phoneNumberRequestModel;

  const PhoneNumberRequestListItem({
    super.key,
    required this.phoneNumberRequestModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   if(!phoneNumberRequestModel.isViewed) {
      //     // SetIsViewedParameters parameters = SetIsViewedParameters(adminNotificationId: widget.adminNotificationModel.adminNotificationId);
      //     // DependencyInjection.setIsViewedUseCase.call(parameters).then((response) {
      //     //   response.fold((failure) {}, (isViewed) {
      //     //     widget.adminNotificationModel.isViewed = isViewed;
      //     //     setState(() {});
      //     //   });
      //     // });
      //   }
      // },
      child: Container(
        padding: const EdgeInsets.all(SizeManager.s10),
        decoration: BoxDecoration(
          color: phoneNumberRequestModel.isViewed ? ColorsManager.white : ColorsManager.lightSecondaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(SizeManager.s10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Methods.getText(StringsManager.phoneNumberRequest).toCapitalized(),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeightManager.black,
                    color: ColorsManager.green,
                  ),
                ),
                const SizedBox(width: SizeManager.s5),
                Text(
                  Methods.formatDate(milliseconds: int.parse(phoneNumberRequestModel.createdAt)),
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
                ImageWidget(
                  image: phoneNumberRequestModel.account.personalImage,
                  imageDirectory: ApiConstants.accountsDirectory,
                  defaultImage: ImagesManager.defaultAvatar,
                  width: SizeManager.s50,
                  height: SizeManager.s50,
                  boxShape: BoxShape.circle,
                  isShowFullImageScreen: false,
                ),
                const SizedBox(width: SizeManager.s10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: SizeManager.s5),
                      NameWidget(
                        fullName: phoneNumberRequestModel.account.fullName,
                        isFeatured: phoneNumberRequestModel.account.isFeatured,
                        isSupportFeatured: true,
                        verifiedColor: ColorsManager.blue,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightManager.black,
                        ),
                      ),
                      if(phoneNumberRequestModel.account.jobTitle != null) ...[
                        const SizedBox(height: SizeManager.s5),
                        Text(
                          phoneNumberRequestModel.account.jobTitle!,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeightManager.black,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
            Row(
              children: [
                // Expanded(
                //   child: CustomButton(
                //     onPressed: () {},
                //     buttonType: ButtonType.preImage,
                //     text: Methods.getText(StringsManager.returnToTransaction).toCapitalized(),
                //     imageName: IconsManager.returnToTheTransaction,
                //     buttonColor: ColorsManager.lightPrimaryColor,
                //     imageColor: ColorsManager.white,
                //     width: double.infinity,
                //     height: SizeManager.s35,
                //   ),
                // ),
                // const SizedBox(width: SizeManager.s10),
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
      ),
    );
  }
}