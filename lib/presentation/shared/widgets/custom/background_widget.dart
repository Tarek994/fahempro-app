import 'package:fahem/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final bool isShowBackground;

  const BackgroundWidget({
    super.key,
    required this.child,
    this.isShowBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    if(isShowBackground) {
      return Stack(
        children: [
          Image.asset(
            ImagesManager.backgroundScreen,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          child,
        ],
      );
    }
    return child;
  }
}
