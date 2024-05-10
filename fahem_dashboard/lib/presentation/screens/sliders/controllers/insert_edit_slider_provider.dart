import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/slider_model.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/edit_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/insert_slider_usecase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InsertEditSliderProvider with ChangeNotifier {

  InsertEditSliderProvider();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  dynamic _sliderImage;
  dynamic get sliderImage => _sliderImage;
  setSliderImage(dynamic sliderImage) => _sliderImage = sliderImage;
  changeSliderImage(dynamic sliderImage) {_sliderImage = sliderImage; notifyListeners();}

  bool isAllDataValid() {
    if(_sliderImage == null) {
      Methods.showToast(message: Methods.getText(StringsManager.sliderImageIsRequired).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit Slider
  Future<void> insertSlider({required BuildContext context, required InsertSliderParameters insertSliderParameters}) async {
    changeIsLoading(true);
    if(_sliderImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _sliderImage.path!, directory: ApiConstants.slidersDirectory);
      insertSliderParameters.image = imageName!;
    }
    Either<Failure, SliderModel> response = await DependencyInjection.insertSliderUseCase.call(insertSliderParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (slider) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, slider),
      );
    });
  }

  Future<void> editSlider({required BuildContext context, required EditSliderParameters editSliderParameters}) async {
    changeIsLoading(true);
    if(_sliderImage is XFile) {
      String? imageName = await Methods.uploadImage(context: context, imagePath: _sliderImage.path!, directory: ApiConstants.slidersDirectory);
      editSliderParameters.image = imageName!;
    }
    Either<Failure, SliderModel> response = await DependencyInjection.editSliderUseCase.call(editSliderParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (slider) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, slider),
      );
    });
  }
  // endregion
}