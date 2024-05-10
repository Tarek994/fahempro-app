import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/resources/routes_manager.dart';
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
import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/instant_consultations_comments_response.dart';
import 'package:fahem/domain/usecases/instant_consultations_comments/delete_instant_consultation_comment_usecase.dart';
import 'package:fahem/domain/usecases/instant_consultations_comments/get_instant_consultations_comments_usecase.dart';

class InstantConsultationsCommentsProvider with ChangeNotifier {
  final InstantConsultationsCommentsArgs? instantConsultationsCommentsArgs;

  InstantConsultationsCommentsProvider({this.instantConsultationsCommentsArgs});

  // region Get InstantConsultationsComments
  final List<InstantConsultationCommentModel> _instantConsultationsComments = [];
  List<InstantConsultationCommentModel> get instantConsultationsComments => _instantConsultationsComments;
  addAllInInstantConsultationsComments(List<InstantConsultationCommentModel> instantConsultationsComments) {_instantConsultationsComments.addAll(instantConsultationsComments); notifyListeners();}
  insertInInstantConsultationsComments(InstantConsultationCommentModel instantConsultationCommentModel) {_instantConsultationsComments.insert(0, instantConsultationCommentModel); notifyListeners();}
  editInInstantConsultationsComments(InstantConsultationCommentModel instantConsultationCommentModel) {
    int index = _instantConsultationsComments.indexWhere((element) => element.instantConsultationCommentId == instantConsultationCommentModel.instantConsultationCommentId);
    if(index != -1) {
      _instantConsultationsComments[index] = instantConsultationCommentModel;
      notifyListeners();
    }
  }
  _deleteFromInstantConsultationsComments(int instantConsultationCommentId) {
    int index = _instantConsultationsComments.indexWhere((element) => element.instantConsultationCommentId == instantConsultationCommentId);
    if(index != -1) {
      _instantConsultationsComments.removeAt(index);
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
    filtersMap.addAll({Filters.instantConsultation.name: instantConsultationsCommentsArgs!.instantConsultation!.instantConsultationId});
    filtersMap.addAll({Filters.commentStatus.name: CommentStatus.active.name});

    GetInstantConsultationsCommentsParameters parameters = GetInstantConsultationsCommentsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.instantConsultationsCommentsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, InstantConsultationsCommentsResponse> response = await DependencyInjection.getInstantConsultationsCommentsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInInstantConsultationsComments(data.instantConsultationsComments);
      if(instantConsultationsComments.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _instantConsultationsComments.clear();
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

  // region Delete InstantConsultationComment
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteInstantConsultationComment({required BuildContext context, required int instantConsultationCommentId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteInstantConsultationCommentUseCase.call(DeleteInstantConsultationCommentParameters(instantConsultationCommentId: instantConsultationCommentId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromInstantConsultationsComments(instantConsultationCommentId);
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