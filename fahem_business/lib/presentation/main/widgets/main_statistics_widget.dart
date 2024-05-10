import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/main/controllers/account_statistics_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_business/presentation/shared/widgets/my_error_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/not_found_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/statistic_item.dart';

class MainStatisticsWidget extends StatelessWidget {
  final AccountStatisticsProvider accountStatisticsProvider;

  const MainStatisticsWidget({
    super.key,
    required this.accountStatisticsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: accountStatisticsProvider.accountStatistics.isNotEmpty,
      builder: (_) => CustomGrid(
        listLength: accountStatisticsProvider.accountStatistics.length,
        numberOfItemsInRow: 3,
        isExpandedEmptySpace: true,
        child: (index) => Container(
          margin: const EdgeInsets.all(SizeManager.s5),
          child: StatisticItem(
            title: MyProviders.appProvider.isEnglish ? accountStatisticsProvider.accountStatistics[index].titleEn : accountStatisticsProvider.accountStatistics[index].titleAr,
            number: accountStatisticsProvider.accountStatistics[index].count.toDouble(),
          ),
        ),
      ),
      fallback: (_) {
        if(accountStatisticsProvider.dataState == DataState.loading) {
          return Methods.shimmerGrid(itemHeight: SizeManager.s60);
        }
        if(accountStatisticsProvider.dataState == DataState.empty) {
          return const NotFoundWidget(message: StringsManager.thereAreNoStatistics, isShowImage: false);
        }
        if(accountStatisticsProvider.dataState == DataState.error) {
          return MyErrorWidget(onPressed: () => accountStatisticsProvider.reFetchData());
        }
        return Container();
      },
    );
  }
}