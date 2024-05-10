import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';

class FailureScreen extends StatelessWidget {
  final Failure failure;

  const FailureScreen({
    super.key,
    required this.failure,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized()),
      child: Directionality(
        textDirection: Methods.getDirection(),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: SizeManager.s0,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SizeManager.s16),
              child: Column(
                children: [
                  SvgPicture.asset(SvgManager.error, width: SizeManager.s200, height: SizeManager.s300),
                  const SizedBox(height: SizeManager.s20),
                  Text(
                    MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: SizeManager.s1_8),
                  ),
                  const SizedBox(height: SizeManager.s30),
                  CustomButton(
                    onPressed: () => Methods.routeTo(context, Routes.startScreen, isPushReplacement: true),
                    buttonType: ButtonType.text,
                    text: Methods.getText(StringsManager.tryAgain).toCapitalized(),
                    width: double.infinity,
                    height: SizeManager.s40,
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