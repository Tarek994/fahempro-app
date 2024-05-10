import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/edit_playlist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/insert_playlist_usecase.dart';
import 'package:share_plus/share_plus.dart';

class InsertEditPlaylistProvider with ChangeNotifier {

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

  dynamic _playlistImage;
  dynamic get playlistImage => _playlistImage;
  setPlaylistImage(dynamic playlistImage) => _playlistImage = playlistImage;
  changePlaylistImage(dynamic playlistImage) {_playlistImage = playlistImage; notifyListeners();}

  bool isAllDataValid() {
    if(_playlistImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.imageIsRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Playlist
  Future<void> insertPlaylist({required BuildContext context, required InsertPlaylistParameters insertPlaylistParameters}) async {
    changeIsLoading(true);
    if(_playlistImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _playlistImage.path!, directory: ApiConstants.playlistsDirectory);
      insertPlaylistParameters.image = imageName!;
    }
    Either<Failure, PlaylistModel> response = await DependencyInjection.insertPlaylistUseCase.call(insertPlaylistParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (playlist) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, playlist),
      );
    });
  }

  Future<void> editPlaylist({required BuildContext context, required EditPlaylistParameters editPlaylistParameters}) async {
    changeIsLoading(true);
    if(_playlistImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _playlistImage.path!, directory: ApiConstants.playlistsDirectory);
      editPlaylistParameters.image = imageName!;
    }
    Either<Failure, PlaylistModel> response = await DependencyInjection.editPlaylistUseCase.call(editPlaylistParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (playlist) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, playlist),
      );
    });
  }
  // endregion
}