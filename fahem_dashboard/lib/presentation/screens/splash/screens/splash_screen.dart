import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/presentation/screens/splash/controllers/splash_provider.dart';
import 'package:fahem_dashboard/presentation/screens/splash/widgets/my_logo.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/screens/splash/widgets/splash_loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider splashProvider;

  @override
  void initState() {
    super.initState();
    splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized()),
      child: Directionality(
        textDirection: Methods.getDirection(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(SizeManager.s16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Methods.getText(StringsManager.appName).toTitleCase(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.semiBold),
                  ),
                  const SizedBox(height: SizeManager.s100),
                  const Flexible(
                    child: MyLogo(),
                  ),
                  const SizedBox(height: SizeManager.s40),
                  SizedBox(
                    width: SizeManager.s100,
                    height: SizeManager.s40,
                    child: Selector<SplashProvider, bool>(
                      selector: (context, provider) => provider.isErrorOccurred,
                      builder: (context, isErrorOccurred, child) {
                        return isErrorOccurred ? IconButton(
                          onPressed: () async => await splashProvider.onPressedTryAgain(context),
                          padding: EdgeInsets.zero,
                          color: ColorsManager.red700,
                          iconSize: SizeManager.s30,
                          icon: const Icon(Icons.refresh),
                        ) : const SplashLoadingWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}