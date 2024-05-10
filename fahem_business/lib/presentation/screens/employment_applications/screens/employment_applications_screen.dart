import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/employment_applications/controllers/employment_applications_provider.dart';
import 'package:fahem_business/presentation/screens/employment_applications/widgets/employment_application_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class EmploymentApplicationsScreen extends StatefulWidget {
  const EmploymentApplicationsScreen({super.key});

  @override
  State<EmploymentApplicationsScreen> createState() => _EmploymentApplicationsScreenState();
}

class _EmploymentApplicationsScreenState extends State<EmploymentApplicationsScreen> {
  late EmploymentApplicationsProvider employmentApplicationsProvider;

  @override
  void initState() {
    super.initState();
    employmentApplicationsProvider = Provider.of<EmploymentApplicationsProvider>(context, listen: false);
    employmentApplicationsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await employmentApplicationsProvider.fetchData());
  }

  void _onDelete(int employmentApplicationId) {
    employmentApplicationsProvider.deleteEmploymentApplication(context: context, employmentApplicationId: employmentApplicationId);
  }

  String _getTitle() {
    if(employmentApplicationsProvider.employmentApplicationsArgs == null) {
      return Methods.getText(StringsManager.employmentApplications).toTitleCase();
    }
    else {
      if(employmentApplicationsProvider.employmentApplicationsArgs!.job != null) {
        // return employmentApplicationsProvider.employmentApplicationsArgs!.job!.jobTitle;
        return Methods.getText(StringsManager.employmentApplications).toTitleCase();
      }
      else if(employmentApplicationsProvider.employmentApplicationsArgs!.account != null) {
        return employmentApplicationsProvider.employmentApplicationsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.employmentApplications).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(employmentApplicationsProvider.employmentApplicationsArgs == null) {
      return const [FiltersType.dateOfCreated];
    }
    else {
      if(employmentApplicationsProvider.employmentApplicationsArgs!.job != null) {
        return const [FiltersType.dateOfCreated];
      }
      else if(employmentApplicationsProvider.employmentApplicationsArgs!.account != null) {
        return const [FiltersType.dateOfCreated];
      }
      else {
        return const [FiltersType.dateOfCreated];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmploymentApplicationsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          title: _getTitle(),
          isSearchFilterOrderWidgetInAction: true,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            isSupportSearch: false,
            ordersItems: const [OrderByType.employmentApplicationsNewestFirst, OrderByType.employmentApplicationsOldestFirst],
            filtersItems: _getFiltersItems(),
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.employmentApplications.isNotEmpty,
          dataCount: provider.employmentApplications.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => EmploymentApplicationListItem(employmentApplicationModel: provider.employmentApplications[index], onDelete: () => _onDelete(provider.employmentApplications[index].employmentApplicationId)),
          gridItemBuilder: (context, index) => null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoEmploymentApplications,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    employmentApplicationsProvider.setIsScreenDisposed(true);
    employmentApplicationsProvider.scrollController.dispose();
  }
}