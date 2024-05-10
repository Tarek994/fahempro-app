import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';

class NameWidget extends StatelessWidget {
  final String fullName;
  final TextStyle? style;
  final int? maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isSupportFeatured;
  final bool isFeatured;
  final TextAlign? textAlign;
  final Color verifiedColor;

  const NameWidget({
    super.key,
    required this.fullName,
    this.style,
    this.maxLines,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isSupportFeatured = false,
    this.isFeatured = false,
    this.textAlign,
    this.verifiedColor = ColorsManager.white,
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
            maxLines: maxLines,
            overflow: maxLines == null ? null : TextOverflow.ellipsis,
          ),
        ),
        if(isSupportFeatured && isFeatured) ...[
          const SizedBox(width: SizeManager.s5),
          Padding(
            padding: const EdgeInsets.only(top: SizeManager.s3),
            child: Icon(Icons.verified, color: verifiedColor, size: SizeManager.s16),
          ),
        ]
      ],
    );
  }
}