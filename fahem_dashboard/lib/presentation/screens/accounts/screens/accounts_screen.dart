import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/presentation/screens/accounts/widgets/account_grid_item.dart';
import 'package:fahem_dashboard/presentation/screens/accounts/widgets/extra_widget_in_accounts.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/accounts/controllers/accounts_provider.dart';
import 'package:fahem_dashboard/presentation/screens/accounts/widgets/account_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late AccountsProvider accountsProvider;

  @override
  void initState() {
    super.initState();
    accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
    accountsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await accountsProvider.fetchData());
  }

  void _onInsert(AccountModel? account) {
    if(account != null) {
      accountsProvider.insertInAccounts(account);
      if(accountsProvider.paginationModel != null) accountsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(AccountModel? account) {
    if(account != null) {
      accountsProvider.editInAccounts(account);
    }
  }

  void _onDelete(int accountId) {
    accountsProvider.deleteAccount(context: context, accountId: accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addAccount) ? () {
            Methods.routeTo(context, Routes.insertEditAccountScreen, arguments: null, then: (account) => _onInsert(account));
          } : null,
          screenTitle: StringsManager.accounts,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.accountsNewestFirst, OrderByType.accountsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.gender, FiltersType.isFeatured, FiltersType.mainCategory, FiltersType.category],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.joinDate,
            },
          ),
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => AccountListItem(
            accountModel: provider.accounts[index],
            onEdit: (account) => _onEdit(account),
            onDelete: () => _onDelete(provider.accounts[index].accountId),
          ),
          gridItemBuilder: (context, index) => AccountGridItem(
            accountModel: provider.accounts[index],
            onEdit: (account) => _onEdit(account),
            onDelete: () => _onDelete(provider.accounts[index].accountId),
          ),
          itemHeightInGrid: SizeManager.s70,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoAccounts,
          extraWidget: const ExtraWidgetInAccounts(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    accountsProvider.setIsScreenDisposed(true);
    accountsProvider.scrollController.dispose();
  }
}