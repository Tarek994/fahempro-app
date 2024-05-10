import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';

class InfoBtmSheet extends StatelessWidget {
  final String title;
  final String body;

  const InfoBtmSheet({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomButton(
              onPressed: () => Navigator.pop(context),
              buttonType: ButtonType.icon,
              iconData: Icons.clear,
              isCircleBorder: true,
              iconSize: SizeManager.s25,
              padding: EdgeInsets.zero,
              width: SizeManager.s35,
              height: SizeManager.s35,
              buttonColor: Colors.transparent,
              iconColor: ColorsManager.black,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorsManager.lightSecondaryColor,
              fontSize: SizeManager.s24,
              fontWeight: FontWeightManager.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SizeManager.s20),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: SizeManager.s15, fontWeight: FontWeightManager.medium),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
