import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';

class CustomGrid extends StatelessWidget {
  final int listLength;
  final int numberOfItemsInRow;
  final Widget Function(int index) child;
  final double horizontalMargin;
  final double verticalMargin;
  final bool isExpandedEmptySpace;

  const CustomGrid({
    super.key,
    required this.listLength,
    required this.numberOfItemsInRow,
    required this.child,
    this.horizontalMargin = SizeManager.s0,
    this.verticalMargin = SizeManager.s0,
    this.isExpandedEmptySpace = false,
  });

  @override
  Widget build(BuildContext context) {
    int numberOfRows = (listLength / numberOfItemsInRow).ceil();

    return Column(
      children: List.generate(numberOfRows, (index1) {
        return Row(
          children: List.generate(numberOfItemsInRow, (index2) {
            int index = index1 * numberOfItemsInRow + index2;
            return listLength > index ? Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
                child: child(index),
              ),
            ) : isExpandedEmptySpace ? Container() : Expanded(child: Container());
          }),
        );
      }),
    );
  }
}