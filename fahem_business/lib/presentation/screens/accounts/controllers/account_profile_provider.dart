import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/jobs_response.dart';
import 'package:fahem_business/domain/usecases/jobs/get_jobs_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';

enum AccountProfilePages {accountJobs, accountSeekers}

class AccountProfileProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  AccountProfilePages _currentAccountProfilePage = AccountProfilePages.accountJobs;
  AccountProfilePages get currentAccountProfilePage => _currentAccountProfilePage;
  setCurrentAccountProfilePage(AccountProfilePages accountProfilePage) async {_currentAccountProfilePage = accountProfilePage;}

  // region Get Account Jobs
  final List<JobModel> _accountJobs = [];
  List<JobModel> get accountJobs => _accountJobs;
  addAllInAccountJobs(List<JobModel> accountJobs) {_accountJobs.addAll(accountJobs); notifyListeners();}

  DataState _accountJobsDataState = DataState.loading;
  DataState get accountJobsDataState => _accountJobsDataState;
  setAccountJobsDataState(DataState accountJobsDataState) => _accountJobsDataState = accountJobsDataState;
  changeAccountJobsDataState(DataState accountJobsDataState) {_accountJobsDataState = accountJobsDataState; notifyListeners();}

  bool _accountJobsHasMore = true;
  bool get accountJobsHasMore => _accountJobsHasMore;
  setAccountJobsHasMore(bool accountJobsHasMore) => _accountJobsHasMore = accountJobsHasMore;
  changeAccountJobsHasMore(bool accountJobsHasMore) {_accountJobsHasMore = accountJobsHasMore; notifyListeners();}

  ViewStyle _accountJobsViewStyle = ViewStyle.list;
  ViewStyle get accountJobsViewStyle => _accountJobsViewStyle;
  setAccountJobsViewStyle(ViewStyle accountJobsViewStyle) => _accountJobsViewStyle = accountJobsViewStyle;
  changeAccountJobsViewStyle(ViewStyle accountJobsViewStyle) {_accountJobsViewStyle = accountJobsViewStyle; notifyListeners();}

  ScrollController accountJobsScrollController = ScrollController();
  PaginationModel? accountJobsPaginationModel;
  int accountJobsLimit = 20;
  int accountJobsPage = 1;

  Future<void> accountJobsAddListenerScrollController({required int accountId}) async {
    accountJobsScrollController.addListener(() async {
      if(_accountJobsDataState != DataState.done) return;
      if(accountJobsScrollController.position.pixels >= (accountJobsScrollController.position.maxScrollExtent)) {
        await fetchAccountJobs(accountId: accountId);
      }
    });
  }

  Future<void> fetchAccountJobs({required int accountId}) async {
    if(!_accountJobsHasMore) return;
    changeAccountJobsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'account': accountId});

    GetJobsParameters parameters = GetJobsParameters(
      isPaginated: true,
      limit: accountJobsLimit,
      page: accountJobsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.jobsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, JobsResponse> response = await DependencyInjection.getJobsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeAccountJobsDataState(DataState.error);
    }, (data) async {
      accountJobsPaginationModel = data.pagination;
      addAllInAccountJobs(data.jobs);
      if(_accountJobs.length == accountJobsPaginationModel!.total) {changeAccountJobsHasMore(false);}
      if(accountJobsPaginationModel!.total == 0) {changeAccountJobsDataState(DataState.empty);}
      else {changeAccountJobsDataState(DataState.done);}
      accountJobsPage += 1;
    });
  }

  void _resetAccountJobsVariablesToDefault() {
    _accountJobs.clear();
    setAccountJobsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setAccountJobsHasMore(true);
    accountJobsPage = 1;
  }

  Future<void> reFetchAccountJobs({required int accountId}) async {
    if(_accountJobsDataState == DataState.loading) return;
    _resetAccountJobsVariablesToDefault();
    await fetchAccountJobs(accountId: accountId);
  }
  // endregion
}