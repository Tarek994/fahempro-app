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
import 'package:fahem_business/data/models/wallet_history_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/wallet_history_response.dart';
import 'package:fahem_business/domain/usecases/wallet_history/delete_wallet_history_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/get_wallet_history_usecase.dart';

class WalletHistoryProvider with ChangeNotifier {
  final WalletHistoryArgs? walletHistoryArgs;

  WalletHistoryProvider({this.walletHistoryArgs});

  // region Get WalletHistory
  final List<WalletHistoryModel> _walletHistory = [];
  List<WalletHistoryModel> get walletHistory => _walletHistory;
  addAllInWalletHistory(List<WalletHistoryModel> walletHistory) {_walletHistory.addAll(walletHistory); notifyListeners();}
  insertInWalletHistory(WalletHistoryModel walletHistoryModel) {_walletHistory.insert(0, walletHistoryModel); notifyListeners();}
  editInWalletHistory(WalletHistoryModel walletHistoryModel) {
    int index = _walletHistory.indexWhere((element) => element.walletHistoryId == walletHistoryModel.walletHistoryId);
    if(index != -1) {
      _walletHistory[index] = walletHistoryModel;
      notifyListeners();
    }
  }
  _deleteFromWalletHistory(int walletHistoryId) {
    int index = _walletHistory.indexWhere((element) => element.walletHistoryId == walletHistoryId);
    if(index != -1) {
      _walletHistory.removeAt(index);
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
    if(walletHistoryArgs != null) {
      if(walletHistoryArgs!.account != null) {
        filtersMap.addAll({Filters.account.name: walletHistoryArgs!.account!.accountId});
      }
      if(walletHistoryArgs!.user != null) {
        filtersMap.addAll({Filters.user.name: walletHistoryArgs!.user!.userId});
        if(walletHistoryArgs!.isRevenueOnly) {
          filtersMap.addAll({
            'customWhere': '(walletTransactionType = "${WalletTransactionType.chargeWallet.name}" OR walletTransactionType = "${WalletTransactionType.instantConsultation.name}" OR walletTransactionType = "${WalletTransactionType.secretConsultation.name}")'
          });
        }
      }
    }

    GetWalletHistoryParameters parameters = GetWalletHistoryParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.walletHistoryNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, WalletHistoryResponse> response = await DependencyInjection.getWalletHistoryUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInWalletHistory(data.walletHistory);
      if(walletHistory.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _walletHistory.clear();
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

  // region Delete WalletHistory
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteWalletHistory({required BuildContext context, required int walletHistoryId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteWalletHistoryUseCase.call(DeleteWalletHistoryParameters(walletHistoryId: walletHistoryId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromWalletHistory(walletHistoryId);
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