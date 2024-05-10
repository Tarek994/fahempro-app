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
import 'package:fahem_dashboard/data/models/admin_notification_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/response/admin_notifications_response.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/delete_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notifications_usecase.dart';

class AdminNotificationsProvider with ChangeNotifier {

  // region Get AdminNotifications
  final List<AdminNotificationModel> _adminNotifications = [];
  List<AdminNotificationModel> get adminNotifications => _adminNotifications;
  addAllInAdminNotifications(List<AdminNotificationModel> adminNotifications) {_adminNotifications.addAll(adminNotifications); notifyListeners();}
  insertInAdminNotifications(AdminNotificationModel adminNotificationModel) {_adminNotifications.insert(0, adminNotificationModel); notifyListeners();}
  editInAdminNotifications(AdminNotificationModel adminNotificationModel) {
    int index = _adminNotifications.indexWhere((element) => element.adminNotificationId == adminNotificationModel.adminNotificationId);
    if(index != -1) {
      _adminNotifications[index] = adminNotificationModel;
      notifyListeners();
    }
  }
  _deleteFromAdminNotifications(int adminNotificationId) {
    int index = _adminNotifications.indexWhere((element) => element.adminNotificationId == adminNotificationId);
    if(index != -1) {
      _adminNotifications.removeAt(index);
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
    GetAdminNotificationsParameters parameters = GetAdminNotificationsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.adminNotificationsNewestFirst,
      filtersMap: globalFilters,
    );
    Either<Failure, AdminNotificationsResponse> response = await DependencyInjection.getAdminNotificationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInAdminNotifications(data.adminNotifications);
      if(adminNotifications.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _adminNotifications.clear();
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

  // region Delete AdminNotification
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteAdminNotification({required BuildContext context, required int adminNotificationId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteAdminNotificationUseCase.call(DeleteAdminNotificationParameters(adminNotificationId: adminNotificationId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromAdminNotifications(adminNotificationId);
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