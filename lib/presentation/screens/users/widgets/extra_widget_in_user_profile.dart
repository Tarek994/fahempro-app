import 'package:provider/provider.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/presentation/screens/users/controllers/user_profile_provider.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/card_info.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';

class ExtraWidgetInUserProfile extends StatelessWidget {
  final UserModel userModel;

  const ExtraWidgetInUserProfile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Images
        SizedBox(
          width: double.infinity,
          height: SizeManager.s260,
          child: Stack(
            children: [
              ImageWidget(
                image: userModel.coverImage,
                imageDirectory: ApiConstants.usersDirectory,
                color1: userModel.coverImage == null ? ColorsManager.white : null,
                width: double.infinity,
                height: SizeManager.s200,
                isShowFullImageScreen: true,
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                  child: ImageWidget(
                    image: userModel.personalImage,
                    imageDirectory: ApiConstants.usersDirectory,
                    defaultImage: ImagesManager.defaultAvatar,
                    width: SizeManager.s120,
                    height: SizeManager.s120,
                    boxShape: BoxShape.circle,
                    isBorderAroundImage: true,
                    isShowFullImageScreen: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SizeManager.s20),

        // Name
        NameWidget(
          fullName: userModel.fullName,
          isFeatured: userModel.isFeatured,
          isSupportFeatured: true,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: SizeManager.s20),

        // Info
        Padding(
          padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
          child: Column(
            children: [
              if(userModel.phoneNumber != null) ...[
                CardInfo(
                  icon: FontAwesomeIcons.phone,
                  title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                  value: userModel.phoneNumber,
                  spacerText: userModel.dialingCode,
                ),
                const SizedBox(height: SizeManager.s10),
              ],
              if(userModel.country != null) ...[
                CardInfo(
                  icon: FontAwesomeIcons.locationDot,
                  title: Methods.getText(StringsManager.country).toTitleCase(),
                  value: MyProviders.appProvider.isEnglish ? userModel.country!.countryNameEn : userModel.country!.countryNameAr,
                  spacerImage: userModel.country!.flag,
                ),
                const SizedBox(height: SizeManager.s10),
              ],
              if(userModel.birthDate != null) ...[
                CardInfo(
                  icon: FontAwesomeIcons.calendar,
                  title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                  value: Methods.formatDate(milliseconds: int.parse(userModel.birthDate!), format: 'd MMMM yyyy'),
                ),
                const SizedBox(height: SizeManager.s10),
              ],
              if(userModel.gender != null) ...[
                CardInfo(
                  icon: FontAwesomeIcons.venusMars,
                  title: Methods.getText(StringsManager.gender).toTitleCase(),
                  value: Gender.toText(userModel.gender!),
                ),
                const SizedBox(height: SizeManager.s10),
              ],
              CardInfo(
                icon: FontAwesomeIcons.calendar,
                title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                value: Methods.formatDate(milliseconds: int.parse(userModel.createdAt), format: 'd MMMM yyyy'),
              ),
              const SizedBox(height: SizeManager.s10),
              if(userModel.bio != null) ...[
                CardInfo(
                  icon: FontAwesomeIcons.info,
                  title: Methods.getText(StringsManager.bio).toTitleCase(),
                  value: userModel.bio ?? Methods.getText(StringsManager.notFound).toTitleCase(),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: SizeManager.s20),

        Align(
          // alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
            child: Text(
              Methods.getText(StringsManager.ads).toCapitalized(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.bold),
            ),
          ),
        ),
        const SizedBox(height: SizeManager.s20),

        Consumer<UserProfileProvider>(
          builder: (context, userProfileProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if(userProfileProvider.currentUserProfilePage == UserProfilePages.userJobs) return;
                        userProfileProvider.setCurrentUserProfilePage(UserProfilePages.userJobs);
                        userProfileProvider.reFetchUserJobs(userId: userModel.userId);
                      },
                      buttonType: ButtonType.text,
                      text: Methods.getText(StringsManager.jobs).toCapitalized(),
                      width: double.infinity,
                      borderRadius: SizeManager.s0,
                      buttonColor: userProfileProvider.currentUserProfilePage == UserProfilePages.userJobs ? ColorsManager.lightPrimaryColor : ColorsManager.white,
                      textColor: userProfileProvider.currentUserProfilePage == UserProfilePages.userJobs ? ColorsManager.white : ColorsManager.black,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if(userProfileProvider.currentUserProfilePage == UserProfilePages.userSeekers) return;
                        userProfileProvider.setCurrentUserProfilePage(UserProfilePages.userSeekers);
                        // userProfileProvider.reFetchUserSeekers(userId: userModel.userId);
                      },
                      buttonType: ButtonType.text,
                      text: Methods.getText(StringsManager.theSearch).toCapitalized(),
                      width: double.infinity,
                      borderRadius: SizeManager.s0,
                      buttonColor: userProfileProvider.currentUserProfilePage == UserProfilePages.userSeekers ? ColorsManager.lightPrimaryColor : ColorsManager.white,
                      textColor: userProfileProvider.currentUserProfilePage == UserProfilePages.userSeekers ? ColorsManager.white : ColorsManager.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
