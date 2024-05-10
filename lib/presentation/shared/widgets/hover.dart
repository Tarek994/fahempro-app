import 'package:fahem/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/values_manager.dart';

class Hover extends StatelessWidget {
  final Color? color;
  final BorderRadius? borderRadius;
  final double radiusValue;
  final EdgeInsetsGeometry? padding;
  final double paddingValue;
  final BoxBorder? border;
  final BoxShadow? boxShadow;
  final BoxConstraints? constraints;
  final Function()? onTap;
  final Widget child;

  const Hover({
    super.key,
    this.color = ColorsManager.white,
    this.borderRadius,
    this.radiusValue = SizeManager.s10,
    this.padding,
    this.paddingValue = SizeManager.s10,
    this.border,
    this.boxShadow,
    this.constraints,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(radiusValue),
        border: border,
        boxShadow: boxShadow == null ? null : [boxShadow!],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(radiusValue),
          child: Padding(
            padding: padding ?? EdgeInsets.all(paddingValue),
            child: child,
          ),
        ),
      ),
    );
  }
}