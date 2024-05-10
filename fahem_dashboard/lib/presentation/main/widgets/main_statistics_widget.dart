import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/main/controllers/admin_statistics_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/my_error_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/not_found_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/statistic_item.dart';

class MainStatisticsWidget extends StatelessWidget {
  final AdminStatisticsProvider adminStatisticsProvider;

  const MainStatisticsWidget({
    super.key,
    required this.adminStatisticsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: adminStatisticsProvider.adminStatistics.isNotEmpty,
      builder: (_) => CustomGrid(
        listLength: adminStatisticsProvider.adminStatistics.length,
        numberOfItemsInRow: 3,
        isExpandedEmptySpace: true,
        child: (index) => Container(
          margin: const EdgeInsets.all(SizeManager.s5),
          child: StatisticItem(
            title: MyProviders.appProvider.isEnglish ? adminStatisticsProvider.adminStatistics[index].titleEn : adminStatisticsProvider.adminStatistics[index].titleAr,
            number: adminStatisticsProvider.adminStatistics[index].count.toDouble(),
          ),
        ),
      ),
      fallback: (_) {
        if(adminStatisticsProvider.dataState == DataState.loading) {
          return Methods.shimmerGrid(itemHeight: SizeManager.s60);
        }
        if(adminStatisticsProvider.dataState == DataState.empty) {
          return const NotFoundWidget(message: StringsManager.thereAreNoStatistics, isShowImage: false);
        }
        if(adminStatisticsProvider.dataState == DataState.error) {
          return MyErrorWidget(onPressed: () => adminStatisticsProvider.reFetchData());
        }
        return Container();
      },
    );
  }
}