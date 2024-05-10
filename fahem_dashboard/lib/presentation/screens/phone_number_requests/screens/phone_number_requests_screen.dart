import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/phone_number_request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/phone_number_requests/controllers/phone_number_requests_provider.dart';
import 'package:fahem_dashboard/presentation/screens/phone_number_requests/widgets/phone_number_request_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class PhoneNumberRequestsScreen extends StatefulWidget {
  const PhoneNumberRequestsScreen({super.key});

  @override
  State<PhoneNumberRequestsScreen> createState() => _PhoneNumberRequestsScreenState();
}

class _PhoneNumberRequestsScreenState extends State<PhoneNumberRequestsScreen> {
  late PhoneNumberRequestsProvider phoneNumberRequestsProvider;

  @override
  void initState() {
    super.initState();
    phoneNumberRequestsProvider = Provider.of<PhoneNumberRequestsProvider>(context, listen: false);
    phoneNumberRequestsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await phoneNumberRequestsProvider.fetchData());
  }

  void _onInsert(PhoneNumberRequestModel? phoneNumberRequest) {
    if(phoneNumberRequest != null) {
      phoneNumberRequestsProvider.insertInPhoneNumberRequests(phoneNumberRequest);
      if(phoneNumberRequestsProvider.paginationModel != null) phoneNumberRequestsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(PhoneNumberRequestModel? phoneNumberRequest) {
    if(phoneNumberRequest != null) {
      phoneNumberRequestsProvider.editInPhoneNumberRequests(phoneNumberRequest);
    }
  }

  void _onDelete(int phoneNumberRequestId) {
    phoneNumberRequestsProvider.deletePhoneNumberRequest(context: context, phoneNumberRequestId: phoneNumberRequestId);
  }

  String _getTitle() {
    if(phoneNumberRequestsProvider.phoneNumberRequestsArgs == null) {
      return Methods.getText(StringsManager.phoneNumberRequests).toTitleCase();
    }
    else {
      if(phoneNumberRequestsProvider.phoneNumberRequestsArgs!.account != null) {
        return phoneNumberRequestsProvider.phoneNumberRequestsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.phoneNumberRequests).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(phoneNumberRequestsProvider.phoneNumberRequestsArgs == null) {
      return const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.user];
    }
    else {
      if(phoneNumberRequestsProvider.phoneNumberRequestsArgs!.account != null) {
        return const [FiltersType.dateOfCreated, FiltersType.user];
      }
      else {
        return const [FiltersType.dateOfCreated, FiltersType.account, FiltersType.user];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneNumberRequestsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          // goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addPhoneNumberRequest) ? () {
          //   Methods.routeTo(context, Routes.insertEditPhoneNumberRequestScreen, arguments: null, then: (phoneNumberRequest) => _onInsert(phoneNumberRequest));
          // } : null,
          title: _getTitle(),
          isSearchFilterOrderWidgetInAction: true,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            isSupportSearch: false,
            ordersItems: const [OrderByType.phoneNumberRequestsNewestFirst, OrderByType.phoneNumberRequestsOldestFirst],
            filtersItems: _getFiltersItems(),
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.phoneNumberRequests.isNotEmpty,
          dataCount: provider.phoneNumberRequests.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => PhoneNumberRequestListItem(
            phoneNumberRequestModel: provider.phoneNumberRequests[index],
            onEdit: (phoneNumberRequest) => _onEdit(phoneNumberRequest),
            onDelete: () => _onDelete(provider.phoneNumberRequests[index].phoneNumberRequestId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoPhoneNumberRequests,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberRequestsProvider.setIsScreenDisposed(true);
    phoneNumberRequestsProvider.scrollController.dispose();
  }
}