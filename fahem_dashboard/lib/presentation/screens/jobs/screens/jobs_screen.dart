import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/presentation/screens/jobs/widgets/extra_widget_in_top_jobs.dart';
import 'package:fahem_dashboard/presentation/screens/jobs/widgets/job_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/jobs/controllers/jobs_provider.dart';
import 'package:fahem_dashboard/presentation/screens/jobs/widgets/job_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

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

  void _onInsert(JobModel? job) {
    if(job != null) {
      jobsProvider.insertInJobs(job);
      if(jobsProvider.paginationModel != null) jobsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(JobModel? job) {
    if(job != null) {
      jobsProvider.editInJobs(job);
    }
  }

  void _onDelete(int jobId) {
    jobsProvider.deleteJob(context: context, jobId: jobId);
  }

  String _getTitle() {
    if(jobsProvider.jobsArgs == null) {
      return Methods.getText(StringsManager.jobs).toTitleCase();
    }
    else {
      if(jobsProvider.jobsArgs!.account != null) {
        return jobsProvider.jobsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.jobs).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(jobsProvider.jobsArgs == null) {
      return const [FiltersType.dateOfCreated, FiltersType.isAvailable, FiltersType.account];
    }
    else {
      if(jobsProvider.jobsArgs!.account != null) {
        return const [FiltersType.dateOfCreated, FiltersType.isAvailable];
      }
      else {
        return const [FiltersType.dateOfCreated, FiltersType.isAvailable, FiltersType.account];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addJob) ? () {
            Methods.routeTo(context, Routes.insertEditJobScreen, arguments: null, then: (job) => _onInsert(job));
          } : null,
          title: _getTitle(),
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByJobName,
            ordersItems: const [OrderByType.jobsNewestFirst, OrderByType.jobsOldestFirst],
            filtersItems: _getFiltersItems(),
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.jobs.isNotEmpty,
          dataCount: provider.jobs.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => JobListItem(
            jobModel: provider.jobs[index],
            onEdit: (job) => _onEdit(job),
            onDelete: () => _onDelete(provider.jobs[index].jobId),
          ),
          gridItemBuilder: (context, index) => JobGridItem(
            jobModel: provider.jobs[index],
            onEdit: (job) => _onEdit(job),
            onDelete: () => _onDelete(provider.jobs[index].jobId),
          ),
          itemHeightInGrid: SizeManager.s240,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoJobs,
          extraWidget: const ExtraWidgetInTopJobs(),
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