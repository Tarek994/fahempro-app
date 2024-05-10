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
import 'package:fahem_dashboard/data/models/suggested_message_model.dart';
import 'package:fahem_dashboard/data/models/static/pagination_model.dart';
import 'package:fahem_dashboard/data/response/suggested_messages_response.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/delete_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/get_suggested_messages_usecase.dart';

class SuggestedMessagesProvider with ChangeNotifier {

  // region Get SuggestedMessages
  final List<SuggestedMessageModel> _suggestedMessages = [];
  List<SuggestedMessageModel> get suggestedMessages => _suggestedMessages;
  addAllInSuggestedMessages(List<SuggestedMessageModel> suggestedMessages) {_suggestedMessages.addAll(suggestedMessages); notifyListeners();}
  insertInSuggestedMessages(SuggestedMessageModel suggestedMessageModel) {_suggestedMessages.insert(0, suggestedMessageModel); notifyListeners();}
  editInSuggestedMessages(SuggestedMessageModel suggestedMessageModel) {
    int index = _suggestedMessages.indexWhere((element) => element.suggestedMessageId == suggestedMessageModel.suggestedMessageId);
    if(index != -1) {
      _suggestedMessages[index] = suggestedMessageModel;
      notifyListeners();
    }
  }
  _deleteFromSuggestedMessages(int suggestedMessageId) {
    int index = _suggestedMessages.indexWhere((element) => element.suggestedMessageId == suggestedMessageId);
    if(index != -1) {
      _suggestedMessages.removeAt(index);
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
    GetSuggestedMessagesParameters parameters = GetSuggestedMessagesParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.suggestedMessagesNewestFirst,
      filtersMap: globalFilters,
    );
    Either<Failure, SuggestedMessagesResponse> response = await DependencyInjection.getSuggestedMessagesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInSuggestedMessages(data.suggestedMessages);
      if(suggestedMessages.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _suggestedMessages.clear();
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

  // region Delete SuggestedMessage
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteSuggestedMessage({required BuildContext context, required int suggestedMessageId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteSuggestedMessageUseCase.call(DeleteSuggestedMessageParameters(suggestedMessageId: suggestedMessageId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromSuggestedMessages(suggestedMessageId);
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