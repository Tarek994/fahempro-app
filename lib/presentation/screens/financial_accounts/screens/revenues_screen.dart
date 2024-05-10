import 'package:fahem/data/models/statistic_model.dart';
import 'package:fahem/presentation/screens/financial_accounts/controllers/revenues_provider.dart';
import 'package:fahem/presentation/screens/financial_accounts/widgets/extra_widget_in_revenues.dart';
import 'package:fahem/presentation/screens/financial_accounts/widgets/revenue_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:provider/provider.dart';

class RevenuesScreen extends StatefulWidget {
  final List<StatisticModel> adminStatistics;

  const RevenuesScreen({
    super.key,
    required this.adminStatistics,
  });

  @override
  State<RevenuesScreen> createState() => _RevenuesScreenState();
}

class _RevenuesScreenState extends State<RevenuesScreen> {
  late RevenuesProvider revenuesProvider;

  @override
  void initState() {
    super.initState();
    revenuesProvider = Provider.of<RevenuesProvider>(context, listen: false);
    revenuesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        revenuesProvider.fetchData(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RevenuesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async {
            await Future.wait([
              provider.reFetchData(),
            ]);
          },
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.revenues,
          appBarColor: ColorsManager.white,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.users.isNotEmpty,
          dataCount: provider.users.length,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => RevenueListItem(userModel: provider.users[index]),
          gridItemBuilder: (context, index) => null,
          itemHeightInGrid: SizeManager.s260,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.notFound,
          extraWidget: ExtraWidgetInRevenues(adminStatistics: widget.adminStatistics),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    revenuesProvider.setIsScreenDisposed(true);
    revenuesProvider.scrollController.dispose();
  }
}