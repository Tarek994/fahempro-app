import 'dart:async';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';

class SplashLoadingWidget extends StatefulWidget {

  const SplashLoadingWidget({super.key});

  @override
  State<SplashLoadingWidget> createState() => _SplashLoadingWidgetState();
}

class _SplashLoadingWidgetState extends State<SplashLoadingWidget> {
  int _loadingCount = 0;
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _loadingTimer ??= Timer.periodic(const Duration(milliseconds: ConstantsManager.splashLoadingDuration), (timer) {
      setState(() => ++_loadingCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.all(SizeManager.s3),
          width: SizeManager.s12,
          height: SizeManager.s12,
          decoration: BoxDecoration(
            color: MyProviders.appProvider.isLight
                ? (_loadingCount%3 == index ? ColorsManager.lightPrimaryColor : ColorsManager.grey)
                : (_loadingCount%3 == index ? ColorsManager.white : ColorsManager.grey),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }
}