import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';

class CardInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final String? spacerText;
  final String? spacerImage;
  final Color? backgroundColor;
  final Widget? child;

  const CardInfo({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.spacerText,
    this.spacerImage,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.lightPrimaryColor,
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: SizeManager.s3),
                    child: Icon(icon, size: SizeManager.s14, color: ColorsManager.white),
                  ),
                  const SizedBox(width: SizeManager.s10),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, height: SizeManager.s1_8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(SizeManager.s10),
              color: backgroundColor ?? ColorsManager.white,
              child: child ?? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(value != null) Expanded(
                    child: Text(
                      value!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_8),
                    ),
                  ),
                  if(spacerText != null) ...[
                    const SizedBox(width: SizeManager.s5),
                    Padding(
                      padding: const EdgeInsets.only(top: SizeManager.s3),
                      child: Text(
                        spacerText!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                      ),
                    ),
                  ],
                  if(spacerImage != null) ...[
                    const SizedBox(width: SizeManager.s5),
                    Image.asset(spacerImage!, width: SizeManager.s30),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}