import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/service_model.dart';
import 'package:fahem/data/models/slider_model.dart';
import 'package:fahem/data/response/jobs_response.dart';
import 'package:fahem/data/response/main_categories_response.dart';
import 'package:fahem/data/response/playlists_response.dart';
import 'package:fahem/data/response/services_response.dart';
import 'package:fahem/data/response/sliders_response.dart';
import 'package:fahem/domain/usecases/jobs/get_jobs_usecase.dart';
import 'package:fahem/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem/domain/usecases/playlists/get_playlists_usecase.dart';
import 'package:fahem/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem/domain/usecases/sliders/get_sliders_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/methods.dart';

class HomeProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  // region Get Main Categories
  List<MainCategoryModel> _mainCategories = [];
  List<MainCategoryModel> get mainCategories => _mainCategories;
  setMainCategories(List<MainCategoryModel> mainCategories) => _mainCategories = mainCategories;

  DataState _mainCategoriesDataState = DataState.loading;
  DataState get mainCategoriesDataState => _mainCategoriesDataState;
  setMainCategoriesDataState(DataState mainCategoriesDataState) => _mainCategoriesDataState = mainCategoriesDataState;
  changeMainCategoriesDataState(DataState mainCategoriesDataState) {_mainCategoriesDataState = mainCategoriesDataState; notifyListeners();}

  Future<void> fetchMainCategories() async {
    changeMainCategoriesDataState(DataState.loading);
    GetMainCategoriesParameters parameters = GetMainCategoriesParameters(
      orderBy: OrderByType.customOrderAsc,
    );
    Either<Failure, MainCategoriesResponse> response = await DependencyInjection.getMainCategoriesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeMainCategoriesDataState(DataState.error);
    }, (mainCategoriesResponse) async {
      setMainCategories(mainCategoriesResponse.mainCategories);
      if(mainCategoriesResponse.mainCategories.isEmpty) {changeMainCategoriesDataState(DataState.empty);}
      else {changeMainCategoriesDataState(DataState.done);}
    });
  }

  void _resetMainCategoriesVariablesToDefault() {
    _mainCategories.clear();
    setMainCategoriesDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchMainCategories() async {
    if(_mainCategoriesDataState == DataState.loading) return;
    _resetMainCategoriesVariablesToDefault();
    await fetchMainCategories();
  }
  // endregion

  // region Sliders
  // region Get Sliders
  List<SliderModel> _sliders = [];
  List<SliderModel> get sliders => _sliders;
  setSliders(List<SliderModel> sliders) => _sliders = sliders;

  DataState _slidersDataState = DataState.loading;
  DataState get slidersDataState => _slidersDataState;
  setSlidersDataState(DataState slidersDataState) => _slidersDataState = slidersDataState;
  changeSlidersDataState(DataState slidersDataState) {_slidersDataState = slidersDataState; notifyListeners();}

  Future<void> fetchSliders() async {
    changeSlidersDataState(DataState.loading);
    Either<Failure, SlidersResponse> response = await DependencyInjection.getSlidersUseCase.call(GetSlidersParameters());
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeSlidersDataState(DataState.error);
    }, (slidersResponse) async {
      setSliders(slidersResponse.sliders);
      if(slidersResponse.sliders.isEmpty) {changeSlidersDataState(DataState.empty);}
      else {changeSlidersDataState(DataState.done);}
    });
  }

  void _resetSlidersVariablesToDefault() {
    _sliders.clear();
    setSlidersDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchSliders() async {
    if(_slidersDataState == DataState.loading) return;
    _resetSlidersVariablesToDefault();
    await fetchSliders();
  }
  // endregion

  int _currentSliderIndex = 0;
  int get currentSliderIndex => _currentSliderIndex;
  changeCurrentSliderIndex(int index) {_currentSliderIndex = index; notifyListeners();}
  // endregion

  // region Get Services
  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;
  setServices(List<ServiceModel> services) => _services = services;

  DataState _servicesDataState = DataState.loading;
  DataState get servicesDataState => _servicesDataState;
  setServicesDataState(DataState servicesDataState) => _servicesDataState = servicesDataState;
  changeServicesDataState(DataState servicesDataState) {_servicesDataState = servicesDataState; notifyListeners();}

  Future<void> fetchServices() async {
    changeServicesDataState(DataState.loading);
    GetServicesParameters parameters = GetServicesParameters(
      orderBy: OrderByType.customOrderAsc,
    );
    Either<Failure, ServicesResponse> response = await DependencyInjection.getServicesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeServicesDataState(DataState.error);
    }, (servicesResponse) async {
      setServices(servicesResponse.services);
      if(servicesResponse.services.isEmpty) {changeServicesDataState(DataState.empty);}
      else {changeServicesDataState(DataState.done);}
    });
  }

  void _resetServicesVariablesToDefault() {
    _services.clear();
    setServicesDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchServices() async {
    if(_servicesDataState == DataState.loading) return;
    _resetServicesVariablesToDefault();
    await fetchServices();
  }
  // endregion

  // region Get Latest Jobs
  List<JobModel> _latestJobs = [];
  List<JobModel> get latestJobs => _latestJobs;
  setLatestJobs(List<JobModel> latestJobs) => _latestJobs = latestJobs;

  DataState _latestJobsDataState = DataState.loading;
  DataState get latestJobsDataState => _latestJobsDataState;
  setLatestJobsDataState(DataState latestJobsDataState) => _latestJobsDataState = latestJobsDataState;
  changeLatestJobsDataState(DataState latestJobsDataState) {_latestJobsDataState = latestJobsDataState; notifyListeners();}

  Future<void> fetchLatestJobs() async {
    changeLatestJobsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    filtersMap.addAll({'isAvailable': true});
    filtersMap.addAll({'jobStatus': JobStatus.active.name});

    GetJobsParameters parameters = GetJobsParameters(
      isPaginated: true,
      limit: 10,
      filtersMap: jsonEncode(filtersMap),
      // currentUserId: MyProviders.authenticationProvider.currentUser.userId,
    );
    Either<Failure, JobsResponse> response = await DependencyInjection.getJobsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeLatestJobsDataState(DataState.error);
    }, (jobsResponse) async {
      setLatestJobs(jobsResponse.jobs);
      if(jobsResponse.jobs.isEmpty) {changeLatestJobsDataState(DataState.empty);}
      else {changeLatestJobsDataState(DataState.done);}
    });
  }

  void _resetLatestJobsVariablesToDefault() {
    _latestJobs.clear();
    setLatestJobsDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchLatestJobs() async {
    if(_latestJobsDataState == DataState.loading) return;
    _resetLatestJobsVariablesToDefault();
    await fetchLatestJobs();
  }
  // endregion

  // region Get Playlists
  List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => _playlists;
  setPlaylists(List<PlaylistModel> playlists) => _playlists = playlists;
  editInPlaylists(PlaylistModel playlistModel) {
    int index = _playlists.indexWhere((element) => element.playlistId == playlistModel.playlistId);
    if(index != -1) {
      _playlists[index] = playlistModel;
      notifyListeners();
    }
  }

  DataState _playlistsDataState = DataState.loading;
  DataState get playlistsDataState => _playlistsDataState;
  setPlaylistsDataState(DataState playlistsDataState) => _playlistsDataState = playlistsDataState;
  changePlaylistsDataState(DataState playlistsDataState) {_playlistsDataState = playlistsDataState; notifyListeners();}

  Future<void> fetchPlaylists() async {
    changePlaylistsDataState(DataState.loading);
    GetPlaylistsParameters parameters = GetPlaylistsParameters(
      isPaginated: true,
      limit: 10,
    );
    Either<Failure, PlaylistsResponse> response = await DependencyInjection.getPlaylistsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changePlaylistsDataState(DataState.error);
    }, (playlistsResponse) async {
      setPlaylists(playlistsResponse.playlists);
      if(playlistsResponse.playlists.isEmpty) {changePlaylistsDataState(DataState.empty);}
      else {changePlaylistsDataState(DataState.done);}
    });
  }

  void _resetPlaylistsVariablesToDefault() {
    _playlists.clear();
    setPlaylistsDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchPlaylists() async {
    if(_playlistsDataState == DataState.loading) return;
    _resetPlaylistsVariablesToDefault();
    await fetchPlaylists();
  }
  // endregion
}