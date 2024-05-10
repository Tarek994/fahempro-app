import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/employment_application_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/response/employment_applications_response.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/delete_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/get_employment_applications_usecase.dart';

class EmploymentApplicationsProvider with ChangeNotifier {
  final EmploymentApplicationsArgs? employmentApplicationsArgs;

  EmploymentApplicationsProvider({this.employmentApplicationsArgs});

  // region Get EmploymentApplications
  final List<EmploymentApplicationModel> _employmentApplications = [];
  List<EmploymentApplicationModel> get employmentApplications => _employmentApplications;
  addAllInEmploymentApplications(List<EmploymentApplicationModel> employmentApplications) {_employmentApplications.addAll(employmentApplications); notifyListeners();}
  insertInEmploymentApplications(EmploymentApplicationModel employmentApplicationModel) {_employmentApplications.insert(0, employmentApplicationModel); notifyListeners();}
  editInEmploymentApplications(EmploymentApplicationModel employmentApplicationModel) {
    int index = _employmentApplications.indexWhere((element) => element.employmentApplicationId == employmentApplicationModel.employmentApplicationId);
    if(index != -1) {
      _employmentApplications[index] = employmentApplicationModel;
      notifyListeners();
    }
  }
  _deleteFromEmploymentApplications(int employmentApplicationId) {
    int index = _employmentApplications.indexWhere((element) => element.employmentApplicationId == employmentApplicationId);
    if(index != -1) {
      _employmentApplications.removeAt(index);
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
    if(employmentApplicationsArgs != null) {
      if(employmentApplicationsArgs!.job != null) {
        filtersMap.addAll({'job': employmentApplicationsArgs!.job!.jobId});
      }
      if(employmentApplicationsArgs!.account != null) {
        filtersMap.addAll({Filters.account.name: employmentApplicationsArgs!.account!.accountId});
      }
    }

    GetEmploymentApplicationsParameters parameters = GetEmploymentApplicationsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.employmentApplicationsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, EmploymentApplicationsResponse> response = await DependencyInjection.getEmploymentApplicationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInEmploymentApplications(data.employmentApplications);
      if(employmentApplications.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _employmentApplications.clear();
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

  // region Delete EmploymentApplication
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteEmploymentApplication({required BuildContext context, required int employmentApplicationId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteEmploymentApplicationUseCase.call(DeleteEmploymentApplicationParameters(employmentApplicationId: employmentApplicationId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromEmploymentApplications(employmentApplicationId);
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