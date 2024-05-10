import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;
  final bool isShowImage;

  const NotFoundWidget({
    super.key,
    required this.message,
    this.isShowImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(isShowImage) Flexible(
            child: Lottie.asset(
              LottieManager.notFound,
              width: SizeManager.s300,
              height: SizeManager.s300,
            ),
          ),
          Text(
            Methods.getText(message).toTitleCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}