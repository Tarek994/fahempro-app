import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/playlist_comment_model.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/data/response/playlists_comments_response.dart';
import 'package:fahem/data/response/videos_response.dart';
import 'package:fahem/domain/usecases/playlists_comments/get_playlists_comments_usecase.dart';
import 'package:fahem/domain/usecases/videos/get_videos_usecase.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';

enum PlaylistDetailsPages {aboutVideo, videos, comments}

class PlaylistDetailsProvider with ChangeNotifier {
  final PlaylistModel playlistModel;

  PlaylistDetailsProvider({required this.playlistModel});

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  PlaylistDetailsPages _currentPlaylistDetailsPages = PlaylistDetailsPages.aboutVideo;
  PlaylistDetailsPages get currentPlaylistDetailsPages => _currentPlaylistDetailsPages;
  setCurrentPlaylistDetailsPages(PlaylistDetailsPages playlistDetailsPages) async {_currentPlaylistDetailsPages = playlistDetailsPages;}
  changeCurrentPlaylistDetailsPages(PlaylistDetailsPages playlistDetailsPages) async {_currentPlaylistDetailsPages = playlistDetailsPages; notifyListeners();}

  VideoModel? _currentVideo;
  VideoModel? get currentVideo => _currentVideo;
  changeCurrentVideo(VideoModel? currentVideo) {_currentVideo = currentVideo; notifyListeners();}

  // region Get Videos
  final List<VideoModel> _videos = [];
  List<VideoModel> get videos => _videos;
  addAllInVideos(List<VideoModel> videos) {_videos.addAll(videos); notifyListeners();}

  DataState _videosDataState = DataState.loading;
  DataState get videosDataState => _videosDataState;
  setVideosDataState(DataState videosDataState) => _videosDataState = videosDataState;
  changeVideosDataState(DataState videosDataState) {_videosDataState = videosDataState; notifyListeners();}

  bool _videosHasMore = true;
  bool get videosHasMore => _videosHasMore;
  setVideosHasMore(bool videosHasMore) => _videosHasMore = videosHasMore;
  changeVideosHasMore(bool videosHasMore) {_videosHasMore = videosHasMore; notifyListeners();}

  ViewStyle _videosViewStyle = ViewStyle.list;
  ViewStyle get videosViewStyle => _videosViewStyle;
  setVideosViewStyle(ViewStyle videosViewStyle) => _videosViewStyle = videosViewStyle;
  changeVideosViewStyle(ViewStyle videosViewStyle) {_videosViewStyle = videosViewStyle; notifyListeners();}

  ScrollController videosScrollController = ScrollController();
  PaginationModel? videosPaginationModel;
  int videosLimit = 20;
  int videosPage = 1;

  Future<void> videosAddListenerScrollController() async {
    videosScrollController.addListener(() async {
      if(_videosDataState != DataState.done) return;
      if(videosScrollController.position.pixels >= (videosScrollController.position.maxScrollExtent)) {
        await fetchVideos();
      }
    });
  }

  Future<void> fetchVideos() async {
    if(!_videosHasMore) return;
    changeVideosDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({Filters.playlist.name: playlistModel.playlistId});

    GetVideosParameters parameters = GetVideosParameters(
      isPaginated: true,
      limit: videosLimit,
      page: videosPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.videosOldestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, VideosResponse> response = await DependencyInjection.getVideosUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeVideosDataState(DataState.error);
    }, (data) async {
      videosPaginationModel = data.pagination;
      addAllInVideos(data.videos);
      if(_videos.length == videosPaginationModel!.total) {changeVideosHasMore(false);}
      if(videosPaginationModel!.total == 0) {changeVideosDataState(DataState.empty);}
      else {
        changeVideosDataState(DataState.done);
        changeCurrentVideo(_videos.first);
      }
      videosPage += 1;
    });
  }

  void _resetVideosVariablesToDefault() {
    _videos.clear();
    setVideosDataState(DataState.loading);
    setIsScreenDisposed(false);
    setVideosHasMore(true);
    videosPage = 1;
  }

  Future<void> reFetchVideos() async {
    if(_videosDataState == DataState.loading) return;
    _resetVideosVariablesToDefault();
    await fetchVideos();
  }
  // endregion

  // region Get Playlists Comments
  final List<PlaylistCommentModel> _playlistsComments = [];
  List<PlaylistCommentModel> get playlistsComments => _playlistsComments;
  addAllInPlaylistsComments(List<PlaylistCommentModel> playlistsComments) {_playlistsComments.addAll(playlistsComments); notifyListeners();}
  insertInPlaylistsComments(PlaylistCommentModel playlistCommentModel) {_playlistsComments.insert(0, playlistCommentModel); notifyListeners();}

  DataState _playlistsCommentsDataState = DataState.loading;
  DataState get playlistsCommentsDataState => _playlistsCommentsDataState;
  setPlaylistsCommentsDataState(DataState playlistsCommentsDataState) => _playlistsCommentsDataState = playlistsCommentsDataState;
  changePlaylistsCommentsDataState(DataState playlistsCommentsDataState) {_playlistsCommentsDataState = playlistsCommentsDataState; notifyListeners();}

  bool _playlistsCommentsHasMore = true;
  bool get playlistsCommentsHasMore => _playlistsCommentsHasMore;
  setPlaylistsCommentsHasMore(bool playlistsCommentsHasMore) => _playlistsCommentsHasMore = playlistsCommentsHasMore;
  changePlaylistsCommentsHasMore(bool playlistsCommentsHasMore) {_playlistsCommentsHasMore = playlistsCommentsHasMore; notifyListeners();}

  ViewStyle _playlistsCommentsViewStyle = ViewStyle.list;
  ViewStyle get playlistsCommentsViewStyle => _playlistsCommentsViewStyle;
  setPlaylistsCommentsViewStyle(ViewStyle playlistsCommentsViewStyle) => _playlistsCommentsViewStyle = playlistsCommentsViewStyle;
  changePlaylistsCommentsViewStyle(ViewStyle playlistsCommentsViewStyle) {_playlistsCommentsViewStyle = playlistsCommentsViewStyle; notifyListeners();}

  ScrollController playlistsCommentsScrollController = ScrollController();
  PaginationModel? playlistsCommentsPaginationModel;
  int playlistsCommentsLimit = 20;
  int playlistsCommentsPage = 1;

  Future<void> playlistsCommentsAddListenerScrollController() async {
    playlistsCommentsScrollController.addListener(() async {
      if(_playlistsCommentsDataState != DataState.done) return;
      if(playlistsCommentsScrollController.position.pixels >= (playlistsCommentsScrollController.position.maxScrollExtent)) {
        await fetchPlaylistsComments();
      }
    });
  }

  Future<void> fetchPlaylistsComments() async {
    if(!_playlistsCommentsHasMore) return;
    changePlaylistsCommentsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({Filters.playlist.name: playlistModel.playlistId});

    GetPlaylistsCommentsParameters parameters = GetPlaylistsCommentsParameters(
      isPaginated: true,
      limit: playlistsCommentsLimit,
      page: playlistsCommentsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.playlistsCommentsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, PlaylistsCommentsResponse> response = await DependencyInjection.getPlaylistsCommentsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changePlaylistsCommentsDataState(DataState.error);
    }, (data) async {
      playlistsCommentsPaginationModel = data.pagination;
      addAllInPlaylistsComments(data.playlistsComments);
      if(_playlistsComments.length == playlistsCommentsPaginationModel!.total) {changePlaylistsCommentsHasMore(false);}
      if(playlistsCommentsPaginationModel!.total == 0) {changePlaylistsCommentsDataState(DataState.empty);}
      else {changePlaylistsCommentsDataState(DataState.done);}
      playlistsCommentsPage += 1;
    });
  }

  void _resetPlaylistsCommentsVariablesToDefault() {
    _playlistsComments.clear();
    setPlaylistsCommentsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setPlaylistsCommentsHasMore(true);
    playlistsCommentsPage = 1;
  }

  Future<void> reFetchPlaylistsComments() async {
    if(_playlistsCommentsDataState == DataState.loading) return;
    _resetPlaylistsCommentsVariablesToDefault();
    await fetchPlaylistsComments();
  }
  // endregion
}