import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/accounts_response.dart';
import 'package:fahem/domain/usecases/accounts/get_accounts_usecase.dart';

class SearchProvider with ChangeNotifier {

  // region Get Accounts
  final List<AccountModel> _accounts = [];
  List<AccountModel> get accounts => _accounts;
  addAllInAccounts(List<AccountModel> accounts) {_accounts.addAll(accounts); notifyListeners();}
  insertInAccounts(AccountModel accountModel) {_accounts.insert(0, accountModel); notifyListeners();}
  editInAccounts(AccountModel accountModel) {
    int index = _accounts.indexWhere((element) => element.accountId == accountModel.accountId);
    if(index != -1) {
      _accounts[index] = accountModel;
      notifyListeners();
    }
  }
  _deleteFromAccounts(int accountId) {
    int index = _accounts.indexWhere((element) => element.accountId == accountId);
    if(index != -1) {
      _accounts.removeAt(index);
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
    filtersMap.addAll({'accountStatus': AccountStatus.active.name});

    GetAccountsParameters parameters = GetAccountsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.highestRating,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, AccountsResponse> response = await DependencyInjection.getAccountsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInAccounts(data.accounts);
      if(accounts.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void resetVariablesToDefault() {
    _accounts.clear();
    setDataState(DataState.loading);
    setIsScreenDisposed(false);
    setHasMore(true);
    page = 1;
  }

  Future<void> reFetchData() async {
    if(_dataState == DataState.loading) return;
    resetVariablesToDefault();
    await fetchData();
  }
  // endregion
}