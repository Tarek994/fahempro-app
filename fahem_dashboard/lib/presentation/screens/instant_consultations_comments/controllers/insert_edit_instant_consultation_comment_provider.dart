import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/edit_instant_consultation_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/insert_instant_consultation_comment_usecase.dart';

class InsertEditInstantConsultationCommentProvider with ChangeNotifier {

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

  InstantConsultationModel? _instantConsultation;
  InstantConsultationModel? get instantConsultation => _instantConsultation;
  setInstantConsultation(InstantConsultationModel? instantConsultation) => _instantConsultation = instantConsultation;
  changeInstantConsultation(InstantConsultationModel? instantConsultation) {_instantConsultation = instantConsultation; notifyListeners();}

  AccountModel? _account;
  AccountModel? get account => _account;
  setAccount(AccountModel? account) => _account = account;
  changeAccount(AccountModel? account) {_account = account; notifyListeners();}

  bool isAllDataValid() {
    if(_instantConsultation == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseInstantConsultation).toCapitalized());
      return false;
    }
    if(_account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    return true;
  }

  // region Insert And Edit InstantConsultationComment
  Future<void> insertInstantConsultationComment({required BuildContext context, required InsertInstantConsultationCommentParameters insertInstantConsultationCommentParameters}) async {
    changeIsLoading(true);
    Either<Failure, InstantConsultationCommentModel> response = await DependencyInjection.insertInstantConsultationCommentUseCase.call(insertInstantConsultationCommentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (instantConsultationComment) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, instantConsultationComment),
      );
    });
  }

  Future<void> editInstantConsultationComment({required BuildContext context, required EditInstantConsultationCommentParameters editInstantConsultationCommentParameters}) async {
    changeIsLoading(true);
    Either<Failure, InstantConsultationCommentModel> response = await DependencyInjection.editInstantConsultationCommentUseCase.call(editInstantConsultationCommentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (instantConsultationComment) async {
      changeIsLoading(false);
      if(instantConsultationComment.commentStatus == CommentStatus.active) {
        Methods.sendNotificationToUser(
          userId: instantConsultationComment.instantConsultation.userId,
          title: 'رد على استشارة فورية',
          body: '${"قام"} ${instantConsultationComment.account.fullName} ${"بالرد على استشارة فورية رقم #"}${instantConsultationComment.instantConsultationId}',
        );
      }
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, instantConsultationComment),
      );
    });
  }
  // endregion
}