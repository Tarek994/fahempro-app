import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';

class NameWidget extends StatelessWidget {
  final String fullName;
  final TextStyle? style;
  final bool isOverflow;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isSupportFeatured;
  final bool isFeatured;
  final TextAlign? textAlign;

  const NameWidget({
    super.key,
    required this.fullName,
    this.style,
    this.isOverflow = false,
    this.maxLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isSupportFeatured = false,
    this.isFeatured = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            fullName,
            style: style ?? Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_5),
            textAlign: textAlign,
            maxLines: isOverflow ? maxLines : null,
            overflow: isOverflow ? TextOverflow.ellipsis : null,
          ),
        ),
        if(isSupportFeatured && isFeatured) ...[
          const SizedBox(width: SizeManager.s5),
          const Padding(
            padding: EdgeInsets.only(top: SizeManager.s3),
            child: Icon(Icons.verified, color: ColorsManager.blue, size: SizeManager.s16),
          ),
        ]
      ],
    );
  }
}