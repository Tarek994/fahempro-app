import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/secret_consultations/controllers/secret_consultations_provider.dart';
import 'package:fahem_dashboard/presentation/screens/secret_consultations/widgets/secret_consultation_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class SecretConsultationsScreen extends StatefulWidget {
  const SecretConsultationsScreen({super.key});

  @override
  State<SecretConsultationsScreen> createState() => _SecretConsultationsScreenState();
}

class _SecretConsultationsScreenState extends State<SecretConsultationsScreen> {
  late SecretConsultationsProvider secretConsultationsProvider;

  @override
  void initState() {
    super.initState();
    secretConsultationsProvider = Provider.of<SecretConsultationsProvider>(context, listen: false);
    secretConsultationsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await secretConsultationsProvider.fetchData());
  }

  void _onInsert(SecretConsultationModel? secretConsultation) {
    if(secretConsultation != null) {
      secretConsultationsProvider.insertInSecretConsultations(secretConsultation);
      if(secretConsultationsProvider.paginationModel != null) secretConsultationsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(SecretConsultationModel? secretConsultation) {
    if(secretConsultation != null) {
      secretConsultationsProvider.editInSecretConsultations(secretConsultation);
    }
  }

  void _onDelete(int secretConsultationId) {
    secretConsultationsProvider.deleteSecretConsultation(context: context, secretConsultationId: secretConsultationId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SecretConsultationsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addSecretConsultation) ? () {
            Methods.routeTo(context, Routes.insertEditSecretConsultationScreen, arguments: null, then: (secretConsultation) => _onInsert(secretConsultation));
          } : null,
          screenTitle: StringsManager.secretConsultations,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByConsultationId,
            ordersItems: const [OrderByType.secretConsultationsNewestFirst, OrderByType.secretConsultationsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.user],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.secretConsultations.isNotEmpty,
          dataCount: provider.secretConsultations.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => SecretConsultationListItem(
            secretConsultationModel: provider.secretConsultations[index],
            onEdit: (secretConsultation) => _onEdit(secretConsultation),
            onDelete: () => _onDelete(provider.secretConsultations[index].secretConsultationId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoSecretConsultations,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    secretConsultationsProvider.setIsScreenDisposed(true);
    secretConsultationsProvider.scrollController.dispose();
  }
}