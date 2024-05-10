import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/withdrawal_request_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/withdrawal_requests/controllers/withdrawal_requests_provider.dart';
import 'package:fahem_business/presentation/screens/withdrawal_requests/widgets/withdrawal_request_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

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
          goToInsertScreen: null,
          screenTitle: provider.withdrawalRequestsArgs == null ? StringsManager.withdrawalRequests : StringsManager.walletHistory,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByBalance,
            ordersItems: const [OrderByType.withdrawalRequestsNewestFirst, OrderByType.withdrawalRequestsOldestFirst],
            filtersItems: provider.withdrawalRequestsArgs == null
                ? const [FiltersType.dateOfCreated, FiltersType.withdrawalRequestStatus, FiltersType.paymentType]
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
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoRequests,
          extraWidget: Container(
            padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s16, bottom: SizeManager.s16),
            margin: const EdgeInsets.all(SizeManager.s16),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(SizeManager.s10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Methods.getText(StringsManager.myBalance).toTitleCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: SizeManager.s5),
                    Text(
                      '${MyProviders.authenticationProvider.currentAccount.balance} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s10),
                CustomButton(
                  onPressed: MyProviders.authenticationProvider.currentAccount.balance < 1000 ? null : () => Methods.routeTo(
                    context,
                    Routes.insertEditWithdrawalRequestScreen,
                    arguments: null,
                    then: (withdrawalRequest) => _onInsert(withdrawalRequest),
                  ),
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.submitARequestToWithdrawTheBalance).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s40,
                  buttonColor: MyProviders.authenticationProvider.currentAccount.balance < 1000
                      ? ColorsManager.lightPrimaryColor.withOpacity(0.3)
                      : ColorsManager.lightPrimaryColor,
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  '${Methods.getText(StringsManager.minimumBalanceWithdrawal).toCapitalized()} 1000 ${Methods.getText(StringsManager.egp).toUpperCase()}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
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