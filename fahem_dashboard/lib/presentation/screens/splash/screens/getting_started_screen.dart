import 'package:fahem_dashboard/presentation/screens/splash/controllers/start_provider.dart';
import 'package:fahem_dashboard/presentation/screens/splash/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:provider/provider.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  late StartProvider startProvider;

  @override
  void initState() {
    super.initState();
    startProvider = Provider.of<StartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SizeManager.s16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: MyLogo(),
                          ),
                          const SizedBox(height: SizeManager.s30),
                          Text(
                            Methods.getText(StringsManager.appName).toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.medium),
                          ),
                          const SizedBox(height: SizeManager.s15),
                          Text(
                            Methods.getText(StringsManager.slug).toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  child: CustomButton(
                    onPressed: () => Methods.routeTo(context, Routes.onBoardingScreen),
                    buttonType: ButtonType.text,
                    text: Methods.getText(StringsManager.gettingStarted).toTitleCase(),
                    width: SizeManager.s100,
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              start: -150,
              top: 150,
              child: Container(
                width: SizeManager.s200,
                height: SizeManager.s200,
                decoration: BoxDecoration(
                  color: ColorsManager.lightPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            PositionedDirectional(
              start: -120,
              bottom: 100,
              child: Container(
                width: SizeManager.s200,
                height: SizeManager.s200,
                decoration: BoxDecoration(
                  color: ColorsManager.lightPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            PositionedDirectional(
              top: -50,
              end: -100,
              child: Container(
                width: SizeManager.s200,
                height: SizeManager.s200,
                decoration: BoxDecoration(
                  color: ColorsManager.lightPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            PositionedDirectional(
              bottom: -50,
              end: -100,
              child: Container(
                width: SizeManager.s200,
                height: SizeManager.s200,
                decoration: BoxDecoration(
                  color: ColorsManager.lightPrimaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}