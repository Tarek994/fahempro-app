import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';

class MyBackButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? iconColor;
  final double? width;
  final double? height;
  final Function()? onPressed;

  const MyBackButton({
    super.key,
    this.buttonColor = ColorsManager.black,
    this.iconColor = ColorsManager.white,
    this.width,
    this.height,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          buttonType: ButtonType.icon,
          onPressed: onPressed ?? () => Navigator.pop(context),
          iconData: Icons.arrow_back_ios_sharp,
          isCircleBorder: true,
          width: width,
          height: height,
          iconSize: SizeManager.s20,
          buttonColor: buttonColor!,
          iconColor: iconColor!,
        ),
      ],
    );
  }
}