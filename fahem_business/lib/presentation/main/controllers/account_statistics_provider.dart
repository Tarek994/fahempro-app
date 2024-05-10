import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/statistic_model.dart';
import 'package:fahem_business/domain/usecases/statistics/get_account_statistics_usecase.dart';

class AccountStatisticsProvider with ChangeNotifier {

  // region Get Account Statistics
  List<StatisticModel> _accountStatistics = [];
  List<StatisticModel> get accountStatistics => _accountStatistics;
  setAccountStatistics(List<StatisticModel> accountStatistics) => _accountStatistics = accountStatistics;

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
    GetAccountStatisticsParameters parameters = GetAccountStatisticsParameters(
      startTimeToday: startTimeToday,
      endTimeToday: endTimeToday,
      startThisMonth: startThisMonth,
      endThisMonth: endThisMonth,
      startLastMonth: startLastMonth,
      endLastMonth: endLastMonth,
      accountId: MyProviders.authenticationProvider.currentAccount.accountId,
    );
    Either<Failure, List<StatisticModel>> response = await DependencyInjection.getAccountStatisticsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      setAccountStatistics(data);
      if(data.isEmpty) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
    });
  }

  void _resetVariablesToDefault() {
    _accountStatistics.clear();
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