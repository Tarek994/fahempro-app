import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';

class MyErrorWidget extends StatelessWidget {
  final Function()? onPressed;

  const MyErrorWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        buttonType: ButtonType.text,
        onPressed: onPressed,
        text: Methods.getText(StringsManager.anErrorOccurredClickHereToTryAgain).toCapitalized(),
        height: SizeManager.s40,
        buttonColor: Colors.transparent,
        textColor: ColorsManager.red700,
      ),
    );
  }
}