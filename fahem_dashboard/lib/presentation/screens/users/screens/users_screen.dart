import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/presentation/screens/users/controllers/users_provider.dart';
import 'package:fahem_dashboard/presentation/screens/users/widgets/user_grid_item.dart';
import 'package:fahem_dashboard/presentation/screens/users/widgets/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UsersProvider usersProvider;

  @override
  void initState() {
    super.initState();
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    usersProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await usersProvider.fetchData());
  }

  void _onInsert(UserModel? user) {
    if(user != null) {
      usersProvider.insertInUsers(user);
      if(usersProvider.paginationModel != null) usersProvider.paginationModel!.total++;
    }
  }

  void _onEdit(UserModel? user) {
    if(user != null) {
      usersProvider.editInUsers(user);
    }
  }

  void _onDelete(int userId) {
    usersProvider.deleteUser(context: context, userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UsersProvider>(
        builder: (context, provider, _) {
          return TemplateListScreen(
            isShowLoading: provider.isLoadingDelete,
            waitForDone: provider.isLoadingDelete,
            isShowOpacityBackground: true,
            reFetchData: () async => await provider.reFetchData(),
            scrollController: provider.scrollController,
            goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addUser) ? () {
              Methods.routeTo(context, Routes.insertEditUserScreen, arguments: null, then: (user) => _onInsert(user));
            } : null,
            screenTitle: StringsManager.users,
            searchFilterOrderWidget: SearchFilterOrderWidget(
              hintText: StringsManager.searchByName,
              ordersItems: const [OrderByType.usersNewestFirst, OrderByType.usersOldestFirst, OrderByType.userNameAZ, OrderByType.userNameZA],
              filtersItems: const [FiltersType.gender, FiltersType.country, FiltersType.dateOfCreated],
              dataState: provider.dataState,
              reFetchData: () async => await provider.reFetchData(),
              customText: {
                FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
              },
            ),
            isDataNotEmpty: provider.users.isNotEmpty,
            dataCount: provider.users.length,
            totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
            supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
            currentViewStyle: provider.viewStyle,
            changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => UserListItem(userModel: provider.users[index], onEdit: (users) => _onEdit(users), onDelete: () => _onDelete(provider.users[index].userId)),
            gridItemBuilder: (context, index) => UserGridItem(userModel: provider.users[index], onEdit: (users) => _onEdit(users), onDelete: () => _onDelete(provider.users[index].userId)),
            itemHeightInGrid: SizeManager.s70,
            dataState: provider.dataState,
            hasMore: provider.hasMore,
            noDataMsgInScreen: StringsManager.thereAreNoUsers,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    usersProvider.setIsScreenDisposed(true);
    usersProvider.scrollController.dispose();
  }
}