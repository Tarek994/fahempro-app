import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/statistic_model.dart';
import 'package:fahem/presentation/shared/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExtraWidgetInExpenses extends StatelessWidget {
  final List<StatisticModel> adminStatistics;

  const ExtraWidgetInExpenses({
    super.key,
    required this.adminStatistics,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s16),
      child: Column(
        children: [
          CardInfo(
            icon: FontAwesomeIcons.hashtag,
            title: Methods.getText(StringsManager.numberOfClients).toTitleCase(),
            value: adminStatistics.firstWhere((element) => element.label == StatisticsLabels.accounts.name).count.toString(),
          ),
          const SizedBox(height: SizeManager.s10),
          CardInfo(
            icon: FontAwesomeIcons.coins,
            title: Methods.getText(StringsManager.totalAmountTransferred).toTitleCase(),
            value: '${adminStatistics.firstWhere((element) => element.label == StatisticsLabels.expenses.name).count} ${Methods.getText(StringsManager.egp).toUpperCase()}',
          ),
          const SizedBox(height: SizeManager.s20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightSecondaryColor,
                    borderRadius: BorderRadius.circular(SizeManager.s10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.solidUser, size: SizeManager.s14, color: ColorsManager.white),
                      const SizedBox(width: SizeManager.s10),
                      Text(
                        Methods.getText(StringsManager.clientName).toTitleCase(),
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightSecondaryColor,
                    borderRadius: BorderRadius.circular(SizeManager.s10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.coins, size: SizeManager.s14, color: ColorsManager.white),
                      const SizedBox(width: SizeManager.s10),
                      Text(
                        Methods.getText(StringsManager.transactionAmount).toTitleCase(),
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
