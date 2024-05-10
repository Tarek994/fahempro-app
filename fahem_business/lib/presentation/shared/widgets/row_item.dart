import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final IconData iconData;
  final String text;

  const RowItem({
    super.key,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: SizeManager.s14),
        const SizedBox(width: SizeManager.s10),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}