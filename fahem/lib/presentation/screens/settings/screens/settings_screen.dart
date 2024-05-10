import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/shared/controllers/app_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    DefaultSliverAppBar(title: StringsManager.settings), // Remove const To Change Language
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          if(false) CustomListTile(
                            onTap: () => Navigator.pushNamed(context, Routes.versionScreen, arguments: App.fahem),
                            text: StringsManager.fahemVersionApp,
                            icon: FontAwesomeIcons.circleInfo,
                            isTrailingArrow: true,
                          ),
                          CustomListTile(
                            onTap: () => Methods.onChangeLanguage(),
                            text: StringsManager.language,
                            icon: FontAwesomeIcons.globe,
                            trailingText: Methods.getText(MyProviders.appProvider.isEnglish ? StringsManager.english : StringsManager.arabic).toCapitalized(),
                          ),
                          CustomListTile(
                            onTap: () {
                              Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized()).then((value) {
                                if(value) MyProviders.authenticationProvider.logout(context);
                              });
                            },
                            text: StringsManager.logout,
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            textColor: ColorsManager.red,
                            iconColor: ColorsManager.red,
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