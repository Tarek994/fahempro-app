import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class ViewsWidget extends StatelessWidget {
  final int views;
  final bool showNumberOfViewsText;
  final Color color;

  const ViewsWidget({
    super.key,
    required this.views,
    this.showNumberOfViewsText = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8, vertical: SizeManager.s4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.visibility, size: SizeManager.s16, color: ColorsManager.white),
          const SizedBox(width: SizeManager.s5),
          Flexible(
            child: Text(
              showNumberOfViewsText ? '${Methods.getText(StringsManager.numberOfViews).toCapitalized()} $views' : '$views',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
            ),
          ),
        ],
      ),
    );
  }
}