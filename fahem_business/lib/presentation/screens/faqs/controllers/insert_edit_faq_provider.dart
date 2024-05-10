import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:fahem_business/domain/usecases/faqs/edit_faq_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/insert_faq_usecase.dart';

class InsertEditFaqProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Insert And Edit Faq
  Future<void> insertFaq({required BuildContext context, required InsertFaqParameters insertFaqParameters}) async {
    changeIsLoading(true);
    Either<Failure, FaqModel> response = await DependencyInjection.insertFaqUseCase.call(insertFaqParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (faq) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, faq),
      );
    });
  }

  Future<void> editFaq({required BuildContext context, required EditFaqParameters editFaqParameters}) async {
    changeIsLoading(true);
    Either<Failure, FaqModel> response = await DependencyInjection.editFaqUseCase.call(editFaqParameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (faq) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, faq),
      );
    });
  }
  // endregion
}