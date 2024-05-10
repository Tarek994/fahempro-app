import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/suggested_message_model.dart';
import 'package:fahem/domain/usecases/suggested_messages/edit_suggested_message_usecase.dart';
import 'package:fahem/domain/usecases/suggested_messages/insert_suggested_message_usecase.dart';

class InsertEditSuggestedMessageProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Insert And Edit SuggestedMessage
  Future<void> insertSuggestedMessage({required BuildContext context, required InsertSuggestedMessageParameters insertSuggestedMessageParameters}) async {
    changeIsLoading(true);
    Either<Failure, SuggestedMessageModel> response = await DependencyInjection.insertSuggestedMessageUseCase.call(insertSuggestedMessageParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (suggestedMessage) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, suggestedMessage),
      );
    });
  }

  Future<void> editSuggestedMessage({required BuildContext context, required EditSuggestedMessageParameters editSuggestedMessageParameters}) async {
    changeIsLoading(true);
    Either<Failure, SuggestedMessageModel> response = await DependencyInjection.editSuggestedMessageUseCase.call(editSuggestedMessageParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (suggestedMessage) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, suggestedMessage),
      );
    });
  }
  // endregion
}