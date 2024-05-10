import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
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
import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/phone_number_requests_response.dart';
import 'package:fahem/domain/usecases/phone_number_requests/delete_phone_number_request_usecase.dart';
import 'package:fahem/domain/usecases/phone_number_requests/get_phone_number_requests_usecase.dart';

class PhoneNumberRequestsProvider with ChangeNotifier {
  final PhoneNumberRequestsArgs? phoneNumberRequestsArgs;

  PhoneNumberRequestsProvider({this.phoneNumberRequestsArgs});

  // region Get PhoneNumberRequests
  final List<PhoneNumberRequestModel> _phoneNumberRequests = [];
  List<PhoneNumberRequestModel> get phoneNumberRequests => _phoneNumberRequests;
  addAllInPhoneNumberRequests(List<PhoneNumberRequestModel> phoneNumberRequests) {_phoneNumberRequests.addAll(phoneNumberRequests); notifyListeners();}
  insertInPhoneNumberRequests(PhoneNumberRequestModel phoneNumberRequestModel) {_phoneNumberRequests.insert(0, phoneNumberRequestModel); notifyListeners();}
  editInPhoneNumberRequests(PhoneNumberRequestModel phoneNumberRequestModel) {
    int index = _phoneNumberRequests.indexWhere((element) => element.phoneNumberRequestId == phoneNumberRequestModel.phoneNumberRequestId);
    if(index != -1) {
      _phoneNumberRequests[index] = phoneNumberRequestModel;
      notifyListeners();
    }
  }
  _deleteFromPhoneNumberRequests(int phoneNumberRequestId) {
    int index = _phoneNumberRequests.indexWhere((element) => element.phoneNumberRequestId == phoneNumberRequestId);
    if(index != -1) {
      _phoneNumberRequests.removeAt(index);
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
    // filtersMap.addAll({Filters.account.name: MyProviders.authenticationProvider.currentAccount.accountId});
    if(phoneNumberRequestsArgs != null) {
      if(phoneNumberRequestsArgs!.account != null) {
        filtersMap.addAll({Filters.account.name: phoneNumberRequestsArgs!.account!.accountId});
      }
    }

    GetPhoneNumberRequestsParameters parameters = GetPhoneNumberRequestsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.phoneNumberRequestsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, PhoneNumberRequestsResponse> response = await DependencyInjection.getPhoneNumberRequestsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInPhoneNumberRequests(data.phoneNumberRequests);
      if(phoneNumberRequests.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _phoneNumberRequests.clear();
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

  // region Delete PhoneNumberRequest
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deletePhoneNumberRequest({required BuildContext context, required int phoneNumberRequestId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deletePhoneNumberRequestUseCase.call(DeletePhoneNumberRequestParameters(phoneNumberRequestId: phoneNumberRequestId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromPhoneNumberRequests(phoneNumberRequestId);
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