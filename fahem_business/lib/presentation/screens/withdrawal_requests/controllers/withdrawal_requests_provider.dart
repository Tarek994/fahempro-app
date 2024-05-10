import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/withdrawal_request_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/withdrawal_requests_response.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/delete_withdrawal_request_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/get_withdrawal_requests_usecase.dart';

class WithdrawalRequestsProvider with ChangeNotifier {
  final WithdrawalRequestsArgs? withdrawalRequestsArgs;

  WithdrawalRequestsProvider({this.withdrawalRequestsArgs});

  // region Get WithdrawalRequests
  final List<WithdrawalRequestModel> _withdrawalRequests = [];
  List<WithdrawalRequestModel> get withdrawalRequests => _withdrawalRequests;
  addAllInWithdrawalRequests(List<WithdrawalRequestModel> withdrawalRequests) {_withdrawalRequests.addAll(withdrawalRequests); notifyListeners();}
  insertInWithdrawalRequests(WithdrawalRequestModel withdrawalRequestModel) {_withdrawalRequests.insert(0, withdrawalRequestModel); notifyListeners();}
  editInWithdrawalRequests(WithdrawalRequestModel withdrawalRequestModel) {
    int index = _withdrawalRequests.indexWhere((element) => element.withdrawalRequestId == withdrawalRequestModel.withdrawalRequestId);
    if(index != -1) {
      _withdrawalRequests[index] = withdrawalRequestModel;
      notifyListeners();
    }
  }
  _deleteFromWithdrawalRequests(int withdrawalRequestId) {
    int index = _withdrawalRequests.indexWhere((element) => element.withdrawalRequestId == withdrawalRequestId);
    if(index != -1) {
      _withdrawalRequests.removeAt(index);
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
    filtersMap.addAll({Filters.account.name: MyProviders.authenticationProvider.currentAccount.accountId});
    if(withdrawalRequestsArgs != null) {
      filtersMap.addAll({Filters.account.name: withdrawalRequestsArgs!.account.accountId});
      filtersMap.addAll({Filters.withdrawalRequestStatus.name: WithdrawalRequestStatus.done.name});
    }

    GetWithdrawalRequestsParameters parameters = GetWithdrawalRequestsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.withdrawalRequestsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, WithdrawalRequestsResponse> response = await DependencyInjection.getWithdrawalRequestsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInWithdrawalRequests(data.withdrawalRequests);
      if(withdrawalRequests.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _withdrawalRequests.clear();
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

  // region Delete WithdrawalRequest
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteWithdrawalRequest({required BuildContext context, required int withdrawalRequestId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteWithdrawalRequestUseCase.call(DeleteWithdrawalRequestParameters(withdrawalRequestId: withdrawalRequestId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromWithdrawalRequests(withdrawalRequestId);
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