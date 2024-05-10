import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/services/kashier_payment_service.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/secret_consultation_model.dart';
import 'package:fahem/domain/usecases/secret_consultations/insert_secret_consultation_usecase.dart';
import 'package:fahem/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

class SecretConsultationFormProvider with ChangeNotifier {

  int serviceCost = 900;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  List<String> _images = [];
  List<String> get images => _images;
  setImages(List<String> images) => _images = images;
  void addInImages(String image) {
    if(images.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      images.add(image);
      notifyListeners();
    }
  }
  void editInImages({required String image, required int index}) {
    if(images.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      images[index] = image;
      notifyListeners();
    }
  }
  void removeFromImages(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  final List<String> _imagesRandomName = [];
  Future<bool> uploadImages(BuildContext context) async {
    bool isUploadFileError = false;

    changeIsLoading(true);

    for(int i=0; i<_images.length; i++) {
      if(isUploadFileError == false) {
        if(_images[i].startsWith(ConstantsManager.fahemImageFromFile)) {
          UploadFileParameters uploadFileParameters = UploadFileParameters(
            file: File(_images[i]),
            directory: ApiConstants.secretConsultationsDirectory,
          );
          Either<Failure, String> response = await DependencyInjection.uploadFileUseCase(uploadFileParameters);
          response.fold((failure) async {
            isUploadFileError = true;
            changeIsLoading(false);
            await Dialogs.failureOccurred(context: context, failure: failure);
          }, (image) {
            _imagesRandomName.add(image);
          });
        }
        else {
          _imagesRandomName.add(_images[i]);
        }
      }
    }

    return isUploadFileError;
  }

  // region Insert Secret Consultation
  Future<void> _insertSecretConsultation({
    required BuildContext context,
    required InsertSecretConsultationParameters insertSecretConsultationParameters,
    required PaymentsMethods paymentMethod,
  }) async {
    WalletHistoryProvider walletHistoryProvider = Provider.of<WalletHistoryProvider>(context, listen: false);

    changeIsLoading(true);

    if(paymentMethod == PaymentsMethods.direct) {
      InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
        userType: UserType.user,
        userId: MyProviders.authenticationProvider.currentUser!.userId,
        accountId: null,
        amount: serviceCost,
        walletTransactionType: WalletTransactionType.chargeWallet,
        textAr: '${"تم شحن المحفظة عن طريق الدفع المباشر برصيد"} $serviceCost ${"جنية"}',
        textEn: 'Charging the wallet with a balance of $serviceCost EGP',
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      await walletHistoryProvider.insertWalletHistory(
        context: context,
        insertWalletHistoryParameters: insertWalletHistoryParameters,
        successMessage: StringsManager.theBalanceHasBeenAddedToTheWallet,
        isAddToMyBalance: true,
      ).then((isSuccess) {
        if(!isSuccess) {
          changeIsLoading(false);
          return;
        }
      }).catchError((error) {
        changeIsLoading(false);
        return;
      });
    }

    InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
      userType: UserType.user,
      userId: insertSecretConsultationParameters.userId,
      accountId: null,
      amount: serviceCost,
      walletTransactionType: WalletTransactionType.secretConsultation,
      textAr: '${"تم دفع"} $serviceCost ${"جنية لحجز استشارة سرية"}',
      textEn: '$serviceCost EGP were paid to book an secret consultation',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await walletHistoryProvider.insertWalletHistory(
      context: context,
      insertWalletHistoryParameters: insertWalletHistoryParameters,
      isAddToMyBalance: false,
    ).then((isSuccess) async {
      if(isSuccess) {
        bool isUploadFileError = await uploadImages(context);
        if(isUploadFileError == false) {
          insertSecretConsultationParameters.images = _imagesRandomName;
          Either<Failure, SecretConsultationModel> response = await DependencyInjection.insertSecretConsultationUseCase.call(insertSecretConsultationParameters);
          await response.fold((failure) async {
            changeIsLoading(false);
            await Dialogs.failureOccurred(context: context, failure: failure);
          }, (secretConsultation) async {
            await Methods.sendNotificationToAdmin(
              title: 'استشارة سرية',
              body: '${"قام العميل"} ${secretConsultation.user.fullName} ${"بطلب استشارة سرية رقم الاستشارة #"}${secretConsultation.secretConsultationId}',
            );
            Dialogs.showBottomSheetMessage(
              context: context,
              message: Methods.getText(StringsManager.yourConsultationHasBeenSentAndYouWillBeAnsweredWithinMinutes).toTitleCase(),
              showMessage: ShowMessage.success,
              thenMethod: () => Navigator.pop(context, secretConsultation),
            );
          });
        }
        else {
          changeIsLoading(false);
        }
      }
      else {
        changeIsLoading(false);
      }
    }).catchError((error) {
      changeIsLoading(false);
    });
  }
  // endregion

  void onPressedSendConsultation({required BuildContext context, required InsertSecretConsultationParameters insertSecretConsultationParameters}) async {
    Dialogs.showPayConfirmationDialog(
      context: context,
      title: Methods.getText(StringsManager.payTheCostOfTheSecretConsultation).toCapitalized(),
      serviceCost: serviceCost,
    ).then((paymentMethod) async {
      if(paymentMethod != null) {
        if(paymentMethod == PaymentsMethods.wallet) {
          Dialogs.showBottomSheetConfirmation(
            context: context,
            message: '${Methods.getText(StringsManager.areYouSureToWithdraw).toCapitalized()} $serviceCost ${Methods.getText(StringsManager.poundsFromYourWallet)}',
          ).then((value) async {
            if(value) {
              _insertSecretConsultation(
                context: context,
                insertSecretConsultationParameters: insertSecretConsultationParameters,
                paymentMethod: paymentMethod,
              );
            }
          });
        }
        else {
          final InternetConnection internetConnection = InternetConnection();
          await internetConnection.hasInternetAccess.then((hasConnection) async {
            if(hasConnection) {
              await KashierPaymentService.chargeWallet(
                context: context,
                customerName: MyProviders.authenticationProvider.currentUser!.fullName,
                totalAmount: serviceCost,
                onPaymentStatusPaid: () async {
                  _insertSecretConsultation(
                    context: context,
                    insertSecretConsultationParameters: insertSecretConsultationParameters,
                    paymentMethod: paymentMethod,
                  );
                },
              );
            }
            else {
              Dialogs.failureOccurred(
                context: context,
                failure: LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'check your internet connection'),
              );
            }
          });
        }
      }
    });
  }
}