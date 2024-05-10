import 'package:flutter/material.dart';

class PageTransition {
  
  static Widget slideUpTransition({required Animation<double> animation, required Widget child}) {
    Animation<Offset> animationUpOffset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation);

    return SlideTransition(
      position: animationUpOffset,
      child: child,
    );
  }

  static Widget slideDownTransition({required Animation<double> animation, required Widget child}) {
    Animation<Offset> animationDownOffset = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation);

    return SlideTransition(
      position: animationDownOffset,
      child: child,
    );
  }

  static Widget slideLeftTransition({required Animation<double> animation, required Widget child}) {
    Animation<Offset> animationLeftOffset = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation);

    return SlideTransition(
      position: animationLeftOffset,
      child: child,
    );
  }

  static Widget slideRightTransition({required Animation<double> animation, required Widget child}) {
    Animation<Offset> animationRightOffset = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation);

    return SlideTransition(
      position: animationRightOffset,
      child: child,
    );
  }

  static Widget fadeTransition({required Animation<double> animation, required Widget child}) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget scaleTransition({required Animation<double> animation, required Widget child}) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  static Widget rotationTransition({required Animation<double> animation, required Widget child}) {
    return RotationTransition(
      turns: animation,
      child: child,
    );
  }

  static Widget sizeTransition({required Animation<double> animation, required Widget child}) {
    return Align(
      alignment: Alignment.center,
      child: SizeTransition(
        sizeFactor: animation,
        child: child,
      ),
    );
  }
}