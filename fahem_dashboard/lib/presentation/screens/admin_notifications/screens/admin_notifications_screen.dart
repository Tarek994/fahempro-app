import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/admin_notifications/controllers/admin_notifications_provider.dart';
import 'package:fahem_dashboard/presentation/screens/admin_notifications/widgets/admin_notification_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  late AdminNotificationsProvider adminNotificationsProvider;
  
  @override
  void initState() {
    super.initState();
    adminNotificationsProvider = Provider.of<AdminNotificationsProvider>(context, listen: false);
    adminNotificationsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await adminNotificationsProvider.fetchData());
  }

  void _onDelete(int adminNotificationId) {
    adminNotificationsProvider.deleteAdminNotification(context: context, adminNotificationId: adminNotificationId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNotificationsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.notifications,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByTitleOrBody,
            ordersItems: const [OrderByType.adminNotificationsNewestFirst, OrderByType.adminNotificationsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
          ),
          isDataNotEmpty: provider.adminNotifications.isNotEmpty,
          dataCount: provider.adminNotifications.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => AdminNotificationListItem(
            adminNotificationModel: provider.adminNotifications[index],
            onDelete: () => _onDelete(provider.adminNotifications[index].adminNotificationId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoNotifications,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    adminNotificationsProvider.setIsScreenDisposed(true);
    adminNotificationsProvider.scrollController.dispose();
  }
}