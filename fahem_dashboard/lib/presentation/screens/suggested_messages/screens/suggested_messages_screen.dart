import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/suggested_message_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/suggested_messages/controllers/suggested_messages_provider.dart';
import 'package:fahem_dashboard/presentation/screens/suggested_messages/widgets/suggested_message_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class SuggestedMessagesScreen extends StatefulWidget {

  const SuggestedMessagesScreen({super.key});

  @override
  State<SuggestedMessagesScreen> createState() => _SuggestedMessagesScreenState();
}

class _SuggestedMessagesScreenState extends State<SuggestedMessagesScreen> {
  late SuggestedMessagesProvider suggestedMessagesProvider;

  @override
  void initState() {
    super.initState();
    suggestedMessagesProvider = Provider.of<SuggestedMessagesProvider>(context, listen: false);
    suggestedMessagesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await suggestedMessagesProvider.fetchData());
  }

  void _onInsert(SuggestedMessageModel? suggestedMessage) {
    if(suggestedMessage != null) {
      suggestedMessagesProvider.insertInSuggestedMessages(suggestedMessage);
      if(suggestedMessagesProvider.paginationModel != null) suggestedMessagesProvider.paginationModel!.total++;
    }
  }

  void _onEdit(SuggestedMessageModel? suggestedMessage) {
    if(suggestedMessage != null) {
      suggestedMessagesProvider.editInSuggestedMessages(suggestedMessage);
    }
  }

  void _onDelete(int suggestedMessageId) {
    suggestedMessagesProvider.deleteSuggestedMessage(context: context, suggestedMessageId: suggestedMessageId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuggestedMessagesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addSuggestedMessage) ? () {
            Methods.routeTo(context, Routes.insertEditSuggestedMessageScreen, arguments: null, then: (suggestedMessage) => _onInsert(suggestedMessage));
          } : null,
          screenTitle: StringsManager.suggestedMessages,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByMessage,
            ordersItems: const [OrderByType.suggestedMessagesNewestFirst, OrderByType.suggestedMessagesOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.suggestedMessages.isNotEmpty,
          dataCount: provider.suggestedMessages.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => SuggestedMessageListItem(suggestedMessageModel: provider.suggestedMessages[index], onEdit: (suggestedMessage) => _onEdit(suggestedMessage), onDelete: () => _onDelete(provider.suggestedMessages[index].suggestedMessageId)),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoSuggestedMessages,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    suggestedMessagesProvider.setIsScreenDisposed(true);
    suggestedMessagesProvider.scrollController.dispose();
  }
}