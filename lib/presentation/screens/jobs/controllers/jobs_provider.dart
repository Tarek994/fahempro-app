import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/employment_application_model.dart';
import 'package:fahem/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/jobs_response.dart';
import 'package:fahem/domain/usecases/jobs/delete_job_usecase.dart';
import 'package:fahem/domain/usecases/jobs/get_jobs_usecase.dart';

class JobsProvider with ChangeNotifier {
  final JobsArgs? jobsArgs;

  JobsProvider({this.jobsArgs});

  // region Get Jobs
  final List<JobModel> _jobs = [];
  List<JobModel> get jobs => _jobs;
  addAllInJobs(List<JobModel> jobs) {_jobs.addAll(jobs); notifyListeners();}
  insertInJobs(JobModel jobModel) {_jobs.insert(0, jobModel); notifyListeners();}
  editInJobs(JobModel jobModel) {
    int index = _jobs.indexWhere((element) => element.jobId == jobModel.jobId);
    if(index != -1) {
      _jobs[index] = jobModel;
      notifyListeners();
    }
  }
  _deleteFromJobs(int jobId) {
    int index = _jobs.indexWhere((element) => element.jobId == jobId);
    if(index != -1) {
      _jobs.removeAt(index);
      notifyListeners();
    }
  }

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  bool _hasMore = true;
  bool get hasMore => _hasMore;
  setHasMore(bool hasMore) => _hasMore = hasMore;
  changeHasMore(bool hasMore) {_hasMore = hasMore; notifyListeners();}

  ViewStyle _viewStyle = ViewStyle.list;
  ViewStyle get viewStyle => _viewStyle;
  setViewStyle(ViewStyle viewStyle) => _viewStyle = viewStyle;
  changeViewStyle(ViewStyle viewStyle) {_viewStyle = viewStyle; notifyListeners();}

  ScrollController scrollController = ScrollController();
  PaginationModel? paginationModel;
  int limit = 20;
  int page = 1;
  JobStatus? jobStatus;

  Future<void> addListenerScrollController() async {
    scrollController.addListener(() async {
      if(_dataState != DataState.done) return;
      if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent)) {
        await fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    if(!_hasMore) return;
    changeDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'isAvailable': true});
    filtersMap.addAll({'jobStatus': JobStatus.active.name});

    GetJobsParameters parameters = GetJobsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.jobsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, JobsResponse> response = await DependencyInjection.getJobsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInJobs(data.jobs);
      if(jobs.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _jobs.clear();
    setDataState(DataState.loading);
    setIsScreenDisposed(false);
    setHasMore(true);
    page = 1;
  }

  Future<void> reFetchData() async {
    if(_dataState == DataState.loading) return;
    _resetVariablesToDefault();
    await fetchData();
  }
  // endregion

  // region Insert Employment Application
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  Future<void> insertEmploymentApplication({required BuildContext context, required InsertEmploymentApplicationParameters insertEmploymentApplicationParameters}) async {
    changeIsLoading(true);
    Either<Failure, EmploymentApplicationModel> response = await DependencyInjection.insertEmploymentApplicationUseCase.call(insertEmploymentApplicationParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (employmentApplication) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.yourJobApplicationHasBeenSentSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
      );
    });
  }
  // endregion

  // region Delete Job
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteJob({required BuildContext context, required int jobId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteJobUseCase.call(DeleteJobParameters(jobId: jobId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromJobs(jobId);
      if(paginationModel != null) paginationModel!.total--;
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.deletedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
      );
    });
  }
  // endregion
}