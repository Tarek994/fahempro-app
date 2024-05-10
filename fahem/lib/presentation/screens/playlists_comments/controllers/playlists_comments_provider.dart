import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/playlist_comment_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/playlists_comments_response.dart';
import 'package:fahem/domain/usecases/playlists_comments/delete_playlist_comment_usecase.dart';
import 'package:fahem/domain/usecases/playlists_comments/get_playlists_comments_usecase.dart';

class PlaylistsCommentsProvider with ChangeNotifier {

  // region Get PlaylistsComments
  final List<PlaylistCommentModel> _playlistsComments = [];
  List<PlaylistCommentModel> get playlistsComments => _playlistsComments;
  addAllInPlaylistsComments(List<PlaylistCommentModel> playlistsComments) {_playlistsComments.addAll(playlistsComments); notifyListeners();}
  insertInPlaylistsComments(PlaylistCommentModel playlistCommentModel) {_playlistsComments.insert(0, playlistCommentModel); notifyListeners();}
  editInPlaylistsComments(PlaylistCommentModel playlistCommentModel) {
    int index = _playlistsComments.indexWhere((element) => element.playlistCommentId == playlistCommentModel.playlistCommentId);
    if(index != -1) {
      _playlistsComments[index] = playlistCommentModel;
      notifyListeners();
    }
  }
  _deleteFromPlaylistsComments(int playlistCommentId) {
    int index = _playlistsComments.indexWhere((element) => element.playlistCommentId == playlistCommentId);
    if(index != -1) {
      _playlistsComments.removeAt(index);
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

    GetPlaylistsCommentsParameters parameters = GetPlaylistsCommentsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.playlistsCommentsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, PlaylistsCommentsResponse> response = await DependencyInjection.getPlaylistsCommentsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInPlaylistsComments(data.playlistsComments);
      if(playlistsComments.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _playlistsComments.clear();
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

  // region Delete PlaylistComment
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deletePlaylistComment({required BuildContext context, required int playlistCommentId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deletePlaylistCommentUseCase.call(DeletePlaylistCommentParameters(playlistCommentId: playlistCommentId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromPlaylistsComments(playlistCommentId);
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