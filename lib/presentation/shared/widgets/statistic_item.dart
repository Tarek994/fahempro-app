import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';

class StatisticItem extends StatelessWidget {
  final String title;
  final double number;
  final Color backgroundColor;
  final Color textColor;

  const StatisticItem({
    super.key,
    required this.title,
    required this.number,
    this.backgroundColor = ColorsManager.white,
    this.textColor = ColorsManager.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: textColor, fontWeight: FontWeightManager.medium),
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          FittedBox(
            child: Countup(
              begin: 0,
              end: number,
              duration: const Duration(milliseconds: ConstantsManager.countupDuration),
              separator: ',',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontWeight: FontWeightManager.bold),
            ),
          ),
        ],
      ),
    );
  }
}