import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/about_app_model.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class AboutAppProvider with ChangeNotifier {

  // region Get About App
  late AboutAppModel _aboutAppModel;
  AboutAppModel get aboutAppModel => _aboutAppModel;
  setAboutApp(AboutAppModel aboutAppModel) => _aboutAppModel = aboutAppModel;
  editAboutApp(AboutAppModel aboutAppModel) {_aboutAppModel = aboutAppModel; notifyListeners();}

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  Future<void> fetchData() async {
    changeDataState(DataState.loading);
    Either<Failure, AboutAppModel> response = await DependencyInjection.getAboutAppUseCase.call(const NoParameters());
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      setAboutApp(data);
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