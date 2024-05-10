import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/presentation/screens/jobs/widgets/extra_widget_in_top_jobs.dart';
import 'package:fahem/presentation/screens/jobs/widgets/job_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/jobs/controllers/jobs_provider.dart';
import 'package:fahem/presentation/screens/jobs/widgets/job_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late JobsProvider jobsProvider;

  @override
  void initState() {
    super.initState();
    jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    jobsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await jobsProvider.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoading,
          waitForDone: provider.isLoading,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.jobs,
          scaffoldColor: ColorsManager.white,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByJobName,
            ordersItems: const [OrderByType.jobsNewestFirst, OrderByType.jobsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.jobs.isNotEmpty,
          dataCount: provider.jobs.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => JobListItem(
            jobModel: provider.jobs[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoJobs,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    jobsProvider.setIsScreenDisposed(true);
    jobsProvider.scrollController.dispose();
  }
}