import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/response/secret_consultations_response.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/delete_secret_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/get_secret_consultations_usecase.dart';

class SecretConsultationsProvider with ChangeNotifier {

  // region Get SecretConsultations
  final List<SecretConsultationModel> _secretConsultations = [];
  List<SecretConsultationModel> get secretConsultations => _secretConsultations;
  addAllInSecretConsultations(List<SecretConsultationModel> secretConsultations) {_secretConsultations.addAll(secretConsultations); notifyListeners();}
  insertInSecretConsultations(SecretConsultationModel secretConsultationModel) {_secretConsultations.insert(0, secretConsultationModel); notifyListeners();}
  editInSecretConsultations(SecretConsultationModel secretConsultationModel) {
    int index = _secretConsultations.indexWhere((element) => element.secretConsultationId == secretConsultationModel.secretConsultationId);
    if(index != -1) {
      _secretConsultations[index] = secretConsultationModel;
      notifyListeners();
    }
  }
  _deleteFromSecretConsultations(int secretConsultationId) {
    int index = _secretConsultations.indexWhere((element) => element.secretConsultationId == secretConsultationId);
    if(index != -1) {
      _secretConsultations.removeAt(index);
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

    GetSecretConsultationsParameters parameters = GetSecretConsultationsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.secretConsultationsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, SecretConsultationsResponse> response = await DependencyInjection.getSecretConsultationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInSecretConsultations(data.secretConsultations);
      if(secretConsultations.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _secretConsultations.clear();
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

  // region Delete SecretConsultation
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteSecretConsultation({required BuildContext context, required int secretConsultationId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteSecretConsultationUseCase.call(DeleteSecretConsultationParameters(secretConsultationId: secretConsultationId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromSecretConsultations(secretConsultationId);
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