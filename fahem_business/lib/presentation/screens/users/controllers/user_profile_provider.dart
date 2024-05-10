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

enum UserProfilePages {userJobs, userSeekers}

class UserProfileProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  UserProfilePages _currentUserProfilePage = UserProfilePages.userJobs;
  UserProfilePages get currentUserProfilePage => _currentUserProfilePage;
  setCurrentUserProfilePage(UserProfilePages userProfilePage) async {_currentUserProfilePage = userProfilePage;}

  // region Get User Jobs
  final List<JobModel> _userJobs = [];
  List<JobModel> get userJobs => _userJobs;
  addAllInUserJobs(List<JobModel> userJobs) {_userJobs.addAll(userJobs); notifyListeners();}

  DataState _userJobsDataState = DataState.loading;
  DataState get userJobsDataState => _userJobsDataState;
  setUserJobsDataState(DataState userJobsDataState) => _userJobsDataState = userJobsDataState;
  changeUserJobsDataState(DataState userJobsDataState) {_userJobsDataState = userJobsDataState; notifyListeners();}

  bool _userJobsHasMore = true;
  bool get userJobsHasMore => _userJobsHasMore;
  setUserJobsHasMore(bool userJobsHasMore) => _userJobsHasMore = userJobsHasMore;
  changeUserJobsHasMore(bool userJobsHasMore) {_userJobsHasMore = userJobsHasMore; notifyListeners();}

  ViewStyle _userJobsViewStyle = ViewStyle.list;
  ViewStyle get userJobsViewStyle => _userJobsViewStyle;
  setUserJobsViewStyle(ViewStyle userJobsViewStyle) => _userJobsViewStyle = userJobsViewStyle;
  changeUserJobsViewStyle(ViewStyle userJobsViewStyle) {_userJobsViewStyle = userJobsViewStyle; notifyListeners();}

  ScrollController userJobsScrollController = ScrollController();
  PaginationModel? userJobsPaginationModel;
  int userJobsLimit = 20;
  int userJobsPage = 1;

  Future<void> userJobsAddListenerScrollController({required int userId}) async {
    userJobsScrollController.addListener(() async {
      if(_userJobsDataState != DataState.done) return;
      if(userJobsScrollController.position.pixels >= (userJobsScrollController.position.maxScrollExtent)) {
        await fetchUserJobs(userId: userId);
      }
    });
  }

  Future<void> fetchUserJobs({required int userId}) async {
    if(!_userJobsHasMore) return;
    changeUserJobsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'user': userId});

    GetJobsParameters parameters = GetJobsParameters(
      isPaginated: true,
      limit: userJobsLimit,
      page: userJobsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.jobsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, JobsResponse> response = await DependencyInjection.getJobsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeUserJobsDataState(DataState.error);
    }, (data) async {
      userJobsPaginationModel = data.pagination;
      addAllInUserJobs(data.jobs);
      if(_userJobs.length == userJobsPaginationModel!.total) {changeUserJobsHasMore(false);}
      if(userJobsPaginationModel!.total == 0) {changeUserJobsDataState(DataState.empty);}
      else {changeUserJobsDataState(DataState.done);}
      userJobsPage += 1;
    });
  }

  void _resetUserJobsVariablesToDefault() {
    _userJobs.clear();
    setUserJobsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setUserJobsHasMore(true);
    userJobsPage = 1;
  }

  Future<void> reFetchUserJobs({required int userId}) async {
    if(_userJobsDataState == DataState.loading) return;
    _resetUserJobsVariablesToDefault();
    await fetchUserJobs(userId: userId);
  }
  // endregion
}