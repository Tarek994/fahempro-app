import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/card_info.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const UserProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, child) {
        return Scaffold(
          // backgroundColor: ColorsManager.grey1,
          body: CustomFullLoading(
            waitForDone: authenticationProvider.isLoading,
            isShowLoading: authenticationProvider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.profile),
                SliverToBoxAdapter(
                  child: Column(
                    children: [

                      // Images
                      Container(
                        padding: const EdgeInsets.all(SizeManager.s16),
                        child: SizedBox(
                          width: double.infinity,
                          height: SizeManager.s260,
                          child: Stack(
                            children: [
                              ImageWidget(
                                image: userModel.coverImage,
                                imageDirectory: ApiConstants.usersDirectory,
                                color1: userModel.coverImage == null ? ColorsManager.grey1 : null,
                                width: double.infinity,
                                height: SizeManager.s200,
                                borderRadius: SizeManager.s10,
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
                                spacerImage: userModel.dialingCodeModel!.flag,
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

                      // Edit User
                      if(MyProviders.authenticationProvider.currentUser != null || userModel.userId == MyProviders.authenticationProvider.currentUser!.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                          child: CustomButton(
                            onPressed: () => Methods.routeTo(context, Routes.editUserProfileScreen, arguments: authenticationProvider.currentUser),
                            buttonType: ButtonType.postSpacerIcon,
                            text: Methods.getText(StringsManager.editProfile).toCapitalized(),
                            iconData: Icons.edit,
                            buttonColor: ColorsManager.lightSecondaryColor,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: SizeManager.s10),
                      ],

                      // Change Password
                      if(MyProviders.authenticationProvider.currentUser != null || userModel.userId == MyProviders.authenticationProvider.currentUser!.userId) ...[
                        if(MyProviders.authenticationProvider.currentUser != null || authenticationProvider.currentUser!.signInMethod == SignInMethod.emailAndPassword) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: CustomButton(
                              onPressed: () => Methods.routeTo(context, Routes.changePasswordScreen),
                              buttonType: ButtonType.postSpacerIcon,
                              text: Methods.getText(StringsManager.changePassword).toCapitalized(),
                              iconData: Icons.password,
                              buttonColor: ColorsManager.lightSecondaryColor,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                      ],

                      // Delete User
                      if(MyProviders.authenticationProvider.currentUser != null || userModel.userId == MyProviders.authenticationProvider.currentUser!.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                          child: CustomButton(
                            onPressed: () => Dialogs.showBottomSheetConfirmation(
                              context: context,
                              message: Methods.getText(StringsManager.doYouWantToDeleteTheAccount).toCapitalized(),
                            ).then((value) async {
                              if (value) {
                                await MyProviders.authenticationProvider.deleteUser(context);
                              }
                            }),
                            buttonType: ButtonType.postSpacerIcon,
                            text: Methods.getText(StringsManager.deleteAccount).toCapitalized(),
                            iconData: Icons.delete,
                            buttonColor: ColorsManager.red700,
                            width: double.infinity,
                            iconColor: ColorsManager.white,
                            textFontWeight: FontWeightManager.black,
                          ),
                        ),
                        const SizedBox(height: SizeManager.s10),
                      ],

                      // Logout
                      if(MyProviders.authenticationProvider.currentUser != null || userModel.userId == MyProviders.authenticationProvider.currentUser!.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                          child: CustomButton(
                            onPressed: () => Dialogs.showBottomSheetConfirmation(
                              context: context,
                              message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized(),
                            ).then((value) {
                              if(value) MyProviders.authenticationProvider.logout(context);
                            }),
                            buttonType: ButtonType.postSpacerImage,
                            text: Methods.getText(StringsManager.logout).toCapitalized(),
                            imageName: IconsManager.logout,
                            buttonColor: ColorsManager.red700,
                            width: double.infinity,
                            imageColor: ColorsManager.white,
                            textFontWeight: FontWeightManager.black,
                          ),
                        ),
                        const SizedBox(height: SizeManager.s20),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}