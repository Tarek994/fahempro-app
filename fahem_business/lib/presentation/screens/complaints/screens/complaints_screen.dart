import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/complaints/controllers/complaints_provider.dart';
import 'package:fahem_business/presentation/screens/complaints/widgets/complaint_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  late ComplaintsProvider complaintsProvider;

  @override
  void initState() {
    super.initState();
    complaintsProvider = Provider.of<ComplaintsProvider>(context, listen: false);
    complaintsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await complaintsProvider.fetchData());
  }

  void _onDelete(int complaintId) {
    complaintsProvider.deleteComplaint(context: context, complaintId: complaintId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ComplaintsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.complaints,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByComplaint,
            ordersItems: const [OrderByType.complaintsNewestFirst, OrderByType.complaintsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.user],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.complaints.isNotEmpty,
          dataCount: provider.complaints.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ComplaintListItem(complaintModel: provider.complaints[index], onDelete: () => _onDelete(provider.complaints[index].complaintId)),
          gridItemBuilder: (context, index) => null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoComplaints,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    complaintsProvider.setIsScreenDisposed(true);
    complaintsProvider.scrollController.dispose();
  }
}