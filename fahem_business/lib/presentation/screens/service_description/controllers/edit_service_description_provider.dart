import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/service_description_model.dart';
import 'package:fahem_business/domain/usecases/service_description/edit_service_description_usecase.dart';

class EditServiceDescriptionProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Edit ServiceDescription
  Future<void> editServiceDescription({required BuildContext context, required EditServiceDescriptionParameters parameters}) async {
    changeIsLoading(true);
    Either<Failure, ServiceDescriptionModel> response = await DependencyInjection.editServiceDescriptionUseCase.call(parameters);
    response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (serviceDescription) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, serviceDescription),
      );
    });
  }
  // endregion
}