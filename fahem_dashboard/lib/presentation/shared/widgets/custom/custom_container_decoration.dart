import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomContainerDecoration extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? headerBackgroundColor;
  final Color? textColor;

  const CustomContainerDecoration({
    super.key,
    required this.title,
    required this.child,
    this.headerBackgroundColor = ColorsManager.lightPrimaryColor,
    this.textColor = ColorsManager.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: SizeManager.s10, horizontal: SizeManager.s15),
          decoration: BoxDecoration(
            color: headerBackgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(SizeManager.s10), topRight: Radius.circular(SizeManager.s10)),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: textColor, fontWeight: FontWeightManager.semiBold),
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: ColorsManager.grey2,
            border: Border.all(color: ColorsManager.grey300),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(SizeManager.s10),
              bottomEnd: Radius.circular(SizeManager.s10),
              topEnd: Radius.circular(SizeManager.s10),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}