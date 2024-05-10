import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/notifications/controllers/notifications_provider.dart';
import 'package:fahem/presentation/screens/notifications/widgets/notification_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsProvider notificationsProvider;
  
  @override
  void initState() {
    super.initState();
    notificationsProvider = Provider.of<NotificationsProvider>(context, listen: false);
    notificationsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await notificationsProvider.fetchData());
  }

  void _onDelete(int notificationId) {
    notificationsProvider.deleteNotification(context: context, notificationId: notificationId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsProvider>(
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
            ordersItems: const [OrderByType.notificationsNewestFirst, OrderByType.notificationsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
          ),
          isDataNotEmpty: provider.notifications.isNotEmpty,
          dataCount: provider.notifications.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => NotificationListItem(
            notificationModel: provider.notifications[index],
            onDelete: () => _onDelete(provider.notifications[index].notificationId),
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
    notificationsProvider.setIsScreenDisposed(true);
    notificationsProvider.scrollController.dispose();
  }
}