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
import 'package:fahem_dashboard/data/models/complaint_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/response/complaints_response.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/delete_complaint_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/get_complaints_usecase.dart';

class ComplaintsProvider with ChangeNotifier {

  // region Get Complaints
  final List<ComplaintModel> _complaints = [];
  List<ComplaintModel> get complaints => _complaints;
  addAllInComplaints(List<ComplaintModel> complaints) {_complaints.addAll(complaints); notifyListeners();}
  insertInComplaints(ComplaintModel complaintModel) {_complaints.insert(0, complaintModel); notifyListeners();}
  editInComplaints(ComplaintModel complaintModel) {
    int index = _complaints.indexWhere((element) => element.complaintId == complaintModel.complaintId);
    if(index != -1) {
      _complaints[index] = complaintModel;
      notifyListeners();
    }
  }
  _deleteFromComplaints(int complaintId) {
    int index = _complaints.indexWhere((element) => element.complaintId == complaintId);
    if(index != -1) {
      _complaints.removeAt(index);
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
    GetComplaintsParameters parameters = GetComplaintsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.complaintsNewestFirst,
      filtersMap: globalFilters,
    );
    Either<Failure, ComplaintsResponse> response = await DependencyInjection.getComplaintsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInComplaints(data.complaints);
      if(complaints.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _complaints.clear();
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

  // region Delete Complaint
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteComplaint({required BuildContext context, required int complaintId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteComplaintUseCase.call(DeleteComplaintParameters(complaintId: complaintId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromComplaints(complaintId);
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