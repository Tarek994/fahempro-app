import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/statistic_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:fahem_business/presentation/shared/widgets/statistic_item.dart';
import 'package:flutter/material.dart';

class FinancialAccountsScreen extends StatelessWidget {
  final List<StatisticModel> adminStatistics;

  const FinancialAccountsScreen({
    super.key,
    required this.adminStatistics,
  });

  bool _isClicked(String label) {
    if(label == StatisticsLabels.revenues.name) {return true;}
    if(label == StatisticsLabels.expenses.name) {return true;}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<StatisticModel> currentStatistics = adminStatistics.where((element) => element.inFinancialAccounts).toList();
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          slivers: [
            const DefaultSliverAppBar(title: StringsManager.financialAccounts),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(SizeManager.s16),
                child: Column(
                  children: [
                    CustomGrid(
                      listLength: currentStatistics.length,
                      numberOfItemsInRow: 2,
                      isExpandedEmptySpace: true,
                      child: (index) => Container(
                        margin: const EdgeInsets.all(SizeManager.s5),
                        child: Hover(
                          onTap: _isClicked(currentStatistics[index].label) ? () {
                            if(currentStatistics[index].label == StatisticsLabels.revenues.name) {
                              Methods.routeTo(context, Routes.revenuesScreen, arguments: adminStatistics);
                            }
                            else if(currentStatistics[index].label == StatisticsLabels.expenses.name) {
                              Methods.routeTo(context, Routes.expensesScreen, arguments: adminStatistics);
                            }
                          } : null,
                          child: StatisticItem(
                            title: MyProviders.appProvider.isEnglish ? currentStatistics[index].titleEn : currentStatistics[index].titleAr,
                            number: currentStatistics[index].count.toDouble(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
