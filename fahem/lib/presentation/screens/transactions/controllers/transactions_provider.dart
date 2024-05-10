import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/booking_appointment_model.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/data/models/secret_consultation_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/booking_appointments_response.dart';
import 'package:fahem/data/response/instant_consultations_response.dart';
import 'package:fahem/data/response/phone_number_requests_response.dart';
import 'package:fahem/data/response/secret_consultations_response.dart';
import 'package:fahem/domain/usecases/booking_appointments/get_booking_appointments_usecase.dart';
import 'package:fahem/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';
import 'package:fahem/domain/usecases/phone_number_requests/get_phone_number_requests_usecase.dart';
import 'package:fahem/domain/usecases/secret_consultations/get_secret_consultations_usecase.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';

enum TransactionsPages {instantConsultations, secretConsultations, phoneNumberRequests, bookingAppointments}

class TransactionsProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  TransactionsPages _currentTransactionsPages = TransactionsPages.instantConsultations;
  TransactionsPages get currentTransactionsPages => _currentTransactionsPages;
  setCurrentTransactionsPages(TransactionsPages transactionsPages) async {_currentTransactionsPages = transactionsPages;}

  // region Get Instant Consultations
  final List<InstantConsultationModel> _instantConsultations = [];
  List<InstantConsultationModel> get instantConsultations => _instantConsultations;
  addAllInInstantConsultations(List<InstantConsultationModel> instantConsultations) {_instantConsultations.addAll(instantConsultations); notifyListeners();}
  editInInstantConsultations(InstantConsultationModel instantConsultationModel) {
    int index = _instantConsultations.indexWhere((element) => element.instantConsultationId == instantConsultationModel.instantConsultationId);
    if(index != -1) {
      _instantConsultations[index] = instantConsultationModel;
      notifyListeners();
    }
  }

  DataState _instantConsultationsDataState = DataState.loading;
  DataState get instantConsultationsDataState => _instantConsultationsDataState;
  setInstantConsultationsDataState(DataState instantConsultationsDataState) => _instantConsultationsDataState = instantConsultationsDataState;
  changeInstantConsultationsDataState(DataState instantConsultationsDataState) {_instantConsultationsDataState = instantConsultationsDataState; notifyListeners();}

  bool _instantConsultationsHasMore = true;
  bool get instantConsultationsHasMore => _instantConsultationsHasMore;
  setInstantConsultationsHasMore(bool instantConsultationsHasMore) => _instantConsultationsHasMore = instantConsultationsHasMore;
  changeInstantConsultationsHasMore(bool instantConsultationsHasMore) {_instantConsultationsHasMore = instantConsultationsHasMore; notifyListeners();}

  ViewStyle _instantConsultationsViewStyle = ViewStyle.list;
  ViewStyle get instantConsultationsViewStyle => _instantConsultationsViewStyle;
  setInstantConsultationsViewStyle(ViewStyle instantConsultationsViewStyle) => _instantConsultationsViewStyle = instantConsultationsViewStyle;
  changeInstantConsultationsViewStyle(ViewStyle instantConsultationsViewStyle) {_instantConsultationsViewStyle = instantConsultationsViewStyle; notifyListeners();}

  ScrollController instantConsultationsScrollController = ScrollController();
  PaginationModel? instantConsultationsPaginationModel;
  int instantConsultationsLimit = 20;
  int instantConsultationsPage = 1;

  Future<void> instantConsultationsAddListenerScrollController() async {
    instantConsultationsScrollController.addListener(() async {
      if(_instantConsultationsDataState != DataState.done) return;
      if(instantConsultationsScrollController.position.pixels >= (instantConsultationsScrollController.position.maxScrollExtent)) {
        await fetchInstantConsultations();
      }
    });
  }

  Future<void> fetchInstantConsultations() async {
    if(!_instantConsultationsHasMore) return;
    changeInstantConsultationsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'user': MyProviders.authenticationProvider.currentUser!.userId});

    GetInstantConsultationsParameters parameters = GetInstantConsultationsParameters(
      isPaginated: true,
      limit: instantConsultationsLimit,
      page: instantConsultationsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.instantConsultationsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, InstantConsultationsResponse> response = await DependencyInjection.getInstantConsultationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeInstantConsultationsDataState(DataState.error);
    }, (data) async {
      instantConsultationsPaginationModel = data.pagination;
      addAllInInstantConsultations(data.instantConsultations);
      if(_instantConsultations.length == instantConsultationsPaginationModel!.total) {changeInstantConsultationsHasMore(false);}
      if(instantConsultationsPaginationModel!.total == 0) {changeInstantConsultationsDataState(DataState.empty);}
      else {changeInstantConsultationsDataState(DataState.done);}
      instantConsultationsPage += 1;
    });
  }

  void resetInstantConsultationsVariablesToDefault() {
    _instantConsultations.clear();
    setInstantConsultationsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setInstantConsultationsHasMore(true);
    instantConsultationsPage = 1;
  }

  Future<void> reFetchInstantConsultations() async {
    if(_instantConsultationsDataState == DataState.loading) return;
    resetInstantConsultationsVariablesToDefault();
    await fetchInstantConsultations();
  }
  // endregion

  // region Get Secret Consultations
  final List<SecretConsultationModel> _secretConsultations = [];
  List<SecretConsultationModel> get secretConsultations => _secretConsultations;
  addAllInSecretConsultations(List<SecretConsultationModel> secretConsultations) {_secretConsultations.addAll(secretConsultations); notifyListeners();}

  DataState _secretConsultationsDataState = DataState.loading;
  DataState get secretConsultationsDataState => _secretConsultationsDataState;
  setSecretConsultationsDataState(DataState secretConsultationsDataState) => _secretConsultationsDataState = secretConsultationsDataState;
  changeSecretConsultationsDataState(DataState secretConsultationsDataState) {_secretConsultationsDataState = secretConsultationsDataState; notifyListeners();}

  bool _secretConsultationsHasMore = true;
  bool get secretConsultationsHasMore => _secretConsultationsHasMore;
  setSecretConsultationsHasMore(bool secretConsultationsHasMore) => _secretConsultationsHasMore = secretConsultationsHasMore;
  changeSecretConsultationsHasMore(bool secretConsultationsHasMore) {_secretConsultationsHasMore = secretConsultationsHasMore; notifyListeners();}

  ViewStyle _secretConsultationsViewStyle = ViewStyle.list;
  ViewStyle get secretConsultationsViewStyle => _secretConsultationsViewStyle;
  setSecretConsultationsViewStyle(ViewStyle secretConsultationsViewStyle) => _secretConsultationsViewStyle = secretConsultationsViewStyle;
  changeSecretConsultationsViewStyle(ViewStyle secretConsultationsViewStyle) {_secretConsultationsViewStyle = secretConsultationsViewStyle; notifyListeners();}

  ScrollController secretConsultationsScrollController = ScrollController();
  PaginationModel? secretConsultationsPaginationModel;
  int secretConsultationsLimit = 20;
  int secretConsultationsPage = 1;

  Future<void> secretConsultationsAddListenerScrollController() async {
    secretConsultationsScrollController.addListener(() async {
      if(_secretConsultationsDataState != DataState.done) return;
      if(secretConsultationsScrollController.position.pixels >= (secretConsultationsScrollController.position.maxScrollExtent)) {
        await fetchSecretConsultations();
      }
    });
  }

  Future<void> fetchSecretConsultations() async {
    if(!_secretConsultationsHasMore) return;
    changeSecretConsultationsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'user': MyProviders.authenticationProvider.currentUser!.userId});

    GetSecretConsultationsParameters parameters = GetSecretConsultationsParameters(
      isPaginated: true,
      limit: secretConsultationsLimit,
      page: secretConsultationsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.secretConsultationsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, SecretConsultationsResponse> response = await DependencyInjection.getSecretConsultationsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeSecretConsultationsDataState(DataState.error);
    }, (data) async {
      secretConsultationsPaginationModel = data.pagination;
      addAllInSecretConsultations(data.secretConsultations);
      if(_secretConsultations.length == secretConsultationsPaginationModel!.total) {changeSecretConsultationsHasMore(false);}
      if(secretConsultationsPaginationModel!.total == 0) {changeSecretConsultationsDataState(DataState.empty);}
      else {changeSecretConsultationsDataState(DataState.done);}
      secretConsultationsPage += 1;
    });
  }

  void resetSecretConsultationsVariablesToDefault() {
    _secretConsultations.clear();
    setSecretConsultationsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setSecretConsultationsHasMore(true);
    secretConsultationsPage = 1;
  }

  Future<void> reFetchSecretConsultations() async {
    if(_secretConsultationsDataState == DataState.loading) return;
    resetSecretConsultationsVariablesToDefault();
    await fetchSecretConsultations();
  }
  // endregion

  // region Get Phone Number Requests
  final List<PhoneNumberRequestModel> _phoneNumberRequests = [];
  List<PhoneNumberRequestModel> get phoneNumberRequests => _phoneNumberRequests;
  addAllInPhoneNumberRequests(List<PhoneNumberRequestModel> phoneNumberRequests) {_phoneNumberRequests.addAll(phoneNumberRequests); notifyListeners();}

  DataState _phoneNumberRequestsDataState = DataState.loading;
  DataState get phoneNumberRequestsDataState => _phoneNumberRequestsDataState;
  setPhoneNumberRequestsDataState(DataState phoneNumberRequestsDataState) => _phoneNumberRequestsDataState = phoneNumberRequestsDataState;
  changePhoneNumberRequestsDataState(DataState phoneNumberRequestsDataState) {_phoneNumberRequestsDataState = phoneNumberRequestsDataState; notifyListeners();}

  bool _phoneNumberRequestsHasMore = true;
  bool get phoneNumberRequestsHasMore => _phoneNumberRequestsHasMore;
  setPhoneNumberRequestsHasMore(bool phoneNumberRequestsHasMore) => _phoneNumberRequestsHasMore = phoneNumberRequestsHasMore;
  changePhoneNumberRequestsHasMore(bool phoneNumberRequestsHasMore) {_phoneNumberRequestsHasMore = phoneNumberRequestsHasMore; notifyListeners();}

  ViewStyle _phoneNumberRequestsViewStyle = ViewStyle.list;
  ViewStyle get phoneNumberRequestsViewStyle => _phoneNumberRequestsViewStyle;
  setPhoneNumberRequestsViewStyle(ViewStyle phoneNumberRequestsViewStyle) => _phoneNumberRequestsViewStyle = phoneNumberRequestsViewStyle;
  changePhoneNumberRequestsViewStyle(ViewStyle phoneNumberRequestsViewStyle) {_phoneNumberRequestsViewStyle = phoneNumberRequestsViewStyle; notifyListeners();}

  ScrollController phoneNumberRequestsScrollController = ScrollController();
  PaginationModel? phoneNumberRequestsPaginationModel;
  int phoneNumberRequestsLimit = 20;
  int phoneNumberRequestsPage = 1;

  Future<void> phoneNumberRequestsAddListenerScrollController() async {
    phoneNumberRequestsScrollController.addListener(() async {
      if(_phoneNumberRequestsDataState != DataState.done) return;
      if(phoneNumberRequestsScrollController.position.pixels >= (phoneNumberRequestsScrollController.position.maxScrollExtent)) {
        await fetchPhoneNumberRequests();
      }
    });
  }

  Future<void> fetchPhoneNumberRequests() async {
    if(!_phoneNumberRequestsHasMore) return;
    changePhoneNumberRequestsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'user': MyProviders.authenticationProvider.currentUser!.userId});

    GetPhoneNumberRequestsParameters parameters = GetPhoneNumberRequestsParameters(
      isPaginated: true,
      limit: phoneNumberRequestsLimit,
      page: phoneNumberRequestsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.phoneNumberRequestsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, PhoneNumberRequestsResponse> response = await DependencyInjection.getPhoneNumberRequestsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changePhoneNumberRequestsDataState(DataState.error);
    }, (data) async {
      phoneNumberRequestsPaginationModel = data.pagination;
      addAllInPhoneNumberRequests(data.phoneNumberRequests);
      if(_phoneNumberRequests.length == phoneNumberRequestsPaginationModel!.total) {changePhoneNumberRequestsHasMore(false);}
      if(phoneNumberRequestsPaginationModel!.total == 0) {changePhoneNumberRequestsDataState(DataState.empty);}
      else {changePhoneNumberRequestsDataState(DataState.done);}
      phoneNumberRequestsPage += 1;
    });
  }

  void resetPhoneNumberRequestsVariablesToDefault() {
    _phoneNumberRequests.clear();
    setPhoneNumberRequestsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setPhoneNumberRequestsHasMore(true);
    phoneNumberRequestsPage = 1;
  }

  Future<void> reFetchPhoneNumberRequests() async {
    if(_phoneNumberRequestsDataState == DataState.loading) return;
    resetPhoneNumberRequestsVariablesToDefault();
    await fetchPhoneNumberRequests();
  }
  // endregion

  // region Get Booking Appointments
  final List<BookingAppointmentModel> _bookingAppointments = [];
  List<BookingAppointmentModel> get bookingAppointments => _bookingAppointments;
  addAllInBookingAppointments(List<BookingAppointmentModel> bookingAppointments) {_bookingAppointments.addAll(bookingAppointments); notifyListeners();}

  DataState _bookingAppointmentsDataState = DataState.loading;
  DataState get bookingAppointmentsDataState => _bookingAppointmentsDataState;
  setBookingAppointmentsDataState(DataState bookingAppointmentsDataState) => _bookingAppointmentsDataState = bookingAppointmentsDataState;
  changeBookingAppointmentsDataState(DataState bookingAppointmentsDataState) {_bookingAppointmentsDataState = bookingAppointmentsDataState; notifyListeners();}

  bool _bookingAppointmentsHasMore = true;
  bool get bookingAppointmentsHasMore => _bookingAppointmentsHasMore;
  setBookingAppointmentsHasMore(bool bookingAppointmentsHasMore) => _bookingAppointmentsHasMore = bookingAppointmentsHasMore;
  changeBookingAppointmentsHasMore(bool bookingAppointmentsHasMore) {_bookingAppointmentsHasMore = bookingAppointmentsHasMore; notifyListeners();}

  ViewStyle _bookingAppointmentsViewStyle = ViewStyle.list;
  ViewStyle get bookingAppointmentsViewStyle => _bookingAppointmentsViewStyle;
  setBookingAppointmentsViewStyle(ViewStyle bookingAppointmentsViewStyle) => _bookingAppointmentsViewStyle = bookingAppointmentsViewStyle;
  changeBookingAppointmentsViewStyle(ViewStyle bookingAppointmentsViewStyle) {_bookingAppointmentsViewStyle = bookingAppointmentsViewStyle; notifyListeners();}

  ScrollController bookingAppointmentsScrollController = ScrollController();
  PaginationModel? bookingAppointmentsPaginationModel;
  int bookingAppointmentsLimit = 20;
  int bookingAppointmentsPage = 1;

  Future<void> bookingAppointmentsAddListenerScrollController() async {
    bookingAppointmentsScrollController.addListener(() async {
      if(_bookingAppointmentsDataState != DataState.done) return;
      if(bookingAppointmentsScrollController.position.pixels >= (bookingAppointmentsScrollController.position.maxScrollExtent)) {
        await fetchBookingAppointments();
      }
    });
  }

  Future<void> fetchBookingAppointments() async {
    if(!_bookingAppointmentsHasMore) return;
    changeBookingAppointmentsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'user': MyProviders.authenticationProvider.currentUser!.userId});

    GetBookingAppointmentsParameters parameters = GetBookingAppointmentsParameters(
      isPaginated: true,
      limit: bookingAppointmentsLimit,
      page: bookingAppointmentsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.bookingAppointmentsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, BookingAppointmentsResponse> response = await DependencyInjection.getBookingAppointmentsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeBookingAppointmentsDataState(DataState.error);
    }, (data) async {
      bookingAppointmentsPaginationModel = data.pagination;
      addAllInBookingAppointments(data.bookingAppointments);
      if(_bookingAppointments.length == bookingAppointmentsPaginationModel!.total) {changeBookingAppointmentsHasMore(false);}
      if(bookingAppointmentsPaginationModel!.total == 0) {changeBookingAppointmentsDataState(DataState.empty);}
      else {changeBookingAppointmentsDataState(DataState.done);}
      bookingAppointmentsPage += 1;
    });
  }

  void resetBookingAppointmentsVariablesToDefault() {
    _bookingAppointments.clear();
    setBookingAppointmentsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setBookingAppointmentsHasMore(true);
    bookingAppointmentsPage = 1;
  }

  Future<void> reFetchBookingAppointments() async {
    if(_bookingAppointmentsDataState == DataState.loading) return;
    resetBookingAppointmentsVariablesToDefault();
    await fetchBookingAppointments();
  }
  // endregion
}