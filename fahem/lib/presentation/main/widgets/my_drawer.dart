import 'dart:io';

import 'package:fahem/presentation/shared/widgets/social_media_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/presentation/main/controllers/main_provider.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/main/widgets/profile_card.dart';

  class MyDrawer extends StatefulWidget {
  final AdvancedDrawerController advancedDrawerController;
  final Widget child;

  const MyDrawer({
    super.key,
    required this.advancedDrawerController,
    required this.child,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late MainProvider mainProvider;
  
  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
  }
  
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      rtlOpening: !MyProviders.appProvider.isEnglish,
      controller: widget.advancedDrawerController,
      backdropColor: ColorsManager.grey300,
      animationCurve: Curves.linear,
      animationDuration: const Duration(milliseconds: ConstantsManager.drawerAnimationDuration),
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.s15)),
      ),
      drawer: Container(
        margin: const EdgeInsetsDirectional.only(start: SizeManager.s16),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Card(
          color: ColorsManager.white,
          elevation: SizeManager.s20,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeManager.s15)),
          child: Consumer<AuthenticationProvider>(
            builder: (context, authenticationProvider, _) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(MyProviders.authenticationProvider.currentUser != null) Padding(
                            padding: const EdgeInsets.all(SizeManager.s16),
                            child: ProfileCard(
                              onTap: () {
                                widget.advancedDrawerController.hideDrawer();
                                // mainProvider.changeBottomNavigationBarPages(BottomNavigationBarPages.profile);
                              },
                            ),
                          ),
                          CustomListTile(
                            onTap: () {
                              widget.advancedDrawerController.hideDrawer();
                              mainProvider.changeBottomNavigationBarPages(context: context, page: BottomNavigationBarPages.home);
                            },
                            text: StringsManager.homePage,
                            icon: FontAwesomeIcons.house,
                          ),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.faqsScreen),
                            text: StringsManager.faqs,
                            icon: FontAwesomeIcons.solidCircleQuestion,
                          ),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.serviceDescriptionScreen),
                            text: StringsManager.serviceDescription,
                            image: IconsManager.serviceDescription,
                          ),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.aboutAppScreen),
                            text: StringsManager.aboutApp,
                            image: IconsManager.aboutApp,
                          ),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.privacyPolicyScreen),
                            text: StringsManager.privacyPolicy,
                            image: IconsManager.privacyPolicy,
                          ),
                          CustomListTile(
                            onTap: () => Methods.routeTo(context, Routes.termsOfUseScreen),
                            text: StringsManager.termsOfUse,
                            image: IconsManager.termsOfUse,
                          ),
                          CustomListTile(
                            onTap: () async {
                              if(Platform.isAndroid) {await Methods.openUrl(url: ConstantsManager.fahemPlayStoreUrl);}
                              if(Platform.isIOS) {await Methods.openUrl(url: ConstantsManager.fahemAppStoreUrl);}
                            },
                            text: StringsManager.rateApp,
                            image: IconsManager.rating,
                          ),
                          CustomListTile(
                            onTap: () {
                              if(Platform.isAndroid) {Share.share(ConstantsManager.fahemPlayStoreUrl);}
                              if(Platform.isIOS) {Share.share(ConstantsManager.fahemAppStoreUrl);}
                            },
                            text: StringsManager.shareApp,
                            icon: FontAwesomeIcons.share,
                          ),
                          CustomListTile(
                            onTap: () {
                              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToChangeTheLanguage).toCapitalized()).then((value) async {
                                if(value) {
                                  Methods.onChangeLanguage();
                                }
                              });
                            },
                            text: StringsManager.language,
                            icon: FontAwesomeIcons.globe,
                            trailingText: Methods.getText(MyProviders.appProvider.isEnglish ? StringsManager.english : StringsManager.arabic).toCapitalized(),
                          ),
                          // CustomListTile(
                          //   onTap: () {
                          //     Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToChangeTheTheme).toCapitalized()).then((value) async {
                          //       if(value) {
                          //         Methods.onChangeTheme();
                          //       }
                          //     });
                          //   },
                          //   text: StringsManager.theme,
                          //   icon: FontAwesomeIcons.circleHalfStroke,
                          //   trailingText: Methods.getText(MyProviders.appProvider.isLight ? StringsManager.light : StringsManager.dark).toCapitalized(),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: SizeManager.s0),
                  Padding(
                    padding: const EdgeInsets.all(SizeManager.s16),
                    child: Column(
                      children: [
                        Text(
                          '${Methods.getText(StringsManager.appVersion).toTitleCase()} ${MyProviders.appProvider.version}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: SizeManager.s15),
                        const SocialMediaIcons(),
                        const SizedBox(height: SizeManager.s15),
                        CustomButton(
                          buttonType: ButtonType.postIcon,
                          onPressed: () {
                            if(MyProviders.authenticationProvider.currentUser == null) {
                              Methods.routeTo(context, Routes.loginWithPhoneScreen);
                            }
                            else {
                              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized()).then((value) async {
                                if(value) {
                                  MyProviders.authenticationProvider.logout(context);
                                }
                              });
                            }
                          },
                          buttonColor: MyProviders.authenticationProvider.currentUser == null ? ColorsManager.lightPrimaryColor: ColorsManager.red,
                          width: double.infinity,
                          height: SizeManager.s35,
                          borderRadius: SizeManager.s15,
                          text: Methods.getText(MyProviders.authenticationProvider.currentUser == null ? StringsManager.login : StringsManager.logout).toTitleCase(),
                          iconData: MyProviders.authenticationProvider.currentUser == null ? FontAwesomeIcons.arrowRightToBracket : FontAwesomeIcons.arrowRightFromBracket,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      child: widget.child,
    );
  }
}