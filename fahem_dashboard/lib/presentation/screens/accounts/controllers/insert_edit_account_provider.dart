import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/data/models/static/appointment_booking_model.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';
import 'package:fahem_dashboard/data/response/categories_response.dart';
import 'package:fahem_dashboard/data/response/services_response.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem_dashboard/presentation/btm_sheets/governorates_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/dependency_injection.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/static/governorate_model.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/edit_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/insert_account_usecase.dart';

class InsertEditAccountProvider with ChangeNotifier {

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

  MainCategoryModel? _mainCategory;
  MainCategoryModel? get mainCategory => _mainCategory;
  setMainCategory(MainCategoryModel? mainCategory) => _mainCategory = mainCategory;
  changeMainCategory(MainCategoryModel? mainCategory) {_mainCategory = mainCategory; notifyListeners();}

  dynamic _personalImage;
  dynamic get personalImage => _personalImage;
  setPersonalImage(dynamic personalImage) => _personalImage = personalImage;
  changePersonalImage(dynamic personalImage) {_personalImage = personalImage; notifyListeners();}

  dynamic _coverImage;
  dynamic get coverImage => _coverImage;
  setCoverImage(dynamic coverImage) => _coverImage = coverImage;
  changeCoverImage(dynamic coverImage) {_coverImage = coverImage; notifyListeners();}

  dynamic _nationalImageFrontSide;
  dynamic get nationalImageFrontSide => _nationalImageFrontSide;
  setNationalImageFrontSide(dynamic nationalImageFrontSide) => _nationalImageFrontSide = nationalImageFrontSide;
  changeNationalImageFrontSide(dynamic nationalImageFrontSide) {_nationalImageFrontSide = nationalImageFrontSide; notifyListeners();}

  dynamic _nationalImageBackSide;
  dynamic get nationalImageBackSide => _nationalImageBackSide;
  setNationalImageBackSide(dynamic nationalImageBackSide) => _nationalImageBackSide = nationalImageBackSide;
  changeNationalImageBackSide(dynamic nationalImageBackSide) {_nationalImageBackSide = nationalImageBackSide; notifyListeners();}

  dynamic _cardImage;
  dynamic get cardImage => _cardImage;
  setCardImage(dynamic cardImage) => _cardImage = cardImage;
  changeCardImage(dynamic cardImage) {_cardImage = cardImage; notifyListeners();}

  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;
  setBirthDate(DateTime? birthDate) => _birthDate = birthDate;
  changeBirthDate(DateTime? birthDate) {_birthDate = birthDate; notifyListeners();}
  Future<void> onPressedBirthDate(BuildContext context) async {
    await Methods.selectDateFromPicker(
      context: context,
      title: StringsManager.selectBirthDate,
      initialDate: birthDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((dateTime) {
      if(dateTime != null) {changeBirthDate(dateTime);}
    });
  }

  GovernorateModel? _governorate;
  GovernorateModel? get governorate => _governorate;
  setGovernorate(GovernorateModel? governorate) => _governorate = governorate;
  changeGovernorate(GovernorateModel? governorate)  {_governorate = governorate; notifyListeners();}
  void onPressedGovernorate(BuildContext context) {
    FocusScope.of(context).unfocus();
    Dialogs.showBottomSheet(
      context: context,
      child: const GovernoratesBtmSheet(),
      thenMethod: () {
        if(selectedGovernorateInBtmSheet != null) {
          changeGovernorate(selectedGovernorateInBtmSheet);
        }
      },
    );
  }

  CountryModel _dialingCode = ConstantsManager.egyptCountryModel;
  CountryModel get dialingCode => _dialingCode;
  setDialingCode(CountryModel dialingCode) => _dialingCode = dialingCode;
  changeDialingCode(CountryModel dialingCode)  {_dialingCode = dialingCode; notifyListeners();}

  List<String> _photoGallery = [];
  List<String> get photoGallery => _photoGallery;
  setPhotoGallery(List<String> photoGallery) => _photoGallery = photoGallery;
  void addInPhotoGallery(String image) {
    if(photoGallery.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      photoGallery.add(image);
      notifyListeners();
    }
  }
  void editInPhotoGallery({required String image, required int index}) {
    if(photoGallery.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      photoGallery[index] = image;
      notifyListeners();
    }
  }
  void removeFromPhotoGallery(int index) {
    photoGallery.removeAt(index);
    notifyListeners();
  }

  List<String> _identificationImages = [];
  List<String> get identificationImages => _identificationImages;
  setIdentificationImages(List<String> identificationImages) => _identificationImages = identificationImages;
  void addInIdentificationImages(String image) {
    if(identificationImages.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      identificationImages.add(image);
      notifyListeners();
    }
  }
  void editInIdentificationImages({required String image, required int index}) {
    if(identificationImages.any((element) => element.contains('/') && (element.substring(element.lastIndexOf('/')) ==  image.substring(image.lastIndexOf('/'))))) {
      Methods.showToast(message: Methods.getText(StringsManager.imageAlreadyAdded).toCapitalized());
    }
    else {
      identificationImages[index] = image;
      notifyListeners();
    }
  }
  void removeFromIdentificationImages(int index) {
    identificationImages.removeAt(index);
    notifyListeners();
  }

  final List<String> _photoGalleryRandomName = [];
  final List<String> _identificationImagesRandomName = [];
  Future<bool> uploadImages(BuildContext context) async {
    bool isUploadFileError = false;

    changeIsLoading(true);

    for(int i=0; i<photoGallery.length; i++) {
      if(isUploadFileError == false) {
        if(photoGallery[i].startsWith(ConstantsManager.fahemDashboardImageFromFile)) {
          UploadFileParameters uploadFileParameters = UploadFileParameters(
            file: File(photoGallery[i]),
            directory: ApiConstants.accountsGalleryDirectory,
          );
          Either<Failure, String> response = await DependencyInjection.uploadFileUseCase(uploadFileParameters);
          response.fold((failure) async {
            isUploadFileError = true;
            changeIsLoading(false);
            await Dialogs.failureOccurred(context: context, failure: failure);
          }, (image) {
            _photoGalleryRandomName.add(image);
          });
        }
        else {
          _photoGalleryRandomName.add(photoGallery[i]);
        }
      }
    }

    for(int i=0; i<identificationImages.length; i++) {
      if(isUploadFileError == false) {
        if(identificationImages[i].startsWith(ConstantsManager.fahemDashboardImageFromFile)) {
          UploadFileParameters uploadFileParameters = UploadFileParameters(
            file: File(identificationImages[i]),
            directory: ApiConstants.accountsIdentificationDirectory,
          );
          Either<Failure, String> response = await DependencyInjection.uploadFileUseCase(uploadFileParameters);
          response.fold((failure) async {
            isUploadFileError = true;
            changeIsLoading(false);
            await Dialogs.failureOccurred(context: context, failure: failure);
          }, (image) {
            _identificationImagesRandomName.add(image);
          });
        }
        else {
          _identificationImagesRandomName.add(identificationImages[i]);
        }
      }
    }

    return isUploadFileError;
  }

  List<String> _tasks = [];
  List<String> get tasks => _tasks;
  setTasks(List<String> tasks) => _tasks = tasks;
  changeTasks(List<String> tasks) {_tasks = tasks; notifyListeners();}
  addInTasks(String task) {
    if(!_tasks.contains(task) && task.isNotEmpty) {
      _tasks.add(task);
      notifyListeners();
    }
  }
  removeFromTasks(String task) {
    _tasks.removeWhere((element) => element == task);
    notifyListeners();
  }

  Position? _position;
  Position? get position => _position;
  setPosition(Position? position) => _position = position;
  changePosition(Position? position) {_position = position; notifyListeners();}

  bool _isDetectLocationClicked = false;
  bool get isDetectLocationClicked => _isDetectLocationClicked;
  setIsDetectLocationClicked(bool isDetectLocationClicked) => _isDetectLocationClicked = isDetectLocationClicked;
  changeIsDetectLocationClicked(bool isDetectLocationClicked) {_isDetectLocationClicked = isDetectLocationClicked; notifyListeners();}

  String? _address;
  String? get address => _address;
  setAddress(String? address) => _address = address;
  changeAddress(String? address) {_address = address; notifyListeners();}

  bool _isFeatured = false;
  bool get isFeatured => _isFeatured;
  setIsFeatured(bool isFeatured) => _isFeatured = isFeatured;
  changeIsFeatured(bool isFeatured) {_isFeatured = isFeatured; notifyListeners();}

  bool _isBookingByAppointment = false;
  bool get isBookingByAppointment => _isBookingByAppointment;
  setIsBookingByAppointment(bool isBookingByAppointment) => _isBookingByAppointment = isBookingByAppointment;
  changeIsBookingByAppointment(bool isBookingByAppointment) {_isBookingByAppointment = isBookingByAppointment; notifyListeners();}

  List<CategoryModel> _selectedCategories = [];
  List<CategoryModel> get selectedCategories => _selectedCategories;
  setSelectedCategories(List<CategoryModel> selectedCategories) => _selectedCategories = selectedCategories;
  toggleSelectedCategory(CategoryModel selectedCategory) {
    int index = _selectedCategories.indexWhere((element) => element.categoryId == selectedCategory.categoryId);
    if(index == -1) {
      _selectedCategories.add(selectedCategory);
    }
    else {
      _selectedCategories.removeWhere((element) => element.categoryId == selectedCategory.categoryId);
    }
    notifyListeners();
  }

  List<ServiceModel> _selectedServices = [];
  List<ServiceModel> get selectedServices => _selectedServices;
  setSelectedServices(List<ServiceModel> selectedServices) => _selectedServices = selectedServices;
  toggleSelectedServices(ServiceModel selectedService) {
    int index = _selectedServices.indexWhere((element) => element.serviceId == selectedService.serviceId);
    if(index == -1) {
      _selectedServices.add(selectedService);
    }
    else {
      _selectedServices.removeWhere((element) => element.serviceId == selectedService.serviceId);
    }
    notifyListeners();
  }

  List<AppointmentBookingModel> _selectedAppointmentBooking = [];
  List<AppointmentBookingModel> get selectedAppointmentBooking => _selectedAppointmentBooking;
  setSelectedAppointmentBooking(List<AppointmentBookingModel> selectedAppointmentBooking) => _selectedAppointmentBooking = selectedAppointmentBooking;
  toggleSelectedAppointmentBooking(AppointmentBookingModel selectedAppointmentBooking) {
    int index = _selectedAppointmentBooking.indexWhere((element) => element.appointmentBookingId == selectedAppointmentBooking.appointmentBookingId);
    if(index == -1) {
      _selectedAppointmentBooking.add(selectedAppointmentBooking);
    }
    else {
      _selectedAppointmentBooking.removeWhere((element) => element.appointmentBookingId == selectedAppointmentBooking.appointmentBookingId);
    }
    notifyListeners();
  }

  bool isAllDataValid() {
    if(_mainCategory == null) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseMainCategory).toCapitalized());
      return false;
    }
    // if(_personalImage == null) {
    //   Methods.showToast(message: Methods.getText(StringsManager.personalImageIsRequired).toCapitalized());
    //   return false;
    // }
    // if(_governorate == null) {return false;}
    // if(_selectedCategories.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.chooseTheCategories).toCapitalized());
    //   return false;
    // }
    // if(_selectedServices.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.chooseTheServices).toCapitalized());
    //   return false;
    // }
    if(_isBookingByAppointment && _selectedAppointmentBooking.isEmpty) {
      Methods.showToast(message: Methods.getText(StringsManager.chooseThePeriodsAvailableToYou).toCapitalized());
      return false;
    }
    // if(_tasks.isEmpty) {
    //   Methods.showToast(message: Methods.getText(StringsManager.tasksRequired).toCapitalized());
    //   return false;
    // }
    return true;
  }

  // region Insert And Edit Account
  Future<void> insertAccount({required BuildContext context, required InsertAccountParameters insertAccountParameters}) async {
    changeIsLoading(true);
    bool isUploadFileError = await uploadImages(context);
    if(isUploadFileError == false) {
      insertAccountParameters.photoGallery = _photoGalleryRandomName;
      insertAccountParameters.identificationImages = _identificationImagesRandomName;
      if(_personalImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.accountsDirectory);
        insertAccountParameters.personalImage = imageName;
      }
      if(_coverImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.accountsDirectory);
        insertAccountParameters.coverImage = imageName;
      }
      if(_nationalImageFrontSide is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _nationalImageFrontSide.path!, directory: ApiConstants.accountsIdentificationDirectory);
        insertAccountParameters.nationalImageFrontSide = imageName;
      }
      if(_nationalImageBackSide is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _nationalImageBackSide.path!, directory: ApiConstants.accountsIdentificationDirectory);
        insertAccountParameters.nationalImageBackSide = imageName;
      }
      if(_cardImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _cardImage.path!, directory: ApiConstants.accountsIdentificationDirectory);
        insertAccountParameters.cardImage = imageName;
      }
      Either<Failure, AccountModel> response = await DependencyInjection.insertAccountUseCase.call(insertAccountParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (account) async {
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context, account),
        );
      });
    }
  }

  Future<void> editAccount({required BuildContext context, required EditAccountParameters editAccountParameters}) async {
    changeIsLoading(true);
    bool isUploadFileError = await uploadImages(context);
    if(isUploadFileError == false) {
      editAccountParameters.photoGallery = _photoGalleryRandomName;
      editAccountParameters.identificationImages = _identificationImagesRandomName;
      if(_personalImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _personalImage.path!, directory: ApiConstants.accountsDirectory);
        editAccountParameters.personalImage = imageName;
      }
      if(_coverImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _coverImage.path!, directory: ApiConstants.accountsDirectory);
        editAccountParameters.coverImage = imageName;
      }
      if(_nationalImageFrontSide is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _nationalImageFrontSide.path!, directory: ApiConstants.accountsIdentificationDirectory);
        editAccountParameters.nationalImageFrontSide = imageName;
      }
      if(_nationalImageBackSide is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _nationalImageBackSide.path!, directory: ApiConstants.accountsIdentificationDirectory);
        editAccountParameters.nationalImageBackSide = imageName;
      }
      if(_cardImage is XFile) {
        String? imageName = await Methods.uploadImage(context: context, imagePath: _cardImage.path!, directory: ApiConstants.accountsIdentificationDirectory);
        editAccountParameters.cardImage = imageName;
      }
      Either<Failure, AccountModel> response = await DependencyInjection.editAccountUseCase.call(editAccountParameters);
      await response.fold((failure) async {
        changeIsLoading(false);
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (account) async {
        changeIsLoading(false);
        Dialogs.showBottomSheetMessage(
          context: context,
          message: Methods.getText(StringsManager.modifiedSuccessfully).toTitleCase(),
          showMessage: ShowMessage.success,
          thenMethod: () => Navigator.pop(context, account),
        );
      });
    }
  }
  // endregion

  // region Get Categories
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  setCategories(List<CategoryModel> categories) => _categories = categories;

  DataState _categoriesDataState = DataState.loading;
  DataState get categoriesDataState => _categoriesDataState;
  setCategoriesDataState(DataState categoriesDataState) => _categoriesDataState = categoriesDataState;
  changeCategoriesDataState(DataState categoriesDataState) {_categoriesDataState = categoriesDataState; notifyListeners();}

  Future<void> fetchCategories({required int mainCategoryId}) async {
    changeCategoriesDataState(DataState.loading);
    GetCategoriesParameters parameters = GetCategoriesParameters(
      orderBy: OrderByType.customOrderAsc,
      filtersMap: jsonEncode({'mainCategory': mainCategoryId}),
    );
    Either<Failure, CategoriesResponse> response = await DependencyInjection.getCategoriesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeCategoriesDataState(DataState.error);
    }, (data) async {
      setCategories(data.categories);
      if(data.categories.isEmpty) {changeCategoriesDataState(DataState.empty);}
      else {changeCategoriesDataState(DataState.done);}
    });
  }

  void resetCategoriesVariablesToDefault() {
    _categories.clear();
    setCategoriesDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchCategories({required int mainCategoryId}) async {
    if(_categoriesDataState == DataState.loading) return;
    resetCategoriesVariablesToDefault();
    await fetchCategories(mainCategoryId: mainCategoryId);
  }
  // endregion

  // region Get Services
  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;
  setServices(List<ServiceModel> services) => _services = services;

  DataState _servicesDataState = DataState.loading;
  DataState get servicesDataState => _servicesDataState;
  setServicesDataState(DataState servicesDataState) => _servicesDataState = servicesDataState;
  changeServicesDataState(DataState servicesDataState) {_servicesDataState = servicesDataState; notifyListeners();}

  Future<void> fetchServices({required int mainCategoryId}) async {
    changeServicesDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    filtersMap.addAll({'mainCategory': mainCategoryId});
    filtersMap.addAll({'availableForAccount': true});

    GetServicesParameters parameters = GetServicesParameters(
      orderBy: OrderByType.customOrderAsc,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, ServicesResponse> response = await DependencyInjection.getServicesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeServicesDataState(DataState.error);
    }, (data) async {
      setServices(data.services);
      if(data.services.isEmpty) {changeServicesDataState(DataState.empty);}
      else {changeServicesDataState(DataState.done);}
    });
  }

  void resetServicesVariablesToDefault() {
    _services.clear();
    setServicesDataState(DataState.loading);
    setIsScreenDisposed(false);
  }

  Future<void> reFetchServices({required int mainCategoryId}) async {
    if(_servicesDataState == DataState.loading) return;
    resetServicesVariablesToDefault();
    await fetchServices(mainCategoryId: mainCategoryId);
  }
  // endregion
}