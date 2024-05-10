import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/statistic_model.dart';
import 'package:fahem_dashboard/domain/usecases/statistics/get_admin_statistics_usecase.dart';

class AdminStatisticsProvider with ChangeNotifier {

  // region Get Admin Statistics
  List<StatisticModel> _adminStatistics = [];
  List<StatisticModel> get adminStatistics => _adminStatistics;
  setAdminStatistics(List<StatisticModel> adminStatistics) => _adminStatistics = adminStatistics;

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  Future<void> fetchData() async {
    DateTime dateTime = DateTime.now();
    int startTimeToday = Methods.extractStartTime(dateTime);
    int endTimeToday = Methods.extractEndTime(dateTime);
    int startThisMonth = Methods.extractStartThisMonth(dateTime);
    int endThisMonth = Methods.extractEndThisMonth(dateTime);
    int startLastMonth = Methods.extractStartLastMonth(dateTime);
    int endLastMonth = Methods.extractEndLastMonth(dateTime);

    changeDataState(DataState.loading);
    GetAdminStatisticsParameters parameters = GetAdminStatisticsParameters(
      startTimeToday: startTimeToday,
      endTimeToday: endTimeToday,
      startThisMonth: startThisMonth,
      endThisMonth: endThisMonth,
      startLastMonth: startLastMonth,
      endLastMonth: endLastMonth,
    );
    Either<Failure, List<StatisticModel>> response = await DependencyInjection.getAdminStatisticsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      setAdminStatistics(data);
      if(data.isEmpty) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
    });
  }

  void _resetVariablesToDefault() {
    _adminStatistics.clear();
    setDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchData() async {
    if(_dataState == DataState.loading) return;
    _resetVariablesToDefault();
    await fetchData();
  }
  // endregion
}