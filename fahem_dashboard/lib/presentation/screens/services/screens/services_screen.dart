import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/presentation/screens/services/widgets/extra_widget_in_top_services.dart';
import 'package:fahem_dashboard/presentation/screens/services/widgets/service_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/services/controllers/services_provider.dart';
import 'package:fahem_dashboard/presentation/screens/services/widgets/service_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServicesProvider servicesProvider;

  @override
  void initState() {
    super.initState();
    servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await servicesProvider.fetchData());
  }

  void _onInsert(ServiceModel? service) {
    if(service != null) {
      servicesProvider.insertInServices(service);
      if(servicesProvider.paginationModel != null) servicesProvider.paginationModel!.total++;
    }
  }

  void _onEdit(ServiceModel? service) {
    if(service != null) {
      servicesProvider.editInServices(service);
    }
  }

  void _onDelete(int serviceId) {
    servicesProvider.deleteService(context: context, serviceId: serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addService) ? () {
            Methods.routeTo(context, Routes.insertEditServiceScreen, arguments: null, then: (service) => _onInsert(service));
          } : null,
          screenTitle: StringsManager.services,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.servicesNewestFirst, OrderByType.servicesOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.mainCategory],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.services.isNotEmpty,
          dataCount: provider.services.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ServiceListItem(
            serviceModel: provider.services[index],
            onEdit: (service) => _onEdit(service),
            onDelete: () => _onDelete(provider.services[index].serviceId),
          ),
          gridItemBuilder: (context, index) => ServiceGridItem(
            serviceModel: provider.services[index],
            onEdit: (service) => _onEdit(service),
            onDelete: () => _onDelete(provider.services[index].serviceId),
          ),
          itemHeightInGrid: SizeManager.s100,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoServices,
          extraWidget: const ExtraWidgetInTopServices(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    servicesProvider.setIsScreenDisposed(true);
    servicesProvider.scrollController.dispose();
  }
}