import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/instant_consultations/controllers/instant_consultations_provider.dart';
import 'package:fahem_business/presentation/screens/instant_consultations/widgets/instant_consultation_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class InstantConsultationsScreen extends StatefulWidget {
  const InstantConsultationsScreen({super.key});

  @override
  State<InstantConsultationsScreen> createState() => _InstantConsultationsScreenState();
}

class _InstantConsultationsScreenState extends State<InstantConsultationsScreen> {
  late InstantConsultationsProvider instantConsultationsProvider;

  @override
  void initState() {
    super.initState();
    instantConsultationsProvider = Provider.of<InstantConsultationsProvider>(context, listen: false);
    instantConsultationsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await instantConsultationsProvider.fetchData());
  }

  void _onInsert(InstantConsultationModel? instantConsultation) {
    if(instantConsultation != null) {
      instantConsultationsProvider.insertInInstantConsultations(instantConsultation);
      if(instantConsultationsProvider.paginationModel != null) instantConsultationsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(InstantConsultationModel? instantConsultation) {
    if(instantConsultation != null) {
      instantConsultationsProvider.editInInstantConsultations(instantConsultation);
    }
  }

  void _onDelete(int instantConsultationId) {
    instantConsultationsProvider.deleteInstantConsultation(context: context, instantConsultationId: instantConsultationId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstantConsultationsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.instantConsultations,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByConsultationId,
            ordersItems: const [OrderByType.instantConsultationsNewestFirst, OrderByType.instantConsultationsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
              FiltersType.account.name: StringsManager.bestResponse,
            },
          ),
          isDataNotEmpty: provider.instantConsultations.isNotEmpty,
          dataCount: provider.instantConsultations.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => InstantConsultationListItem(
            instantConsultationModel: provider.instantConsultations[index],
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoInstantConsultations,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    instantConsultationsProvider.setIsScreenDisposed(true);
    instantConsultationsProvider.scrollController.dispose();
  }
}