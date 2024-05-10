import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final String titleText;
  final Widget? trailing;
  final List<Widget> children;

  const CustomExpansionTile({
    super.key,
    required this.titleText,
    this.trailing,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeManager.s10),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            fontFamily: FontFamilyManager.montserratArabic,
          ),
          child: ExpansionTile(
            title: Text(
              titleText,
              style: const TextStyle(height: SizeManager.s1_8, fontSize: SizeManager.s14, fontWeight: FontWeightManager.semiBold),
            ),
            collapsedTextColor: ColorsManager.black,
            textColor: ColorsManager.lightPrimaryColor,
            collapsedBackgroundColor: ColorsManager.white,
            backgroundColor: ColorsManager.white,
            collapsedIconColor: ColorsManager.black,
            iconColor: ColorsManager.lightPrimaryColor,
            tilePadding: const EdgeInsets.symmetric(horizontal: SizeManager.s16, vertical: SizeManager.s4),
            childrenPadding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16, top: SizeManager.s8),
            expandedAlignment: MyProviders.appProvider.isEnglish ? Alignment.topLeft : Alignment.topRight,
            trailing: trailing,
            children: children,
          ),
        ),
      ),
    );
  }
}