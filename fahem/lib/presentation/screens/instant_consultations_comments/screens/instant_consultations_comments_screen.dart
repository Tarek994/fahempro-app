import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/widgets/instant_consultation_comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/controllers/instant_consultations_comments_provider.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class InstantConsultationsCommentsScreen extends StatefulWidget {
  const InstantConsultationsCommentsScreen({super.key});

  @override
  State<InstantConsultationsCommentsScreen> createState() => _InstantConsultationsCommentsScreenState();
}

class _InstantConsultationsCommentsScreenState extends State<InstantConsultationsCommentsScreen> {
  late InstantConsultationsCommentsProvider instantConsultationsCommentsProvider;

  @override
  void initState() {
    super.initState();
    instantConsultationsCommentsProvider = Provider.of<InstantConsultationsCommentsProvider>(context, listen: false);
    instantConsultationsCommentsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await instantConsultationsCommentsProvider.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstantConsultationsCommentsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          title: '${Methods.getText(StringsManager.consultationId)} #${instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.instantConsultation!.instantConsultationId}',
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByComment,
            ordersItems: const [OrderByType.instantConsultationsCommentsNewestFirst, OrderByType.instantConsultationsCommentsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.instantConsultationsComments.isNotEmpty,
          dataCount: provider.instantConsultationsComments.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => InstantConsultationCommentListItem(
            instantConsultationCommentModel: provider.instantConsultationsComments[index],
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoComments,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    instantConsultationsCommentsProvider.setIsScreenDisposed(true);
    instantConsultationsCommentsProvider.scrollController.dispose();
  }
}