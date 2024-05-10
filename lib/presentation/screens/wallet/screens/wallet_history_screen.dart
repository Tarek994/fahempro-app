import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:fahem/presentation/screens/wallet/widgets/wallet_history_extra_widget.dart';
import 'package:fahem/presentation/screens/wallet/widgets/wallet_history_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  late WalletHistoryProvider walletHistoryProvider;

  @override
  void initState() {
    super.initState();
    walletHistoryProvider = Provider.of<WalletHistoryProvider>(context, listen: false);
    walletHistoryProvider.resetVariablesToDefault();
    walletHistoryProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await walletHistoryProvider.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WalletHistoryProvider>(
        builder: (context, provider, _) {
          return TemplateListScreen(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            reFetchData: () async => await provider.reFetchData(),
            scrollController: provider.scrollController,
            goToInsertScreen: null,
            isSupportAppBar: false,
            screenTitle: StringsManager.wallet,
            scaffoldColor: ColorsManager.white,
            // searchFilterOrderWidget: SearchFilterOrderWidget(
            //   hintText: StringsManager.searchByAmount,
            //   ordersItems: const [OrderByType.walletHistoryNewestFirst, OrderByType.walletHistoryOldestFirst],
            //   filtersItems: const [FiltersType.dateOfCreated],
            //   dataState: provider.dataState,
            //   reFetchData: () async => await provider.reFetchData(),
            //   customText: {
            //     FiltersType.dateOfCreated.name: StringsManager.period,
            //   },
            // ),
            isDataNotEmpty: provider.walletHistory.isNotEmpty,
            dataCount: provider.walletHistory.length,
            totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.viewStyle,
            changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => WalletHistoryListItem(walletHistoryModel: provider.walletHistory[index], walletHistoryProvider: walletHistoryProvider),
            gridItemBuilder: null,
            dataState: provider.dataState,
            hasMore: provider.hasMore,
            noDataMsgInScreen: StringsManager.thereAreNoHistory,
            extraWidget: WalletHistoryExtraWidget(walletHistoryProvider: walletHistoryProvider),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    walletHistoryProvider.setIsScreenDisposed(true);
    // walletHistoryProvider.scrollController.dispose();
  }
}