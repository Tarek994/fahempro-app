import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/instant_consultations_response.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/delete_instant_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';

class InstantConsultationsProvider with ChangeNotifier {

  // region Get InstantConsultations
  final List<InstantConsultationModel> _instantConsultations = [];
  List<InstantConsultationModel> get instantConsultations => _instantConsultations;
  addAllInInstantConsultations(List<InstantConsultationModel> instantConsultations) {_instantConsultations.addAll(instantConsultations); notifyListeners();}
  insertInInstantConsultations(InstantConsultationModel instantConsultationModel) {_instantConsultations.insert(0, instantConsultationModel); notifyListeners();}
  editInInstantConsultations(InstantConsultationModel instantConsultationModel) {
    int index = _instantConsultations.indexWhere((element) => element.instantConsultationId == instantConsultationModel.instantConsultationId);
    if(index != -1) {
      _instantConsultations[index] = instantConsultationModel;
      notifyListeners();
    }
  }
  _deleteFromInstantConsultations(int instantConsultationId) {
    int index = _instantConsultations.indexWhere((element) => element.instantConsultationId == instantConsultationId);
    if(index != -1) {
      _instantConsultations.removeAt(index);
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
    filtersMap.addAll({'isDone': false});

    GetInstantConsultationsParameters parameters = GetInstantConsultationsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.instantConsultationsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, InstantConsultationsResponse> response = await DependencyInjection.getInstantConsultationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInInstantConsultations(data.instantConsultations);
      if(instantConsultations.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _instantConsultations.clear();
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

  // region Delete InstantConsultation
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteInstantConsultation({required BuildContext context, required int instantConsultationId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteInstantConsultationUseCase.call(DeleteInstantConsultationParameters(instantConsultationId: instantConsultationId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromInstantConsultations(instantConsultationId);
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