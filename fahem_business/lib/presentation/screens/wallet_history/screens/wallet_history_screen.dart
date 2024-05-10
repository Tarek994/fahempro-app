import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/wallet_history_model.dart';
import 'package:fahem_business/presentation/shared/widgets/card_info.dart';
import 'package:fahem_business/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/wallet_history/controllers/wallet_history_provider.dart';
import 'package:fahem_business/presentation/screens/wallet_history/widgets/wallet_history_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

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
    walletHistoryProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await walletHistoryProvider.fetchData());
  }

  void _onInsert(WalletHistoryModel? walletHistory) {
    if(walletHistory != null) {
      walletHistoryProvider.insertInWalletHistory(walletHistory);
      if(walletHistoryProvider.paginationModel != null) walletHistoryProvider.paginationModel!.total++;
    }
  }

  void _onEdit(WalletHistoryModel? walletHistory) {
    if(walletHistory != null) {
      walletHistoryProvider.editInWalletHistory(walletHistory);
    }
  }

  void _onDelete(int walletHistoryId) {
    walletHistoryProvider.deleteWalletHistory(context: context, walletHistoryId: walletHistoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletHistoryProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.walletHistory,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByAmount,
            ordersItems: const [OrderByType.walletHistoryNewestFirst, OrderByType.walletHistoryOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.walletHistory.isNotEmpty,
          dataCount: provider.walletHistory.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => WalletHistoryListItem(
            walletHistoryModel: provider.walletHistory[index],
            onEdit: (walletHistory) => _onEdit(walletHistory),
            onDelete: () => _onDelete(provider.walletHistory[index].walletHistoryId),
            showUser: provider.walletHistoryArgs == null,
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoHistory,
          extraWidget: _ExtraWidget(walletHistoryArgs: provider.walletHistoryArgs),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    walletHistoryProvider.setIsScreenDisposed(true);
    walletHistoryProvider.scrollController.dispose();
  }
}

class _ExtraWidget extends StatelessWidget {
  final WalletHistoryArgs? walletHistoryArgs;

  const _ExtraWidget({
    required this.walletHistoryArgs,
  });

  @override
  Widget build(BuildContext context) {
    if(walletHistoryArgs == null) {return const SizedBox();}
    if(walletHistoryArgs!.user == null) {return const SizedBox();}
    return Padding(
      padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: UserRowWidget(
                  user: walletHistoryArgs!.user!,
                  color: ColorsManager.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          CardInfo(
            icon: FontAwesomeIcons.coins,
            title: Methods.getText(StringsManager.totalRevenues).toTitleCase(),
            value: '${walletHistoryArgs!.user!.totalRevenues} ${Methods.getText(StringsManager.egp).toUpperCase()}',
          ),
          const SizedBox(height: SizeManager.s10),
          CardInfo(
            icon: FontAwesomeIcons.wallet,
            title: Methods.getText(StringsManager.currentWalletBalance).toTitleCase(),
            value: '${walletHistoryArgs!.user!.balance} ${Methods.getText(StringsManager.egp).toUpperCase()}',
          ),
        ],
      ),
    );
  }
}
