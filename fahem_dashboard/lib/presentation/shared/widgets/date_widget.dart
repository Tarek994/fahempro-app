import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';

class DateWidget extends StatelessWidget {
  final String createdAt;
  final String? format;

  const DateWidget({
    super.key,
    required this.createdAt,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, color: ColorsManager.black, size: SizeManager.s14),
        const SizedBox(width: SizeManager.s5),
        Flexible(
          child: Text(
            Methods.formatDate(milliseconds: int.parse(createdAt), format: format),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}