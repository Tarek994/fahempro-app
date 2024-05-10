// import 'package:fahem/data/models/account_model.dart';
// import 'package:fahem/data/models/static/governorate_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class ServiceProvider with ChangeNotifier {
//
//   late double myCurrentPositionLatitude;
//   late double myCurrentPositionLongitude;
//
//   late GovernorateModel _selectedGovernmentModel;
//   GovernorateModel get selectedGovernmentModel => _selectedGovernmentModel;
//   setSelectedGovernmentModel(GovernorateModel selectedGovernmentModel) => _selectedGovernmentModel = selectedGovernmentModel;
//   changeSelectedGovernmentModel(GovernorateModel selectedGovernmentModel) {_selectedGovernmentModel = selectedGovernmentModel; notifyListeners();}
//
//   List<AccountModel> _debtCollection = [];
//   List<AccountModel> get debtCollection => _debtCollection;
//   setDebtCollection(List<AccountModel> debtCollection) => _debtCollection = debtCollection;
//   changeDebtCollection(List<AccountModel> debtCollection) {
//     _debtCollection = debtCollection;
//     showDataInList(isResetData: true, isRefresh: true, isScrollUp: true);
//     notifyListeners();
//   }
//
//   late GoogleMapController googleMapController;
//
//   Set<Marker> _markers = {};
//   Set<Marker> get markers => _markers;
//   setMakers(Set<Marker> markers) => _markers = markers;
//   changeMakers(Set<Marker> markers) {_markers = markers; notifyListeners();}
//
//   // Start Pagination //
//   int _numberOfItems = 0;
//   int get numberOfItems => _numberOfItems;
//   setNumberOfItems(int numberOfItems) => _numberOfItems = numberOfItems;
//   changeNumberOfItems(int numberOfItems) {_numberOfItems = numberOfItems; notifyListeners();}
//
//   bool _hasMoreData = true;
//   bool get hasMoreData => _hasMoreData;
//   setHasMoreData(bool hasMoreData) => _hasMoreData = hasMoreData;
//   changeHasMoreData(bool hasMoreData) {_hasMoreData = hasMoreData;  notifyListeners();}
//
//   late ScrollController _scrollController;
//   ScrollController get scrollController => _scrollController;
//   initScrollController() {
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       if(_scrollController.offset == _scrollController.position.maxScrollExtent) {
//         showDataInList(isResetData: false, isRefresh: true, isScrollUp: false);
//       }
//     });
//   }
//   disposeScrollController() => _scrollController.dispose();
//   _scrollUp() => _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
//
//   int limit = 10;
//
//   void showDataInList({required bool isResetData, required bool isRefresh, required bool isScrollUp}) async {
//     try { // Check scrollController created or not & hasClients or not
//       if(_scrollController.hasClients) {
//         if(isScrollUp) {_scrollUp();}
//       }
//     }
//     catch(error) {
//       debugPrint(error.toString());
//     }
//
//     if(isResetData) {
//       setNumberOfItems(0);
//       setHasMoreData(true);
//     }
//
//     if(_hasMoreData) {
//       List list = _debtCollection;
//       if(isRefresh) {changeNumberOfItems(_numberOfItems += (list.length - numberOfItems) >= limit ? limit : (list.length - numberOfItems));}
//       if(!isRefresh) {setNumberOfItems(_numberOfItems += (list.length - numberOfItems) >= limit ? limit : (list.length - numberOfItems));}
//       debugPrint('numberOfItems: $_numberOfItems');
//
//       if(numberOfItems == list.length) {
//         if(isRefresh) {changeHasMoreData(false);}
//         if(!isRefresh) {setHasMoreData(false);}
//       }
//     }
//   }
//   // End Pagination //
// }





import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/service_model.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/accounts_response.dart';
import 'package:fahem/domain/usecases/accounts/delete_account_usecase.dart';
import 'package:fahem/domain/usecases/accounts/get_accounts_usecase.dart';

class ServiceProvider with ChangeNotifier {
  final ServiceModel service;

  ServiceProvider({required this.service});

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
    filtersMap.addAll({'service': service.serviceId});

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

  void _resetVariablesToDefault() {
    _accounts.clear();
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

  // region Delete Account
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteAccount({required BuildContext context, required int accountId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteAccountUseCase.call(DeleteAccountParameters(accountId: accountId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromAccounts(accountId);
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