import 'package:fahem/data/models/statistic_model.dart';
import 'package:fahem/presentation/screens/financial_accounts/controllers/expenses_provider.dart';
import 'package:fahem/presentation/screens/financial_accounts/widgets/expense_list_item.dart';
import 'package:fahem/presentation/screens/financial_accounts/widgets/extra_widget_in_expenses.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  final List<StatisticModel> adminStatistics;

  const ExpensesScreen({
    super.key,
    required this.adminStatistics,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late ExpensesProvider expensesProvider;

  @override
  void initState() {
    super.initState();
    expensesProvider = Provider.of<ExpensesProvider>(context, listen: false);
    expensesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        expensesProvider.fetchData(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async {
            await Future.wait([
              provider.reFetchData(),
            ]);
          },
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.expenses,
          appBarColor: ColorsManager.white,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ExpenseListItem(accountModel: provider.accounts[index]),
          gridItemBuilder: (context, index) => null,
          itemHeightInGrid: SizeManager.s260,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.notFound,
          extraWidget: ExtraWidgetInExpenses(adminStatistics: widget.adminStatistics),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    expensesProvider.setIsScreenDisposed(true);
    expensesProvider.scrollController.dispose();
  }
}