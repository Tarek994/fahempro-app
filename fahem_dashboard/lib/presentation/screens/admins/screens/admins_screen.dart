import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/presentation/screens/admins/controllers/admins_provider.dart';
import 'package:fahem_dashboard/presentation/screens/admins/widgets/admin_grid_item.dart';
import 'package:fahem_dashboard/presentation/screens/admins/widgets/admin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class AdminsScreen extends StatefulWidget {
  const AdminsScreen({super.key});

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen> {
  late AdminsProvider adminsProvider;

  @override
  void initState() {
    super.initState();
    adminsProvider = Provider.of<AdminsProvider>(context, listen: false);
    adminsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await adminsProvider.fetchData());
  }

  void _onInsert(AdminModel? admin) {
    if(admin != null) {
      adminsProvider.insertInAdmins(admin);
      if(adminsProvider.paginationModel != null) adminsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(AdminModel? admin) {
    if(admin != null) {
      adminsProvider.editInAdmins(admin);
    }
  }

  void _onDelete(int adminId) {
    adminsProvider.deleteAdmin(context: context, adminId: adminId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminsProvider>(
        builder: (context, provider, _) {
          return TemplateListScreen(
            isShowLoading: provider.isLoadingDelete,
            waitForDone: provider.isLoadingDelete,
            isShowOpacityBackground: true,
            reFetchData: () async => await provider.reFetchData(),
            scrollController: provider.scrollController,
            goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addAdmin) ? () {
              Methods.routeTo(context, Routes.insertEditAdminScreen, arguments: null, then: (admin) => _onInsert(admin));
            } : null,
            screenTitle: StringsManager.admins,
            searchFilterOrderWidget: SearchFilterOrderWidget(
              hintText: StringsManager.searchByName,
              ordersItems: const [OrderByType.adminsNewestFirst, OrderByType.adminsOldestFirst, OrderByType.adminNameAZ, OrderByType.adminNameZA],
              filtersItems: const [FiltersType.gender, FiltersType.dateOfCreated, FiltersType.isSuper],
              dataState: provider.dataState,
              reFetchData: () async => await provider.reFetchData(),
              customText: {
                FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
              },
            ),
            isDataNotEmpty: provider.admins.isNotEmpty,
            dataCount: provider.admins.length,
            totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
            supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
            currentViewStyle: provider.viewStyle,
            changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => AdminListItem(adminModel: provider.admins[index], onEdit: (admins) => _onEdit(admins), onDelete: () => _onDelete(provider.admins[index].adminId)),
            gridItemBuilder: (context, index) => AdminGridItem(adminModel: provider.admins[index], onEdit: (admins) => _onEdit(admins), onDelete: () => _onDelete(provider.admins[index].adminId)),
            itemHeightInGrid: SizeManager.s70,
            dataState: provider.dataState,
            hasMore: provider.hasMore,
            noDataMsgInScreen: StringsManager.thereAreNoAdmins,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    adminsProvider.setIsScreenDisposed(true);
    adminsProvider.scrollController.dispose();
  }
}