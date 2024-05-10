import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/presentation/screens/splash/controllers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/controllers/app_provider.dart';
import 'package:fahem_business/presentation/screens/splash/controllers/language_provider.dart';
import 'package:fahem_business/presentation/screens/splash/widgets/language_item.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';

class LanguageScreen extends StatefulWidget {

  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late LanguageProvider languageProvider;
  late StartProvider startProvider;

  @override
  void initState() {
    super.initState();
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    startProvider = Provider.of<StartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return WillPopScope(
          onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized()),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: SizeManager.s0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(SizeManager.s32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Methods.getText(StringsManager.selectLanguage).toTitleCase(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: SizeManager.s20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: LanguageItem(image: FlagsImagesManager.unitedStatesFlag, text: StringsManager.english, language: true)),
                        SizedBox(width: SizeManager.s10),
                        Flexible(child: LanguageItem(image: FlagsImagesManager.egyptFlag, text: StringsManager.arabic, language: false)),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s40),
                    CustomButton(
                      onPressed: () async => await languageProvider.saveLanguage(context, provider.isEnglish, startProvider),
                      buttonType: ButtonType.text,
                      width: double.infinity,
                      height: SizeManager.s40,
                      text: Methods.getText(StringsManager.continueText).toUpperCase(),
                    ),
                    const SizedBox(height: SizeManager.s10),
                    Text(
                      Methods.getText(StringsManager.youCanChangeLanguageAnytime).toCapitalized(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}