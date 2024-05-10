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
import 'package:fahem/data/models/booking_appointment_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/booking_appointments_response.dart';
import 'package:fahem/domain/usecases/booking_appointments/delete_booking_appointment_usecase.dart';
import 'package:fahem/domain/usecases/booking_appointments/get_booking_appointments_usecase.dart';

class BookingAppointmentsProvider with ChangeNotifier {
  final BookingAppointmentsArgs? bookingAppointmentsArgs;

  BookingAppointmentsProvider({this.bookingAppointmentsArgs});

  // region Get BookingAppointments
  final List<BookingAppointmentModel> _bookingAppointments = [];
  List<BookingAppointmentModel> get bookingAppointments => _bookingAppointments;
  addAllInBookingAppointments(List<BookingAppointmentModel> bookingAppointments) {_bookingAppointments.addAll(bookingAppointments); notifyListeners();}
  insertInBookingAppointments(BookingAppointmentModel bookingAppointmentModel) {_bookingAppointments.insert(0, bookingAppointmentModel); notifyListeners();}
  editInBookingAppointments(BookingAppointmentModel bookingAppointmentModel) {
    int index = _bookingAppointments.indexWhere((element) => element.bookingAppointmentId == bookingAppointmentModel.bookingAppointmentId);
    if(index != -1) {
      _bookingAppointments[index] = bookingAppointmentModel;
      notifyListeners();
    }
  }
  _deleteFromBookingAppointments(int bookingAppointmentId) {
    int index = _bookingAppointments.indexWhere((element) => element.bookingAppointmentId == bookingAppointmentId);
    if(index != -1) {
      _bookingAppointments.removeAt(index);
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
    if(bookingAppointmentsArgs != null) {
      if(bookingAppointmentsArgs!.account != null) {
        filtersMap.addAll({Filters.account.name: bookingAppointmentsArgs!.account!.accountId});
      }
    }

    GetBookingAppointmentsParameters parameters = GetBookingAppointmentsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.bookingAppointmentsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, BookingAppointmentsResponse> response = await DependencyInjection.getBookingAppointmentsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInBookingAppointments(data.bookingAppointments);
      if(bookingAppointments.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _bookingAppointments.clear();
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

  // region Delete BookingAppointment
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteBookingAppointment({required BuildContext context, required int bookingAppointmentId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteBookingAppointmentUseCase.call(DeleteBookingAppointmentParameters(bookingAppointmentId: bookingAppointmentId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromBookingAppointments(bookingAppointmentId);
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