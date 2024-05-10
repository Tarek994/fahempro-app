import 'package:dartz/dartz.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/playlist_comment_model.dart';
import 'package:fahem/domain/usecases/playlists_comments/edit_playlist_comment_usecase.dart';
import 'package:fahem/domain/usecases/playlists_comments/insert_playlist_comment_usecase.dart';

class InsertEditPlaylistCommentProvider with ChangeNotifier {

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  PlaylistModel? _playlist;
  PlaylistModel? get playlist => _playlist;
  setPlaylist(PlaylistModel? playlist) => _playlist = playlist;
  changePlaylist(PlaylistModel? playlist) {_playlist = playlist; notifyListeners();}

  UserModel? _user;
  UserModel? get user => _user;
  setUser(UserModel? user) => _user = user;
  changeUser(UserModel? user) {_user = user; notifyListeners();}

  bool isAllDataValid() {
    if(_playlist == null) {
      Methods.showToast(message: Methods.getText(StringsManager.choosePlaylist).toCapitalized());
      return false;
    }
    if(_user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit PlaylistComment
  Future<void> insertPlaylistComment({required BuildContext context, required InsertPlaylistCommentParameters insertPlaylistCommentParameters}) async {
    changeIsLoading(true);
    Either<Failure, PlaylistCommentModel> response = await DependencyInjection.insertPlaylistCommentUseCase.call(insertPlaylistCommentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (playlistComment) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, playlistComment),
      );
    });
  }

  Future<void> editPlaylistComment({required BuildContext context, required EditPlaylistCommentParameters editPlaylistCommentParameters}) async {
    changeIsLoading(true);
    Either<Failure, PlaylistCommentModel> response = await DependencyInjection.editPlaylistCommentUseCase.call(editPlaylistCommentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (playlistComment) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, playlistComment),
      );
    });
  }
  // endregion
}