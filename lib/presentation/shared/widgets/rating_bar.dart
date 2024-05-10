import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double numberOfStars;
  final double starSize;
  final double padding;

  const RatingBar({
    super.key,
    required this.numberOfStars,
    this.starSize = SizeManager.s15,
    this.padding = SizeManager.s2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index2) {
        if (index2.toDouble() >= numberOfStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Image.asset(ImagesManager.ratingEmpty, width: starSize, height: starSize),
          );
        }
        else if (index2.toDouble() > numberOfStars - 1 && index2.toDouble() < numberOfStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Image.asset(
              MyProviders.appProvider.isEnglish ? ImagesManager.ratingHalfLeft : ImagesManager.ratingHalfRight,
              width: starSize,
              height: starSize,
            ),
          );
        }
        else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Image.asset(ImagesManager.ratingFull, width: starSize, height: starSize),
          );
        }
      }),
    );
  }
}