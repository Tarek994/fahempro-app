import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/privacy_policy_model.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class PrivacyPolicyProvider with ChangeNotifier {

  // region Get Privacy Policy
  late PrivacyPolicyModel _privacyPolicyModel;
  PrivacyPolicyModel get privacyPolicyModel => _privacyPolicyModel;
  setPrivacyPolicy(PrivacyPolicyModel privacyPolicyModel) => _privacyPolicyModel = privacyPolicyModel;
  editPrivacyPolicy(PrivacyPolicyModel privacyPolicyModel) {_privacyPolicyModel = privacyPolicyModel; notifyListeners();}

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  Future<void> fetchData() async {
    changeDataState(DataState.loading);
    Either<Failure, PrivacyPolicyModel> response = await DependencyInjection.getPrivacyPolicyUseCase.call(const NoParameters());
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      setPrivacyPolicy(data);
      changeDataState(DataState.done);
    });
  }

  void _resetVariablesToDefault() {
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