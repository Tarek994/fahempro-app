import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class CustomListTile extends StatelessWidget {
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final Color? imageColor;
  final Color? boxColor;
  final Color? trailingColor;
  final Color? tileColor;
  final FontWeight? fontWeight;
  final String? image;
  final IconData? icon;
  final Widget? trailing;
  final bool isTrailingArrow;
  final bool isTrailingCount;
  final bool isTrailingLoading;
  final String? trailingText;

  const CustomListTile({
    super.key,
    this.onTap,
    this.contentPadding,
    required this.text,
    this.textColor = ColorsManager.black,
    this.iconColor = ColorsManager.lightPrimaryColor,
    this.imageColor = ColorsManager.lightPrimaryColor,
    this.boxColor = Colors.transparent,
    this.trailingColor = ColorsManager.black,
    this.tileColor = Colors.transparent,
    this.fontWeight,
    this.image,
    this.icon,
    this.trailing,
    this.isTrailingArrow = false,
    this.isTrailingCount = false,
    this.isTrailingLoading = false,
    this.trailingText,
  });

  Widget? _getTrailing(BuildContext context) {
    if(isTrailingLoading) {
      return const SizedBox(
        width: SizeManager.s20,
        height: SizeManager.s20,
        child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
      );
    }
    if(isTrailingArrow) {
      return Icon(
        Icons.arrow_forward_ios,
        color: trailingColor,
        size: SizeManager.s20,
      );
    }
    if(isTrailingCount) {
      return Container(
        padding: const EdgeInsets.all(SizeManager.s8),
        decoration: const BoxDecoration(
          color: ColorsManager.lightSecondaryColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          trailingText ?? '',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: trailingColor, fontWeight: FontWeightManager.semiBold),
        ),
      );
    }
    if(trailingText != null) {
      return Text(
        trailingText ?? '',
        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: trailingColor, fontWeight: FontWeightManager.semiBold),
      );
    }
    if(trailing != null) {
      return trailing;
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: contentPadding,
        title: Text(
          Methods.getText(text).toTitleCase(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontWeight: fontWeight),
        ),
        leading: image == null && icon == null ? null : Container(
          padding: const EdgeInsets.all(SizeManager.s8),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(SizeManager.s10),
          ),
          child: image != null ? Image.asset(
            image!,
            width: SizeManager.s20,
            height: SizeManager.s20,
            color: imageColor,
          ) : Icon(
            icon,
            size: SizeManager.s20,
            color: iconColor,
          ),
        ),
        trailing: _getTrailing(context),
        tileColor: tileColor,
      ),
    );
  }
}