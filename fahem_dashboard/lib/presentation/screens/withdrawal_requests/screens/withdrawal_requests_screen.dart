import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/withdrawal_requests/controllers/withdrawal_requests_provider.dart';
import 'package:fahem_dashboard/presentation/screens/withdrawal_requests/widgets/withdrawal_request_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class WithdrawalRequestsScreen extends StatefulWidget {
  const WithdrawalRequestsScreen({super.key});

  @override
  State<WithdrawalRequestsScreen> createState() => _WithdrawalRequestsScreenState();
}

class _WithdrawalRequestsScreenState extends State<WithdrawalRequestsScreen> {
  late WithdrawalRequestsProvider withdrawalRequestsProvider;

  @override
  void initState() {
    super.initState();
    withdrawalRequestsProvider = Provider.of<WithdrawalRequestsProvider>(context, listen: false);
    withdrawalRequestsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await withdrawalRequestsProvider.fetchData());
  }

  void _onInsert(WithdrawalRequestModel? withdrawalRequest) {
    if(withdrawalRequest != null) {
      withdrawalRequestsProvider.insertInWithdrawalRequests(withdrawalRequest);
      if(withdrawalRequestsProvider.paginationModel != null) withdrawalRequestsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(WithdrawalRequestModel? withdrawalRequest) {
    if(withdrawalRequest != null) {
      withdrawalRequestsProvider.editInWithdrawalRequests(withdrawalRequest);
    }
  }

  void _onDelete(int withdrawalRequestId) {
    withdrawalRequestsProvider.deleteWithdrawalRequest(context: context, withdrawalRequestId: withdrawalRequestId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WithdrawalRequestsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: provider.withdrawalRequestsArgs != null ? null : Methods.checkAdminPermission(AdminPermissions.addWithdrawalRequest) ? () {
            Methods.routeTo(context, Routes.insertEditWithdrawalRequestScreen, arguments: null, then: (withdrawalRequest) => _onInsert(withdrawalRequest));
          } : null,
          screenTitle: provider.withdrawalRequestsArgs == null ? StringsManager.withdrawalRequests : StringsManager.walletHistory,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByBalance,
            ordersItems: const [OrderByType.withdrawalRequestsNewestFirst, OrderByType.withdrawalRequestsOldestFirst],
            filtersItems: provider.withdrawalRequestsArgs == null
                ? const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.withdrawalRequestStatus, FiltersType.paymentType]
                : const [FiltersType.dateOfCreated, FiltersType.paymentType],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.withdrawalRequests.isNotEmpty,
          dataCount: provider.withdrawalRequests.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => WithdrawalRequestListItem(
            withdrawalRequestModel: provider.withdrawalRequests[index],
            onEdit: (withdrawalRequest) => _onEdit(withdrawalRequest),
            onDelete: () => _onDelete(provider.withdrawalRequests[index].withdrawalRequestId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoRequests,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    withdrawalRequestsProvider.setIsScreenDisposed(true);
    withdrawalRequestsProvider.scrollController.dispose();
  }
}