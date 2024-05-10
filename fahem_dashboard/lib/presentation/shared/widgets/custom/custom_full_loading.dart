import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';

class CustomFullLoading extends StatelessWidget {
  final bool isShowLoading;
  final bool isShowOpacityBackground;
  final bool waitForDone;
  final Future<void> Function()? onRefresh;
  final Widget child;

  const CustomFullLoading({
    super.key,
    this.isShowLoading = false,
    this.isShowOpacityBackground = false,
    this.waitForDone = false,
    this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Future.value(!waitForDone),
      child: Directionality(
        textDirection: Methods.getDirection(),
        child: AbsorbPointer(
          absorbing: waitForDone,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                onRefresh == null ? child : _RefreshIndicator(
                  onRefresh: onRefresh!,
                  child: child,
                ),
                if(isShowLoading) Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: isShowOpacityBackground ? ColorsManager.white38 : null,
                    child: const Center(
                      child: _LoadingWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const _RefreshIndicator({required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: SizeManager.s50,
      backgroundColor: ColorsManager.white,
      color: ColorsManager.lightPrimaryColor,
      strokeWidth: SizeManager.s3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: child,
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
        border: Border.all(color: ColorsManager.grey200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: SizeManager.s25,
            height: SizeManager.s25,
            child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
          ),
          const SizedBox(height: SizeManager.s20),
          Text(
            Methods.getText(StringsManager.pleaseWait).toCapitalized(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}