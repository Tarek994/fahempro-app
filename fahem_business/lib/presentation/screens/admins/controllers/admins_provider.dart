import 'package:dartz/dartz.dart';
import 'package:fahem_business/data/models/admin_model.dart';
import 'package:fahem_business/domain/usecases/admins/get_admins_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/delete_admin_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/admins_response.dart';

class AdminsProvider with ChangeNotifier {

  // region Get Admins
  final List<AdminModel> _admins = [];
  List<AdminModel> get admins => _admins;
  addAllInAdmins(List<AdminModel> admins) {_admins.addAll(admins); notifyListeners();}
  insertInAdmins(AdminModel adminModel) {_admins.insert(0, adminModel); notifyListeners();}
  editInAdmins(AdminModel adminModel) {
    int index = _admins.indexWhere((element) => element.adminId == adminModel.adminId);
    if(index != -1) {
      _admins[index] = adminModel;
      notifyListeners();
    }
  }
  _deleteFromAdmins(int adminId) {
    int index = _admins.indexWhere((element) => element.adminId == adminId);
    if(index != -1) {
      _admins.removeAt(index);
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
    GetAdminsParameters parameters = GetAdminsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.adminsNewestFirst,
      filtersMap: globalFilters,
    );
    Either<Failure, AdminsResponse> response = await DependencyInjection.getAdminsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInAdmins(data.admins);
      if(admins.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _admins.clear();
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

  // region Delete Admin
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteAdmin({required BuildContext context, required int adminId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteAdminUseCase.call(DeleteAdminParameters(adminId: adminId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromAdmins(adminId);
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