import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/terms_of_use_model.dart';
import 'package:fahem_business/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';

class EditTermsOfUseProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Edit About App
  Future<void> editTermsOfUse({required BuildContext context, required EditTermsOfUseParameters parameters}) async {
    changeIsLoading(true);
    Either<Failure, TermsOfUseModel> response = await DependencyInjection.editTermsOfUseUseCase.call(parameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (termsOfUse) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, termsOfUse),
      );
    });
  }
  // endregion
}