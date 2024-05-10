import 'package:dartz/dartz.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/domain/usecases/videos/edit_video_usecase.dart';
import 'package:fahem/domain/usecases/videos/insert_video_usecase.dart';

class InsertEditVideoProvider with ChangeNotifier {

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

  bool isAllDataValid() {
    if(_playlist == null) {
      Methods.showToast(message: Methods.getText(StringsManager.choosePlaylist).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Video
  Future<void> insertVideo({required BuildContext context, required InsertVideoParameters insertVideoParameters}) async {
    changeIsLoading(true);
    Either<Failure, VideoModel> response = await DependencyInjection.insertVideoUseCase.call(insertVideoParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (video) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, video),
      );
    });
  }

  Future<void> editVideo({required BuildContext context, required EditVideoParameters editVideoParameters}) async {
    changeIsLoading(true);
    Either<Failure, VideoModel> response = await DependencyInjection.editVideoUseCase.call(editVideoParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (video) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, video),
      );
    });
  }
  // endregion
}