import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/employment_application_model.dart';
import 'package:fahem/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class JobApplyProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  bool _isButtonClicked = false;
  bool get isButtonClicked => _isButtonClicked;
  setIsButtonClicked(bool isButtonClicked) => _isButtonClicked = isButtonClicked;
  changeIsButtonClicked(bool isButtonClicked) {_isButtonClicked = isButtonClicked; notifyListeners();}

  FilePickerResult? _cvFile;
  FilePickerResult? get cvFile => _cvFile;
  setCvFile(FilePickerResult? cvFile) => _cvFile = cvFile;
  changeCvFile(FilePickerResult? cvFile) {_cvFile = cvFile; notifyListeners();}

  bool isAllDataValid(BuildContext context) {
    if(_cvFile == null) {
      Methods.showToast(message: Methods.getText(StringsManager.cvIsRequired).toCapitalized());
      return false;
    }
    if(_cvFile!.files.single.path!.split('.').last.toLowerCase() != 'pdf') {
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.thisExtensionIsNotAllowedOnlyPdfIsAllowed),
      );
      return false;
    }
    return true;
  }

  Future<void> insertEmploymentApplication({required BuildContext context, required InsertEmploymentApplicationParameters insertEmploymentApplicationParameters}) async {
    changeIsLoading(true);
    String? fileName = await Methods.uploadImage(context: context, imagePath: _cvFile!.files.single.path!, directory: ApiConstants.employmentApplicationsDirectory);
    if(fileName != null) {
      insertEmploymentApplicationParameters.cv = fileName;

      Either<Failure, EmploymentApplicationModel> response = await DependencyInjection.insertEmploymentApplicationUseCase.call(insertEmploymentApplicationParameters);
      response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (employmentApplication) async {
        // NotificationService.pushNotification(
        //   topic: '${employmentApplicationModel.targetId}${getKeyword(employmentApplicationModel.targetName)}',
        //   title: 'طلب توظيف',
        //   body: 'العميل ${employmentApplicationModel.name} تقدم بطلب الى وظيفة $jobTitle',
        // );
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.yourJobApplicationHasBeenSentSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context),
        );
      });
    }
    else {
      changeIsLoading(false);
    }
  }
}