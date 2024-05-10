import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/widgets/card_info.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class AccountProfileScreen extends StatelessWidget {
  final AccountModel accountModel;

  const AccountProfileScreen({
    super.key,
    required this.accountModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, child) {
        return Scaffold(
          body: CustomFullLoading(
            waitForDone: authenticationProvider.isLoading,
            isShowLoading: authenticationProvider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(customTitle: accountModel.fullName),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Images
                      SizedBox(
                        width: double.infinity,
                        height: SizeManager.s260,
                        child: Stack(
                          children: [
                            ImageWidget(
                              image: accountModel.coverImage,
                              imageDirectory: ApiConstants.accountsDirectory,
                              color1: accountModel.coverImage == null ? ColorsManager.white : null,
                              width: double.infinity,
                              height: SizeManager.s200,
                              isShowFullImageScreen: true,
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                                child: ImageWidget(
                                  image: accountModel.personalImage,
                                  imageDirectory: ApiConstants.accountsDirectory,
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
                        fullName: accountModel.fullName,
                        isFeatured: accountModel.isFeatured,
                        isSupportFeatured: true,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: SizeManager.s20),

                      // Edit Account
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                        child: CustomButton(
                          onPressed: () => Methods.routeTo(context, Routes.editAccountProfileScreen, arguments: authenticationProvider.currentAccount),
                          buttonType: ButtonType.postSpacerIcon,
                          text: Methods.getText(StringsManager.editProfile).toCapitalized(),
                          iconData: Icons.edit,
                          buttonColor: ColorsManager.lightSecondaryColor,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: SizeManager.s10),

                      // Change Password
                      if(authenticationProvider.currentAccount.signInMethod == SignInMethod.emailAndPassword) ...[
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

                      // Delete Account
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                        child: CustomButton(
                          onPressed: () => Dialogs.showBottomSheetConfirmation(
                            context: context,
                            message: Methods.getText(StringsManager.doYouWantToDeleteTheAccount).toCapitalized(),
                          ).then((value) async {
                            if (value) {
                              await MyProviders.authenticationProvider.deleteAccount(context);
                            }
                          }),
                          buttonType: ButtonType.postSpacerIcon,
                          text: Methods.getText(StringsManager.deleteAccount).toCapitalized(),
                          iconData: Icons.delete,
                          buttonColor: ColorsManager.lightSecondaryColor,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: SizeManager.s10),

                      // Logout
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
                          buttonColor: ColorsManager.lightSecondaryColor,
                          width: double.infinity,
                          imageColor: ColorsManager.white,
                        ),
                      ),
                      const SizedBox(height: SizeManager.s20),

                      // Info
                      Padding(
                        padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
                        child: Column(
                          children: [
                            CardInfo(
                              icon: FontAwesomeIcons.envelope,
                              title: Methods.getText(StringsManager.emailAddress).toTitleCase(),
                              value: accountModel.emailAddress,
                            ),
                            const SizedBox(height: SizeManager.s10),
                            if(accountModel.governorate != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.locationDot,
                                title: Methods.getText(StringsManager.governorate).toTitleCase(),
                                value: MyProviders.appProvider.isEnglish ? accountModel.governorate!.governorateNameEn : accountModel.governorate!.governorateNameAr,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.address != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.locationDot,
                                title: Methods.getText(StringsManager.address).toTitleCase(),
                                value: accountModel.address,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.phoneNumber != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.phone,
                                title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                                value: accountModel.phoneNumber,
                                spacerImage: FlagsImagesManager.egyptFlag,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.birthDate != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.calendar,
                                title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                                value: Methods.formatDate(milliseconds: int.parse(accountModel.birthDate!), format: 'd MMMM yyyy'),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.gender != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.venusMars,
                                title: Methods.getText(StringsManager.gender).toTitleCase(),
                                value: Gender.toText(accountModel.gender!),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.jobTitle != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.briefcase,
                                title: Methods.getText(StringsManager.jobTitle).toTitleCase(),
                                value: accountModel.jobTitle,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.categories.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.layerGroup,
                                title: Methods.getText(StringsManager.categories).toTitleCase(),
                                value: accountModel.categories.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if (accountModel.services.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.layerGroup,
                                title: Methods.getText(StringsManager.fahemServices).toTitleCase(),
                                value: accountModel.services.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.consultationPrice != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.coins,
                                title: Methods.getText(StringsManager.consultationPrice).toTitleCase(),
                                value: '${accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.tasks.isNotEmpty) ...[
                              CardInfo(
                                icon: Icons.task_alt,
                                title: Methods.getText(StringsManager.tasks).toTitleCase(),
                                value: accountModel.tasks.map((e) => e).toList().join(' - '),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.features.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.circleCheck,
                                title: Methods.getText(StringsManager.features).toTitleCase(),
                                value: accountModel.features.map((e) => e).toList().join(' - '),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            CardInfo(
                              icon: FontAwesomeIcons.coins,
                              title: Methods.getText(StringsManager.accountBalance).toTitleCase(),
                              value: '${accountModel.balance} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                            ),
                            const SizedBox(height: SizeManager.s10),
                            CardInfo(
                              icon: FontAwesomeIcons.gear,
                              title: Methods.getText(StringsManager.accountStatus).toTitleCase(),
                              value: AccountStatus.toText(accountModel.accountStatus),
                            ),
                            const SizedBox(height: SizeManager.s10),
                            if(accountModel.reasonOfReject != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.squareXmark,
                                title: Methods.getText(StringsManager.reasonOfReject).toTitleCase(),
                                value: accountModel.reasonOfReject,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.appointmentBooking.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.clock,
                                title: Methods.getText(StringsManager.bookingPeriods).toTitleCase(),
                                value: accountModel.appointmentBooking.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            CardInfo(
                              icon: FontAwesomeIcons.userCheck,
                              title: Methods.getText(StringsManager.theAccountIsVerified).toTitleCase(),
                              value: Methods.getText(accountModel.isFeatured ? StringsManager.yes : StringsManager.no).toCapitalized(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Methods.getText(accountModel.isFeatured ? StringsManager.yes : StringsManager.no).toCapitalized(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_8),
                                  ),
                                  const SizedBox(width: SizeManager.s10),
                                  Icon(
                                    accountModel.isFeatured ? Icons.check_circle : FontAwesomeIcons.xmark,
                                    color: accountModel.isFeatured ? ColorsManager.green : ColorsManager.red,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: SizeManager.s10),
                            CardInfo(
                              icon: FontAwesomeIcons.calendar,
                              title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                              value: Methods.formatDate(milliseconds: int.parse(accountModel.createdAt), format: 'd MMMM yyyy'),
                            ),
                            const SizedBox(height: SizeManager.s10),
                            if(accountModel.bio != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.info,
                                title: Methods.getText(StringsManager.bio).toTitleCase(),
                                value: accountModel.bio,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.photoGallery.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.images,
                                title: Methods.getText(StringsManager.photoGallery).toTitleCase(),
                                child: Wrap(
                                  spacing: SizeManager.s10,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(accountModel.photoGallery.length, (index) => ImageWidget(
                                    image: accountModel.photoGallery[index],
                                    imageDirectory: ApiConstants.accountsGalleryDirectory,
                                    width: SizeManager.s70,
                                    height: SizeManager.s70,
                                    borderRadius: SizeManager.s10,
                                    isShowFullImageScreen: true,
                                  )),
                                ),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.identificationImages.isNotEmpty) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.images,
                                title: Methods.getText(StringsManager.proofOfIdentity).toTitleCase(),
                                child: Wrap(
                                  spacing: SizeManager.s10,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(accountModel.identificationImages.length, (index) => ImageWidget(
                                    image: accountModel.identificationImages[index],
                                    imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                    width: SizeManager.s70,
                                    height: SizeManager.s70,
                                    borderRadius: SizeManager.s10,
                                    isShowFullImageScreen: true,
                                  )),
                                ),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.nationalId != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.idCard,
                                title: Methods.getText(StringsManager.nationalId).toTitleCase(),
                                value: accountModel.nationalId,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.nationalImageFrontSide != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.idCard,
                                title: Methods.getText(StringsManager.nationalImage).toTitleCase(),
                                child: ImageWidget(
                                  image: accountModel.nationalImageFrontSide,
                                  imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                  width: double.infinity,
                                  height: SizeManager.s120,
                                  borderRadius: SizeManager.s10,
                                  isShowFullImageScreen: true,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.nationalImageBackSide != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.idCard,
                                title: Methods.getText(StringsManager.nationalImage).toTitleCase(),
                                child: ImageWidget(
                                  image: accountModel.nationalImageBackSide,
                                  imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                  width: double.infinity,
                                  height: SizeManager.s120,
                                  borderRadius: SizeManager.s10,
                                  isShowFullImageScreen: true,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.cardNumber != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.idCardClip,
                                title: Methods.getText(StringsManager.cardNumber).toTitleCase(),
                                value: accountModel.cardNumber,
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                            if(accountModel.cardImage != null) ...[
                              CardInfo(
                                icon: FontAwesomeIcons.idCardClip,
                                title: Methods.getText(StringsManager.cardImage).toTitleCase(),
                                child: ImageWidget(
                                  image: accountModel.cardImage,
                                  imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                  width: double.infinity,
                                  height: SizeManager.s120,
                                  borderRadius: SizeManager.s10,
                                  isShowFullImageScreen: true,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s10),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // return Consumer<AuthenticationProvider>(
    //   builder: (context, authenticationProvider, _) {
    //     return Scaffold(
    //       body: CustomFullLoading(
    //         child: CustomScrollView(
    //           physics: const AlwaysScrollableScrollPhysics(),
    //           slivers: [
    //             SliverToBoxAdapter(
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     padding: const EdgeInsets.all(SizeManager.s16),
    //                     decoration: BoxDecoration(
    //                       color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
    //                       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(SizeManager.s30), bottomRight: Radius.circular(SizeManager.s30)),
    //                     ),
    //                     child: Row(
    //                       children: [
    //                         ImageWidget(
    //                           image: authenticationProvider.currentAccount.personalImage,
    //                           imageDirectory: ApiConstants.accountsDirectory,
    //                           defaultImage: ImagesManager.defaultAvatar,
    //                           width: SizeManager.s100,
    //                           height: SizeManager.s100,
    //                           boxShape: BoxShape.circle,
    //                           isShowFullImageScreen: true,
    //                         ),
    //                         Expanded(
    //                           child: Column(
    //                             children: [
    //                               NameWidget(
    //                                 fullName: authenticationProvider.currentAccount.fullName,
    //                                 isFeatured: authenticationProvider.currentAccount.isFeatured,
    //                                 isSupportFeatured: true,
    //                                 isOverflow: true,
    //                                 style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.semiBold),
    //                               ),
    //                               const SizedBox(height: SizeManager.s10),
    //                               Text(
    //                                 authenticationProvider.currentAccount.emailAddress,
    //                                 style: Theme.of(context).textTheme.bodyMedium,
    //                               ),
    //                               const SizedBox(height: SizeManager.s20),
    //                               Row(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   CustomButton(
    //                                     onPressed: () => Navigator.pushNamed(context, Routes.editAccountProfileScreen),
    //                                     buttonType: ButtonType.postIcon,
    //                                     text: Methods.getText(StringsManager.modifyTheAccount).toTitleCase(),
    //                                     iconData: Icons.edit,
    //                                     width: SizeManager.s150,
    //                                     buttonColor: ColorsManager.lightPrimaryColor,
    //                                     borderRadius: SizeManager.s5,
    //                                     height: SizeManager.s40,
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s10),
    //
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                       color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
    //                       borderRadius: BorderRadius.circular(SizeManager.s20),
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         CustomListTile(
    //                           onTap: () => Methods.routeTo(context, Routes.myJobsScreen, isMustLogin: true),
    //                           text: StringsManager.myJobs,
    //                           isTrailingArrow: true,
    //                         ),
    //                         CustomListTile(
    //                           onTap: () => Methods.routeTo(context, Routes.mySeekersScreen, isMustLogin: true),
    //                           text: StringsManager.mySeekers,
    //                           isTrailingArrow: true,
    //                         ),
    //                         CustomListTile(
    //                           onTap: () => Methods.routeTo(context, Routes.notificationsScreen, isMustLogin: true),
    //                           text: StringsManager.notifications,
    //                           isTrailingArrow: true,
    //                         ),
    //                         CustomListTile(
    //                           onTap: () => Methods.routeTo(context, Routes.favoritesScreen, isMustLogin: true),
    //                           text: StringsManager.favorites,
    //                           isTrailingArrow: true,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s10),
    //
    //                   // Share App
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                     child: CustomButton(
    //                       onPressed: () => Share.share(ConstantsManager.playStoreUrl),
    //                       buttonType: ButtonType.postSpacerText,
    //                       text: Methods.getText(StringsManager.shareTheApp).toCapitalized(),
    //                       buttonColor: ColorsManager.white,
    //                       textColor: ColorsManager.black,
    //                       fontSize: SizeManager.s14,
    //                       width: double.infinity,
    //                       height: SizeManager.s55,
    //                       borderRadius: SizeManager.s20,
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s10),
    //
    //                   // Social Media
    //                   if(phoneNumberInSocial != null || whatsappInSocial != null) ...[
    //                     Container(
    //                       margin: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                       padding: const EdgeInsets.all(SizeManager.s16),
    //                       width: double.infinity,
    //                       decoration: BoxDecoration(
    //                         color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
    //                         borderRadius: BorderRadius.circular(SizeManager.s20),
    //                       ),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             Methods.getText(StringsManager.doYouNeedHelp).toCapitalized(),
    //                             style: Theme.of(context).textTheme.bodyMedium,
    //                           ),
    //                           const SizedBox(height: SizeManager.s5),
    //                           Text(
    //                             Methods.getText(StringsManager.contactUsAndDoNotHesitate).toCapitalized(),
    //                             style: Theme.of(context).textTheme.bodySmall,
    //                           ),
    //                           const SizedBox(height: SizeManager.s20),
    //                           if(phoneNumberInSocial != null) ...[
    //                             CustomButton(
    //                               onPressed: () => Methods.openUrl(url: phoneNumberInSocial.link),
    //                               buttonType: ButtonType.postSpacerIcon,
    //                               text: Methods.getText(StringsManager.callUs).toCapitalized(),
    //                               iconData: Icons.arrow_forward_ios,
    //                               iconColor: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
    //                               borderRadius: SizeManager.s10,
    //                               borderColor: ColorsManager.lightPrimaryColor,
    //                               buttonColor: Colors.transparent,
    //                               textColor: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
    //                             ),
    //                             const SizedBox(height: SizeManager.s10),
    //                           ],
    //                           if(whatsappInSocial != null) CustomButton(
    //                             onPressed: () => Methods.openUrl(url: whatsappInSocial.link),
    //                             text: Methods.getText(StringsManager.whatsApp).toCapitalized(),
    //                             buttonType: ButtonType.postSpacerIcon,
    //                             iconData: Icons.arrow_forward_ios,
    //                             iconColor: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
    //                             borderRadius: SizeManager.s10,
    //                             borderColor: ColorsManager.lightPrimaryColor,
    //                             buttonColor: Colors.transparent,
    //                             textColor: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(height: SizeManager.s10),
    //                   ],
    //
    //                   // Social Media
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                     padding: const EdgeInsets.all(SizeManager.s16),
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                       color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
    //                       borderRadius: BorderRadius.circular(SizeManager.s20),
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Padding(
    //                               padding: const EdgeInsets.only(top: SizeManager.s5),
    //                               child: Text(
    //                                 Methods.getText(StringsManager.followUsOn).toCapitalized(),
    //                                 style: Theme.of(context).textTheme.bodyMedium,
    //                               ),
    //                             ),
    //                             const Spacer(),
    //                             const Expanded(
    //                               child: SocialMediaIcons(
    //                                 ignoreEmail: true,
    //                                 ignorePhone: true,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s10),
    //
    //                   // Change Password & Delete Account
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                       color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
    //                       borderRadius: BorderRadius.circular(SizeManager.s20),
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         if(authenticationProvider.currentAccount == null || (authenticationProvider.currentAccount != null && authenticationProvider.currentAccount.signInMethod == SignInMethod.emailAndPassword)) CustomListTile(
    //                           onTap: () => Methods.routeTo(context, Routes.changePasswordScreen),
    //                           text: StringsManager.changePassword,
    //                           isTrailingArrow: true,
    //                         ),
    //                         CustomListTile(
    //                           onTap: () {
    //                             Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToDeleteTheAccount).toCapitalized()).then((value) async {
    //                               if (value) {
    //                                 await MyProviders.authenticationProvider.deleteAccount(context);
    //                               }
    //                             });
    //                           },
    //                           text: StringsManager.deleteAccount,
    //                           textColor: ColorsManager.red700,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s10),
    //
    //                   // Logout
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
    //                     child: CustomButton(
    //                       onPressed: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized()).then((value) {
    //                         if(value) MyProviders.authenticationProvider.logout(context);
    //                       }),
    //                       buttonType: ButtonType.postSpacerImage,
    //                       text: Methods.getText(StringsManager.logout).toCapitalized(),
    //                       imageName: IconsManager.logout,
    //                       buttonColor: ColorsManager.white,
    //                       textColor: ColorsManager.red700,
    //                       imageColor: ColorsManager.red700,
    //                       textFontWeight: FontWeightManager.semiBold,
    //                       fontSize: SizeManager.s14,
    //                       imageSize: SizeManager.s25,
    //                       width: double.infinity,
    //                       height: SizeManager.s55,
    //                       borderRadius: SizeManager.s20,
    //                     ),
    //                   ),
    //                   const SizedBox(height: SizeManager.s20),
    //
    //                   // Version
    //                   Text(
    //                     '${Methods.getText(StringsManager.wazfneeApp)} ${MyProviders.appProvider.version}'.toUpperCase(),
    //                     style: Theme.of(context).textTheme.bodySmall,
    //                   ),
    //                   const SizedBox(height: SizeManager.s32),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}