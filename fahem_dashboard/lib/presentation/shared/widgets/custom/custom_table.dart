import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> content;

  const CustomTable({
    super.key,
    required this.headers,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SizeManager.s10),
          decoration: const BoxDecoration(
            color: ColorsManager.lightPrimaryColor,
          ),
          constraints: const BoxConstraints(minHeight: SizeManager.s40),
          child: Row(
            children: List.generate(headers.length, (index) => Expanded(
              child: Center(
                child: Text(
                  headers[index],
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
                ),
              ),
            )),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index1) => Container(
            padding: const EdgeInsets.all(SizeManager.s10),
            color: index1 % 2 == 0 ? ColorsManager.grey100 : ColorsManager.grey300,
            child: Row(
              children: List.generate(headers.length, (index2) => Expanded(
                child: Center(
                  child: Text(
                    content[index1][index2],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.medium),
                  ),
                ),
              )),
            ),
          ),
          itemCount: content.length,
        ),
      ],
    );
  }
}