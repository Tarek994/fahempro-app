import 'dart:io';

import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/main/controllers/main_provider.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/controllers/app_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_list_tile.dart';
import 'package:fahem/presentation/shared/widgets/social_media_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MenuScreen extends StatelessWidget {

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, _) {
          return Consumer<AppProvider>(
            builder: (context, appProvider, _) {
              return CustomFullLoading(
                isShowLoading: authenticationProvider.isLoading,
                waitForDone: authenticationProvider.isLoading,
                isShowOpacityBackground: true,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          CustomListTile(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.userProfileScreen,
                              arguments: MyProviders.authenticationProvider.currentUser,
                              isMustLogin: true,
                            ),
                            text: StringsManager.profile,
                            image: IconsManager.profile,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () {
                              Provider.of<MainProvider>(context, listen: false).changeBottomNavigationBarPages(context: context, page: BottomNavigationBarPages.transactions);
                            },
                            text: StringsManager.myTransactions,
                            image: IconsManager.transaction,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.playlistsScreen),
                            text: StringsManager.videos,
                            image: IconsManager.playlists,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () => Provider.of<MainProvider>(context, listen: false).changeBottomNavigationBarPages(context: context, page: BottomNavigationBarPages.wallet),
                            text: StringsManager.wallet,
                            image: IconsManager.wallet,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.jobsScreen),
                            text: StringsManager.jobs,
                            image: IconsManager.jobs,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.chatRoomRoute,
                              isMustLogin: true,
                            ),
                            text: StringsManager.help,
                            image: IconsManager.help,
                            // isTrailingArrow: true,
                            trailing: Image.asset(IconsManager.arrowCircleLeft, width: SizeManager.s32, height: SizeManager.s32),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () => Methods.onChangeLanguage(),
                            text: StringsManager.language,
                            image: IconsManager.language,
                            trailingText: Methods.getText(MyProviders.appProvider.isEnglish ? StringsManager.english : StringsManager.arabic).toCapitalized(),
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () async {
                              if(Platform.isAndroid) {await Methods.openUrl(url: ConstantsManager.fahemPlayStoreUrl);}
                              if(Platform.isIOS) {await Methods.openUrl(url: ConstantsManager.fahemAppStoreUrl);}
                            },
                            text: StringsManager.rateApp,
                            image: IconsManager.rating,
                          ),
                          const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                          CustomListTile(
                            onTap: () {
                              if(Platform.isAndroid) {Share.share(ConstantsManager.fahemPlayStoreUrl);}
                              if(Platform.isIOS) {Share.share(ConstantsManager.fahemAppStoreUrl);}
                            },
                            text: StringsManager.shareApp,
                            icon: FontAwesomeIcons.share,
                          ),
                          if(MyProviders.authenticationProvider.currentUser != null) ...[
                            const Divider(height: SizeManager.s0, color: ColorsManager.grey, indent: SizeManager.s16, endIndent: SizeManager.s16),
                            CustomListTile(
                              onTap: () {
                                Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized()).then((value) {
                                  if(value) MyProviders.authenticationProvider.logout(context);
                                });
                              },
                              text: StringsManager.logout,
                              image: IconsManager.logout,
                              textColor: ColorsManager.red700,
                              imageColor: ColorsManager.red700,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ],
                          const SizedBox(height: SizeManager.s16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: CustomButton(
                              onPressed: () {
                                if(Platform.isAndroid) {Methods.openUrl(url: ConstantsManager.fahemBusinessPlayStoreUrl);}
                                if(Platform.isIOS) {Methods.openUrl(url: ConstantsManager.fahemAppStoreUrl);}
                              },
                              buttonType: ButtonType.preImage,
                              text: Methods.getText(StringsManager.registerInFahemBusiness).toTitleCase(),
                              imageName: ImagesManager.logo,
                              imageColor: ColorsManager.white,
                              width: double.infinity,
                              height: SizeManager.s35,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(SizeManager.s16),
                            child: Column(
                              children: [
                                const SocialMediaIcons(),
                                const SizedBox(height: SizeManager.s15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        buttonType: ButtonType.text,
                                        onPressed: () => Methods.routeTo(context, Routes.termsOfUseScreen),
                                        text: Methods.getText(StringsManager.termsOfUse).toTitleCase(),
                                        buttonColor: Colors.transparent,
                                        textColor: ColorsManager.black,
                                        width: double.infinity,
                                        height: SizeManager.s35,
                                      ),
                                    ),
                                    const SizedBox(height: SizeManager.s10),
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () => Methods.routeTo(context, Routes.privacyPolicyScreen),
                                        buttonType: ButtonType.text,
                                        text: Methods.getText(StringsManager.privacyPolicy).toTitleCase(),
                                        buttonColor: Colors.transparent,
                                        textColor: ColorsManager.black,
                                        width: double.infinity,
                                        height: SizeManager.s35,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SizeManager.s15),
                                Text(
                                  '${Methods.getText(StringsManager.appVersion).toTitleCase()} ${MyProviders.appProvider.version}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}