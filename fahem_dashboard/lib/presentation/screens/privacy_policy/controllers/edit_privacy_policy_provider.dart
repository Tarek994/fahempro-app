import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/privacy_policy_model.dart';
import 'package:fahem_dashboard/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';

class EditPrivacyPolicyProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Edit Privacy Policy
  Future<void> editPrivacyPolicy({required BuildContext context, required EditPrivacyPolicyParameters parameters}) async {
    changeIsLoading(true);
    Either<Failure, PrivacyPolicyModel> response = await DependencyInjection.editPrivacyPolicyUseCase.call(parameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (privacyPolicy) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, privacyPolicy),
      );
    });
  }
  // endregion
}