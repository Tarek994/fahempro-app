import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';

class DateWidget extends StatelessWidget {
  final String createdAt;
  final String? format;
  final bool isShowIcon;

  const DateWidget({
    super.key,
    required this.createdAt,
    this.format,
    this.isShowIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(isShowIcon) ...[
          const Icon(Icons.calendar_today, color: ColorsManager.black, size: SizeManager.s14),
          const SizedBox(width: SizeManager.s5),
        ],
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