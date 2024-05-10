import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/presentation/screens/instant_consultations_comments/widgets/instant_consultation_comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/instant_consultations_comments/controllers/instant_consultations_comments_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

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

  void _onInsert(InstantConsultationCommentModel? instantConsultationComment) {
    if(instantConsultationComment != null) {
      instantConsultationsCommentsProvider.insertInInstantConsultationsComments(instantConsultationComment);
      if(instantConsultationsCommentsProvider.paginationModel != null) instantConsultationsCommentsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(InstantConsultationCommentModel? instantConsultationComment) {
    if(instantConsultationComment != null) {
      instantConsultationsCommentsProvider.editInInstantConsultationsComments(instantConsultationComment);
    }
  }

  void _onDelete(int instantConsultationCommentId) {
    instantConsultationsCommentsProvider.deleteInstantConsultationComment(context: context, instantConsultationCommentId: instantConsultationCommentId);
  }

  String _getTitle() {
    if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs == null) {
      return Methods.getText(StringsManager.instantConsultationsComments).toTitleCase();
    }
    else {
      if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.instantConsultation != null) {
        return '${Methods.getText(StringsManager.consultationId)} #${instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.instantConsultation!.instantConsultationId}';
      }
      else if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.account != null) {
        return instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.instantConsultationsComments).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs == null) {
      return const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.instantConsultation, FiltersType.commentStatus];
    }
    else {
      if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.instantConsultation != null) {
        return const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.commentStatus];
      }
      else if(instantConsultationsCommentsProvider.instantConsultationsCommentsArgs!.account != null) {
        return const [FiltersType.dateOfCreated, FiltersType.instantConsultation, FiltersType.commentStatus];
      }
      else {
        return const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.instantConsultation, FiltersType.commentStatus];
      }
    }
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
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addInstantConsultationComment) ? () {
            Methods.routeTo(context, Routes.insertEditInstantConsultationCommentScreen, arguments: null, then: (instantConsultationComment) => _onInsert(instantConsultationComment));
          } : null,
          title: _getTitle(),
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByComment,
            ordersItems: const [OrderByType.instantConsultationsCommentsNewestFirst, OrderByType.instantConsultationsCommentsOldestFirst],
            filtersItems: _getFiltersItems(),
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
            onEdit: (instantConsultationComment) => _onEdit(instantConsultationComment),
            onDelete: () => _onDelete(provider.instantConsultationsComments[index].instantConsultationCommentId),
            showConsultationId: provider.instantConsultationsCommentsArgs == null || (provider.instantConsultationsCommentsArgs != null && provider.instantConsultationsCommentsArgs!.instantConsultation == null),
            showAccount: provider.instantConsultationsCommentsArgs == null || (provider.instantConsultationsCommentsArgs != null && provider.instantConsultationsCommentsArgs!.account == null),
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