import 'package:dartz/dartz.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/edit_booking_appointment_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/insert_booking_appointment_usecase.dart';

class InsertEditBookingAppointmentProvider with ChangeNotifier {

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

  AccountModel? _account;
  AccountModel? get account => _account;
  setAccount(AccountModel? account) => _account = account;
  changeAccount(AccountModel? account) {_account = account; notifyListeners();}

  UserModel? _user;
  UserModel? get user => _user;
  setUser(UserModel? user) => _user = user;
  changeUser(UserModel? user) {_user = user; notifyListeners();}

  DateTime? _date;
  DateTime? get date => _date;
  setDate(DateTime? date) => _date = date;
  changeDate(DateTime? date) {_date = date; notifyListeners();}
  Future<void> onPressedDate(BuildContext context) async {
    await Methods.selectDateFromPicker(
      context: context,
      title: StringsManager.selectDate,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((dateTime) {
      if(dateTime != null) {changeDate(dateTime);}
    });
  }

  TimeOfDay? _time;
  TimeOfDay? get time => _time;
  setTime(TimeOfDay? time) => _time = time;
  changeTime(TimeOfDay? time) {_time = time; notifyListeners();}
  Future<void> onPressedTime(BuildContext context) async {
    await Methods.selectTimeFromPicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    ).then((timeOfDay) {
      if(timeOfDay != null) {changeTime(timeOfDay);}
    });
  }

  bool isAllDataValid() {
    if(_account == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseAccount).toCapitalized());
      return false;
    }
    if(_user == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseUser).toCapitalized());
      return false;
    }
    if(_date == null) {
      return false;
    }
    if(_time == null) {
      return false;
    }
    return true;
  }

  // region Insert And Edit BookingAppointment
  Future<void> insertBookingAppointment({required BuildContext context, required InsertBookingAppointmentParameters insertBookingAppointmentParameters}) async {
    changeIsLoading(true);
    Either<Failure, BookingAppointmentModel> response = await DependencyInjection.insertBookingAppointmentUseCase.call(insertBookingAppointmentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (bookingAppointment) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, bookingAppointment),
      );
    });
  }

  Future<void> editBookingAppointment({required BuildContext context, required EditBookingAppointmentParameters editBookingAppointmentParameters}) async {
    changeIsLoading(true);
    Either<Failure, BookingAppointmentModel> response = await DependencyInjection.editBookingAppointmentUseCase.call(editBookingAppointmentParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (bookingAppointment) async {
      changeIsLoading(false);
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        thenMethod: () => Navigator.pop(context, bookingAppointment),
      );
    });
  }
  // endregion
}