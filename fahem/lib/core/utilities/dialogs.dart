import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/services/kashier_payment_service.dart';
import 'package:fahem/data/data_source/static/countries_data.dart';
import 'package:fahem/data/data_source/static/currencies_data.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/booking_appointment_model.dart';
import 'package:fahem/data/models/instant_consultation_comment_model.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/phone_number_request_model.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/static/country_model.dart';
import 'package:fahem/data/models/static/currency_model.dart';
import 'package:fahem/data/response/accounts_response.dart';
import 'package:fahem/data/response/instant_consultations_comments_response.dart';
import 'package:fahem/data/response/instant_consultations_response.dart';
import 'package:fahem/data/response/main_categories_response.dart';
import 'package:fahem/data/response/playlists_response.dart';
import 'package:fahem/domain/usecases/accounts/get_accounts_usecase.dart';
import 'package:fahem/domain/usecases/booking_appointments/insert_booking_appointment_usecase.dart';
import 'package:fahem/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';
import 'package:fahem/domain/usecases/instant_consultations_comments/get_instant_consultations_comments_usecase.dart';
import 'package:fahem/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem/domain/usecases/phone_number_requests/insert_phone_number_request_usecase.dart';
import 'package:fahem/domain/usecases/playlists/get_playlists_usecase.dart';
import 'package:fahem/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/data/response/categories_response.dart';
import 'package:fahem/data/response/users_response.dart';
import 'package:fahem/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class Dialogs {

  static Future<void> showBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    required Widget child,
  }) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      barrierColor: ColorsManager.black.withOpacity(0.8),
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(SizeManager.s30),
          topEnd: Radius.circular(SizeManager.s30),
        ),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => isDismissible,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Directionality(
              textDirection: Methods.getDirection(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SizeManager.s16, horizontal: SizeManager.s24),
                child: child,
              ),
            ),
          ),
        );
      },
    ).then((value) => thenMethod != null ? thenMethod() : null);
  }

  static Future<bool> showBottomSheetConfirmation({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    required String message,
  }) async {
    bool result = false;

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeightManager.bold,
                height: SizeManager.s1_8,
              ),
            ),
            const SizedBox(height: SizeManager.s20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonType: ButtonType.text,
                    onPressed: () {
                      Navigator.pop(context);
                      result = true;
                    },
                    text: Methods.getText(StringsManager.ok).toUpperCase(),
                    width: double.infinity,
                    height: SizeManager.s40,
                    textFontWeight: FontWeightManager.black,
                  ),
                ),
                const SizedBox(width: SizeManager.s20),
                Expanded(
                  child: CustomButton(
                    buttonType: ButtonType.text,
                    onPressed: () {
                      Navigator.pop(context);
                      result = false;
                    },
                    text: Methods.getText(StringsManager.cancel).toUpperCase(),
                    width: double.infinity,
                    height: SizeManager.s40,
                    textFontWeight: FontWeightManager.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<void> showBottomSheetMessage({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    ShowMessage showMessage = ShowMessage.failure,
    required String message,
  }) async {
    Timer timer = Timer(const Duration(seconds: ConstantsManager.bottomSheetClosedDuration), () => Navigator.pop(context));

    return Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: () {
        if(thenMethod != null) thenMethod();
        timer.cancel();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              showMessage == ShowMessage.success ? LottieManager.success : LottieManager.failure,
              width: showMessage == ShowMessage.success ? SizeManager.s200 : SizeManager.s150,
              height: showMessage == ShowMessage.success ? SizeManager.s200 : SizeManager.s150,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: SizeManager.s16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: showMessage == ShowMessage.success ? ColorsManager.success : ColorsManager.failure,
                fontWeight: FontWeightManager.black,
                height: SizeManager.s1_8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> failureOccurred({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    required Failure failure,
  }) async {
    Dialogs.showBottomSheetMessage(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      message: MyProviders.appProvider.isEnglish ? failure.messageEn.toCapitalized() : failure.messageAr.toCapitalized(),
    );
  }

  static Future<void> showPermissionDialog({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    required String title,
    required String message,
  }) {
    return Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(ImagesManager.location, height: SizeManager.s200),
            ),
            const SizedBox(height: SizeManager.s20),
            Text(
              Methods.getText(title).toCapitalized(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.semiBold),
            ),
            const SizedBox(height: SizeManager.s20),
            Text(
              Methods.getText(message).toCapitalized(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: SizeManager.s20),
            CustomButton(
              buttonType: ButtonType.text,
              onPressed: () {
                Navigator.pop(context);
                Geolocator.openLocationSettings();
              },
              text: Methods.getText(StringsManager.ok).toUpperCase(),
              width: double.infinity,
              height: SizeManager.s40,
            ),
          ],
        ),
      ),
    );
  }

  static Future<String?> reasonOfRejectBottomSheet({
    required BuildContext context,
    Function? thenMethod,
  }) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textEditingControllerReasonOfReject = TextEditingController();
    String? result;

    await Dialogs.showBottomSheet(
      context: context,
      thenMethod: thenMethod,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
              ),
              const SizedBox(height: SizeManager.s20),
              CustomTextFormField(
                controller: textEditingControllerReasonOfReject,
                labelText: '${Methods.getText(StringsManager.writeTheReasonForRejection).toTitleCase()} *',
                validator: Validator.validateEmpty,
              ),
              const SizedBox(height: SizeManager.s20),
              CustomButton(
                buttonType: ButtonType.text,
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    result = textEditingControllerReasonOfReject.text.trim();
                    Navigator.pop(context);
                  }
                },
                width: double.infinity,
                text: Methods.getText(StringsManager.send).toTitleCase(),
              ),
            ],
          ),
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<UserModel?> usersBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<UserModel> searchUsers = [];
    UserModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, UsersResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchUsers = data.users;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchUsers = data.users.where((element) {
                            return element.fullName.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchUsers = data.users;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.users).toTitleCase()} (${searchUsers.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchUsers[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.prePersonalImageNetworkPostSpacer,
                              text: searchUsers[index].fullName,
                              imageName: searchUsers[index].personalImage,
                              imageDirectory: ApiConstants.usersDirectory,
                              defaultImage: ImagesManager.defaultAvatar,
                              imageSize: SizeManager.s40,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchUsers.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getUsersUseCase.call(GetUsersParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<InstantConsultationModel?> instantConsultationsBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<InstantConsultationModel> searchInstantConsultations = [];
    InstantConsultationModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, InstantConsultationsResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchInstantConsultations = data.instantConsultations;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchHere).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchInstantConsultations = data.instantConsultations.where((element) {
                            return element.instantConsultationId.toString().toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchInstantConsultations = data.instantConsultations;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.instantConsultations).toTitleCase()} (${searchInstantConsultations.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchInstantConsultations[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: '#${searchInstantConsultations[index].instantConsultationId.toString()}',
                              imageSize: SizeManager.s40,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchInstantConsultations.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getInstantConsultationsUseCase.call(GetInstantConsultationsParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<MainCategoryModel?> mainCategoriesBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<MainCategoryModel> searchMainCategories = [];
    MainCategoryModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, MainCategoriesResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchMainCategories = data.mainCategories;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchMainCategories = data.mainCategories.where((element) {
                            return element.nameAr.toLowerCase().contains(val.trim().toLowerCase())
                                || element.nameEn.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchMainCategories = data.mainCategories;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.mainCategories).toTitleCase()} (${searchMainCategories.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchMainCategories[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: MyProviders.appProvider.isEnglish ? searchMainCategories[index].nameEn : searchMainCategories[index].nameAr,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchMainCategories.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getMainCategoriesUseCase.call(GetMainCategoriesParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<AccountModel?> accountsBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<AccountModel> searchAccounts = [];
    AccountModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, AccountsResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchAccounts = data.accounts;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchAccounts = data.accounts.where((element) {
                            return element.fullName.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchAccounts = data.accounts;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.accounts).toTitleCase()} (${searchAccounts.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchAccounts[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.prePersonalImageNetworkPostSpacer,
                              text: searchAccounts[index].fullName,
                              imageName: searchAccounts[index].personalImage,
                              imageDirectory: ApiConstants.accountsDirectory,
                              defaultImage: ImagesManager.defaultAvatar,
                              imageSize: SizeManager.s40,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchAccounts.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getAccountsUseCase.call(GetAccountsParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<InstantConsultationCommentModel?> instantConsultationCommentsBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
    required int instantConsultationId,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<InstantConsultationCommentModel> searchInstantConsultationComments = [];
    InstantConsultationCommentModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, InstantConsultationsCommentsResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchInstantConsultationComments = data.instantConsultationsComments;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByComment).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchInstantConsultationComments = data.instantConsultationsComments.where((element) {
                            return element.comment.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchInstantConsultationComments = data.instantConsultationsComments;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          Methods.getText(StringsManager.chooseBestComment).toTitleCase(),
                          // '${Methods.getText(StringsManager.comments).toTitleCase()} (${searchInstantConsultationComments.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchInstantConsultationComments[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: searchInstantConsultationComments[index].comment,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchInstantConsultationComments.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    Map<String, dynamic> filtersMap = {};
    filtersMap.addAll({'instantConsultation': instantConsultationId});
    filtersMap.addAll({'commentStatus': CommentStatus.active.name});

    GetInstantConsultationsCommentsParameters parameters = GetInstantConsultationsCommentsParameters(
      filtersMap: jsonEncode(filtersMap),
    );

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getInstantConsultationsCommentsUseCase.call(parameters),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<PlaylistModel?> playlistsBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<PlaylistModel> searchPlaylists = [];
    PlaylistModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, PlaylistsResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchPlaylists = data.playlists;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchPlaylists = data.playlists.where((element) {
                            return element.playlistNameAr.toLowerCase().contains(val.trim().toLowerCase())
                            || element.playlistNameEn.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchPlaylists = data.playlists;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.playlists).toTitleCase()} (${searchPlaylists.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchPlaylists[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.postSpacerText,
                              text: MyProviders.appProvider.isEnglish ? searchPlaylists[index].playlistNameEn : searchPlaylists[index].playlistNameAr,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchPlaylists.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getPlaylistsUseCase.call(GetPlaylistsParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<CategoryModel?> categoriesBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<CategoryModel> searchCategories = [];
    CategoryModel? result;

    Widget getWidget(AsyncSnapshot<Either<Failure, CategoriesResponse>>  snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          return snapshot.data!.fold((failure) {
            return Center(
              child: Text(
                MyProviders.appProvider.isEnglish ? failure.messageEn : failure.messageAr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20),
              ),
            );
          }, (data) {
            searchCategories = data.categories;
            return StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: textEditingControllerSearch,
                        hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                        prefixIconData: Icons.search,
                        prefixIconColor: ColorsManager.grey,
                        borderRadius: SizeManager.s50,
                        onChanged: (val) async {
                          searchCategories = data.categories.where((element) {
                            return element.nameAr.toLowerCase().contains(val.trim().toLowerCase()) ||
                                element.nameEn.toLowerCase().contains(val.trim().toLowerCase());
                          }).toList();
                          setState(() {});
                        },
                        onClickClearIcon: () {
                          searchCategories = data.categories;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                        child: Text(
                          '${Methods.getText(StringsManager.categories).toTitleCase()} (${searchCategories.length})',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CustomButton(
                              onPressed: () {
                                result = searchCategories[index];
                                Navigator.pop(context);
                              },
                              buttonType: ButtonType.prePersonalImageNetworkPostSpacer,
                              text: MyProviders.appProvider.isEnglish ? searchCategories[index].nameEn : searchCategories[index].nameAr,
                              imageName: searchCategories[index].image,
                              imageDirectory: ApiConstants.categoriesDirectory,
                              imageSize: SizeManager.s40,
                              buttonColor: ColorsManager.grey100,
                              textColor: ColorsManager.black,
                              width: double.infinity,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                          itemCount: searchCategories.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }
      return const SizedBox();
    }

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: FutureBuilder(
          future: DependencyInjection.getCategoriesUseCase.call(GetCategoriesParameters()),
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: () => Future.value(snapshot.connectionState != ConnectionState.waiting),
              child: getWidget(snapshot),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<CountryModel?> countriesBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<CountryModel> searchCountries = [...countriesData];
    CountryModel? result;

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: textEditingControllerSearch,
                    hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                    prefixIconData: Icons.search,
                    prefixIconColor: ColorsManager.grey,
                    borderRadius: SizeManager.s50,
                    onChanged: (val) async {
                      searchCountries = countriesData.where((element) {
                        return element.countryNameAr.toLowerCase().contains(val.trim().toLowerCase()) ||
                            element.countryNameEn.toLowerCase().contains(val.trim().toLowerCase());
                      }).toList();
                      setState(() {});
                    },
                    onClickClearIcon: () {
                      searchCountries = [...countriesData];
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                    child: Text(
                      '${Methods.getText(StringsManager.countries).toTitleCase()} (${searchCountries.length})',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CustomButton(
                          onPressed: () {
                            result = searchCountries[index];
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.postSpacerText,
                          text: MyProviders.appProvider.isEnglish ? searchCountries[index].countryNameEn : searchCountries[index].countryNameAr,
                          buttonColor: ColorsManager.grey100,
                          textColor: ColorsManager.black,
                          width: double.infinity,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                      itemCount: searchCountries.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<CurrencyModel?> currenciesBottomSheet({
    required BuildContext context,
    bool isDismissible = true,
    Function? thenMethod,
  }) async {
    final TextEditingController textEditingControllerSearch = TextEditingController();
    List<CurrencyModel> searchCurrencies = [...currenciesData];
    CurrencyModel? result;

    await Dialogs.showBottomSheet(
      context: context,
      isDismissible: isDismissible,
      thenMethod: thenMethod,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: textEditingControllerSearch,
                    hintText: Methods.getText(StringsManager.searchByName).toCapitalized(),
                    prefixIconData: Icons.search,
                    prefixIconColor: ColorsManager.grey,
                    borderRadius: SizeManager.s50,
                    onChanged: (val) async {
                      searchCurrencies = currenciesData.where((element) {
                        return element.currencyNameEn.toLowerCase().contains(val.trim().toLowerCase()) ||
                            element.currencyNameAr.toLowerCase().contains(val.trim().toLowerCase());
                      }).toList();
                      setState(() {});
                    },
                    onClickClearIcon: () {
                      searchCurrencies = [...currenciesData];
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: SizeManager.s20),
                    child: Text(
                      '${Methods.getText(StringsManager.currencies).toTitleCase()} (${searchCurrencies.length})',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.semiBold),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CustomButton(
                          onPressed: () {
                            result = searchCurrencies[index];
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.postSpacerText,
                          text: MyProviders.appProvider.isEnglish ? searchCurrencies[index].currencyNameEn : searchCurrencies[index].currencyNameAr,
                          buttonColor: ColorsManager.grey100,
                          textColor: ColorsManager.black,
                          width: double.infinity,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                      itemCount: searchCurrencies.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<OrderByType?> orderByDialog({
    required BuildContext context,
    required List<OrderByType> items,
    OrderByType? currentValue,
  }) async {
    OrderByType? orderByGroupValue = currentValue;
    OrderByType? result;

    await Dialogs.showBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: SizeManager.s50,
                    height: SizeManager.s5,
                    decoration: BoxDecoration(
                      color: ColorsManager.grey300,
                      borderRadius: BorderRadius.circular(SizeManager.s100),
                    ),
                  ),
                ),
                const SizedBox(height: SizeManager.s20),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        Methods.getText(StringsManager.orderBy).toTitleCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s16, fontWeight: FontWeightManager.black),
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    const Icon(FontAwesomeIcons.sort, size: SizeManager.s18, color: ColorsManager.lightPrimaryColor),
                  ],
                ),
                const SizedBox(height: SizeManager.s10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) => RadioListTile(
                    value: items[index],
                    groupValue: orderByGroupValue,
                    title: Text(
                      Methods.getText(items[index].title).toCapitalized(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (val) => setState(() => orderByGroupValue = val!),
                  ),
                  separatorBuilder: (context, index) => const Divider(color: ColorsManager.grey, height: SizeManager.s0),
                ),
                const SizedBox(height: SizeManager.s20),
                CustomButton(
                  onPressed: () {
                    result = orderByGroupValue;
                    Navigator.pop(context);
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.apply).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s40,
                  borderRadius: SizeManager.s10,
                  textFontWeight: FontWeightManager.black,
                ),
              ],
            ),
          );
        },
      ),
    );

    return Future.value(result);
  }

  static Future<String?> getTextFromController({required BuildContext context, required String title}) async {
    String? result;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textController = TextEditingController();

    await showBottomSheet(
      context: context,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Methods.getText(title).toCapitalized(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
            ),
            const SizedBox(height: SizeManager.s20),
            CustomTextFormField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              borderRadius: SizeManager.s20,
              labelText: '${Methods.getText(StringsManager.writeHere).toTitleCase()} *',
              validator: Validator.validateEmpty,
            ),
            const SizedBox(height: SizeManager.s20),
            CustomButton(
              onPressed: () async {
                if(formKey.currentState!.validate()) {
                  result = textController.text.trim();
                  Navigator.pop(context);
                }
              },
              buttonType: ButtonType.text,
              text: Methods.getText(StringsManager.ok).toUpperCase(),
              width: double.infinity,
              height: SizeManager.s40,
            ),
          ],
        ),
      ),
    );

    return Future.value(result);
  }

  static Future<List<dynamic>> getUserReview({required BuildContext context}) async {
    List<dynamic> result = [null, null];
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textController = TextEditingController();
    double myRating = 0;
    String? ratingText;
    Color? ratingColor;

    await showBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Methods.getText(StringsManager.rateTheAccountNow).toCapitalized(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                ),
                const SizedBox(height: SizeManager.s20),
                CustomTextFormField(
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 5,
                  borderRadius: SizeManager.s20,
                  labelText: '${Methods.getText(StringsManager.writeYourReviewHere).toTitleCase()} *',
                  validator: Validator.validateEmpty,
                ),
                const SizedBox(height: SizeManager.s20),
                Center(
                  child: RatingBar.builder(
                    initialRating: myRating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: ColorsManager.amber,
                    ),
                    onRatingUpdate: (rating) {
                      myRating = rating;
                      if(rating >= 0 && rating < 1) {
                        ratingText = null;
                        ratingColor = null;
                      }
                      else if(rating >= 1 && rating < 2) {
                        ratingText = Methods.getText(StringsManager.lessThanExpected).toCapitalized();
                        ratingColor = ColorsManager.red700;
                      }
                      else if(rating >= 2 && rating < 4) {
                        ratingText = Methods.getText(StringsManager.good).toCapitalized();
                        ratingColor = ColorsManager.orange;
                      }
                      else if(rating >= 4 && rating <= 5) {
                        ratingText = Methods.getText(StringsManager.excellent).toCapitalized();
                        ratingColor = ColorsManager.green;
                      }
                      else {
                        ratingText = null;
                        ratingColor = null;
                      }
                      setState(() {});
                    },
                    updateOnDrag: true,
                  ),
                ),
                const SizedBox(height: SizeManager.s20),
                if(ratingText != null && ratingColor != null) ...[
                  Center(
                    child: Text(
                      ratingText!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ratingColor,
                        fontWeight: FontWeightManager.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: SizeManager.s20),
                ],
                CustomButton(
                  onPressed: () async {
                    if(formKey.currentState!.validate() && myRating >= 1) {
                      result[0] = textController.text.trim();
                      result[1] = myRating;
                      Navigator.pop(context);
                    }
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.send).toUpperCase(),
                  width: double.infinity,
                  height: SizeManager.s40,
                ),
              ],
            ),
          );
        },
      ),
    );

    return Future.value(result);
  }

  static Future<void> addMoneyToWallet({required BuildContext context, required WalletHistoryProvider walletHistoryProvider}) async {
    if(MyProviders.authenticationProvider.currentUser == null) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
      ).then((value) async {
        if(value) {
          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
        }
      });
      return;
    }

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textEditingControllerBalance = TextEditingController();

    showBottomSheet(
      context: context,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded),
                const SizedBox(width: SizeManager.s10),
                Text(
                  Methods.getText(StringsManager.addMoneyToWallet).toCapitalized(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s20),
            CustomTextFormField(
              controller: textEditingControllerBalance,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              labelText: '${Methods.getText(StringsManager.enterTheAmount).toCapitalized()} *',
              prefixIconData: FontAwesomeIcons.coins,
              validator: Validator.validateIntegerNumberNotAllowZero,
            ),
            const SizedBox(height: SizeManager.s20),
            CustomButton(
              onPressed: () async {
                if(formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  await KashierPaymentService.chargeWallet(
                    context: context,
                    customerName: MyProviders.authenticationProvider.currentUser!.fullName,
                    totalAmount: int.parse(textEditingControllerBalance.text.trim()),
                    onPaymentStatusPaid: () {
                      int balance = int.parse(textEditingControllerBalance.text.trim());
                      InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
                        userType: UserType.user,
                        userId: MyProviders.authenticationProvider.currentUser!.userId,
                        accountId: null,
                        amount: balance,
                        walletTransactionType: WalletTransactionType.chargeWallet,
                        textAr: '${"تم شحن المحفظة برصيد"} $balance ${"جنية"}',
                        textEn: 'Charging the wallet with a balance of $balance EGP',
                        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                      );
                      walletHistoryProvider.insertWalletHistory(
                        context: context,
                        insertWalletHistoryParameters: insertWalletHistoryParameters,
                        successMessage: StringsManager.theBalanceHasBeenAddedToTheWallet,
                        isAddToMyBalance: true,
                      );
                    },
                  );
                }
              },
              buttonType: ButtonType.text,
              text: Methods.getText(StringsManager.add).toUpperCase(),
              width: double.infinity,
              height: SizeManager.s40,
            ),
          ],
        ),
      ),
    );
  }

  static Future<PaymentsMethods?> showPayConfirmationDialog({
    required BuildContext context,
    required String title,
    required int serviceCost,
  }) async {
    if(MyProviders.authenticationProvider.currentUser == null) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
      ).then((value) async {
        if(value) {
          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
        }
      });
      return null;
    }

    int currentBalance = MyProviders.authenticationProvider.currentUser!.balance;
    PaymentsMethods? result;

    await showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      barrierColor: ColorsManager.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: ColorsManager.lightSecondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(SizeManager.s30),
          topEnd: Radius.circular(SizeManager.s30),
        ),
      ),
      builder: (context) {
        return Directionality(
          textDirection: Methods.getDirection(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s32),
                  child: Image.asset(ImagesManager.creditCard, width: SizeManager.s350, height: SizeManager.s350),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16, vertical: SizeManager.s32),
                  decoration: const BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SizeManager.s30),
                      topRight: Radius.circular(SizeManager.s30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s24, fontWeight: FontWeightManager.bold),
                      ),
                      const SizedBox(height: SizeManager.s20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: SizeManager.s50,
                              padding: const EdgeInsets.all(SizeManager.s10),
                              decoration: BoxDecoration(
                                color: ColorsManager.lightPrimaryColor,
                                border: Border.all(color: ColorsManager.lightPrimaryColor),
                                borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(SizeManager.s10),
                                  bottomStart: Radius.circular(SizeManager.s10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  Methods.getText(StringsManager.serviceCost).toTitleCase(),
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: SizeManager.s50,
                              padding: const EdgeInsets.all(SizeManager.s10),
                              decoration: BoxDecoration(
                                color: ColorsManager.white,
                                border: Border.all(color: ColorsManager.lightPrimaryColor),
                                borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(SizeManager.s10),
                                  bottomEnd: Radius.circular(SizeManager.s10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$serviceCost ${Methods.getText(StringsManager.egp).toUpperCase()}',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeightManager.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeManager.s10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(SizeManager.s10),
                              child: Text(
                                '${Methods.getText(StringsManager.yourCurrentWalletBalance)} $currentBalance ${Methods.getText(StringsManager.egp).toTitleCase()}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          // CustomButton(
                          //   buttonType: ButtonType.text,
                          //   onPressed: () => addMoneyToWallet(context: context),
                          //   text: Methods.getText(StringsManager.chargeYourWallet).toCapitalized(),
                          //   width: SizeManager.s100,
                          //   height: SizeManager.s35,
                          //   borderRadius: SizeManager.s5,
                          // ),
                        ],
                      ),
                      const SizedBox(height: SizeManager.s10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.text,
                              onPressed: () {
                                Navigator.pop(context);
                                result = PaymentsMethods.direct;
                              },
                              text: Methods.getText(StringsManager.payNow2).toCapitalized(),
                              width: double.infinity,
                              textFontWeight: FontWeightManager.black,
                            ),
                          ),
                          const SizedBox(width: SizeManager.s10),
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.text,
                              onPressed: () {
                                Navigator.pop(context);
                                result = PaymentsMethods.wallet;
                              },
                              text: Methods.getText(StringsManager.payFromYourWallet).toCapitalized(),
                              width: double.infinity,
                              textFontWeight: FontWeightManager.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return Future.value(result);
  }

  static Future<void> onPressedCallNow({
    required BuildContext context,
    // required String title,
    required AccountModel account,
  }) async {
    if(MyProviders.authenticationProvider.currentUser == null) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
      ).then((value) async {
        if(value) {
          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
        }
      });
      return;
    }

    UserModel currentUser = MyProviders.authenticationProvider.currentUser!;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController textEditingControllerName = TextEditingController(text: currentUser.fullName);
    final TextEditingController textEditingControllerPhoneNumber = TextEditingController(text: currentUser.phoneNumber);
    bool isLoading = false;
    bool isDataValid = false;

    // Insert Phone Number Request
    InsertPhoneNumberRequestParameters insertPhoneNumberRequestParameters = InsertPhoneNumberRequestParameters(
      accountId: account.accountId,
      userId: currentUser.userId,
      isViewed: false,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    Either<Failure, PhoneNumberRequestModel> response = await DependencyInjection.insertPhoneNumberRequestUseCase.call(insertPhoneNumberRequestParameters);
    await response.fold((failure) async {
        // setState(() {isLoading = false;});
        await Dialogs.failureOccurred(context: context, failure: failure);
      }, (phoneNumberRequest) async {
      Methods.sendNotificationToBusiness(
        accountId: account.accountId,
        title: 'طلب رقم الموبايل',
        body: '${"قام"} ${MyProviders.authenticationProvider.currentUser!.fullName} ${"بطلب رقم الموبايل"}',
      );

        // setState(() {isLoading = false;});
        // NotificationService.pushNotification(topic: '$targetId${transactionsProvider.getKeyword(transactionType)}', title: 'طلب رقم الموبايل', body: 'العميل $name قام بطلب رقم الموبايل');
        // Dialogs.showBottomSheetMessage(
        //   context: context,
        //   message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
        //   showMessage: ShowMessage.success,
        //   thenMethod: () => Navigator.pop(context, phoneNumberRequest),
        // );
      });

    Dialogs.showBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImagesManager.enterData, width: SizeManager.s350, height: SizeManager.s350),
                // !isDataValid ? Form(
                //   key: formKey,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         title,
                //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.medium),
                //       ),
                //       const SizedBox(height: SizeManager.s40),
                //       CustomTextFormField(
                //         controller: textEditingControllerName,
                //         textInputAction: TextInputAction.next,
                //         labelText: '${Methods.getText(StringsManager.name).toCapitalized()} *',
                //         prefixIcon: const Icon(Icons.person_outlined, color: ColorsManager.lightPrimaryColor),
                //         suffixIcon: IconButton(
                //           onPressed: () => textEditingControllerName.clear(),
                //           icon: const Icon(Icons.clear, color: ColorsManager.lightPrimaryColor),
                //         ),
                //         validator: Validator.validateEmpty,
                //       ),
                //       const SizedBox(height: SizeManager.s30),
                //       CustomTextFormField(
                //         controller: textEditingControllerPhoneNumber,
                //         textInputAction: TextInputAction.done,
                //         keyboardType: TextInputType.phone,
                //         maxLength: 11,
                //         labelText: '${Methods.getText(StringsManager.phoneNumber).toCapitalized()} *',
                //         prefixIcon: const Icon(Icons.phone, color: ColorsManager.lightPrimaryColor),
                //         suffixIcon: IconButton(
                //           onPressed: () => textEditingControllerPhoneNumber.clear(),
                //           icon: const Icon(Icons.clear, color: ColorsManager.lightPrimaryColor),
                //         ),
                //         validator: Validator.validatePhoneNumber,
                //       ),
                //       const SizedBox(height: SizeManager.s40),
                //       CustomButton(
                //         buttonType: ButtonType.text,
                //         onPressed: () async {
                //           FocusScope.of(context).unfocus();
                //           if(formKey.currentState!.validate()) {
                //             setState(() {isLoading = true;});
                //
                //             // Insert Phone Number Request
                //             InsertPhoneNumberRequestParameters insertPhoneNumberRequestParameters = InsertPhoneNumberRequestParameters(
                //               accountId: accountId,
                //               userId: currentUser.userId,
                //               isViewed: false,
                //               createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                //             );
                //             Either<Failure, PhoneNumberRequestModel> response = await DependencyInjection.insertPhoneNumberRequestUseCase.call(insertPhoneNumberRequestParameters);
                //             await response.fold((failure) async {
                //               setState(() {isLoading = false;});
                //               await Dialogs.failureOccurred(context: context, failure: failure);
                //             }, (phoneNumberRequest) async {
                //               setState(() {isLoading = false;});
                //               // NotificationService.pushNotification(topic: '$targetId${transactionsProvider.getKeyword(transactionType)}', title: 'طلب رقم الموبايل', body: 'العميل $name قام بطلب رقم الموبايل');
                //               // Dialogs.showBottomSheetMessage(
                //               //   context: context,
                //               //   message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
                //               //   showMessage: ShowMessage.success,
                //               //   thenMethod: () => Navigator.pop(context, phoneNumberRequest),
                //               // );
                //             });
                //
                //             // Insert Transaction
                //             // TransactionModel transactionModel = TransactionModel(
                //             //   transactionId: 0,
                //             //   targetId: targetId,
                //             //   userAccountId: userAccountProvider.userAccount!.userAccountId,
                //             //   name: textEditingControllerName.text.trim(),
                //             //   phoneNumber: textEditingControllerPhoneNumber.text.trim(),
                //             //   emailAddress: userAccountProvider.userAccount!.emailAddress ?? 'null',
                //             //   textAr: textAr,
                //             //   textEn: textEn,
                //             //   transactionType: transactionType,
                //             //   isViewed: false,
                //             //   createdAt: DateTime.now(),
                //             // );
                //             // InsertTransactionParameters parameters = InsertTransactionParameters(
                //             //   transactionModel: transactionModel,
                //             // );
                //             // Either<Failure, TransactionModel> response = await transactionsProvider.insertTransactionImpl(parameters);
                //             // response.fold((failure) async {
                //             //   setState(() {isLoading = false;});
                //             //   Dialogs.failureOccurred(context, failure);
                //             // }, (transaction) async {
                //             //   CacheHelper.setData(key: PREFERENCES_KEY_IS_TRANSACTIONS_PAGE_VIEWED, value: false);
                //             //   NotificationService.pushNotification(topic: '$targetId${transactionsProvider.getKeyword(transactionType)}', title: 'طلب رقم الموبايل', body: 'العميل $name قام بطلب رقم الموبايل');
                //             //   setState(() {isLoading = false;});
                //             //   transactionsProvider.addTransaction(transaction);
                //             //   setState(() => isDataValid = true);
                //             // });
                //           }
                //         },
                //         text: Methods.getText(StringsManager.showTheNumber).toTitleCase(),
                //       ),
                //     ],
                //   ),
                // ) :
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   'nameee',
                    //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
                    // ),
                    // const SizedBox(height: SizeManager.s10),
                    Text(
                      account.fullName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.medium),
                    ),
                    const SizedBox(height: SizeManager.s20),
                    Text(
                      account.phoneNumber!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s30, fontWeight: FontWeightManager.medium),
                    ),
                    const SizedBox(height: SizeManager.s20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonType: ButtonType.postImage,
                            onPressed: () => Methods.openUrl(url: 'tel:${account.phoneNumber}'),
                            text: Methods.getText(StringsManager.callNow).toTitleCase(),
                            imageName: IconsManager.animatedPhone,
                            imageColor: ColorsManager.lightPrimaryColor,
                            imageSize: SizeManager.s25,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.lightPrimaryColor,
                            textColor: ColorsManager.lightPrimaryColor,
                            height: SizeManager.s40,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(width: SizeManager.s20),
                        Expanded(
                          child: CustomButton(
                            buttonType: ButtonType.postImage,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: account.phoneNumber!));
                              Dialogs.showBottomSheetMessage(
                                context: context,
                                message: Methods.getText(StringsManager.theNumberHasBeenCopied).toCapitalized(),
                                showMessage: ShowMessage.success,
                              );
                            },
                            text: Methods.getText(StringsManager.copyTheNumber).toTitleCase(),
                            imageName: IconsManager.animatedCopy,
                            imageColor: ColorsManager.white,
                            imageSize: SizeManager.s25,
                            height: SizeManager.s40,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static void chooseAppointmentBooking({
    required BuildContext context,
    required AccountModel account,
    // required String title,
    // required int targetId,
    // required String textAr,
    // required String textEn,
    // required List<String> periodsIds,
  }) {
    if(MyProviders.authenticationProvider.currentUser == null) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
      ).then((value) async {
        if(value) {
          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
        }
      });
      return;
    }

    TimeOfDay? time;
    DateTime? date;

    showBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: SizeManager.s10),
                  Text(
                    Methods.getText(StringsManager.appointmentBooking).toCapitalized(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                  ),
                ],
              ),
              const SizedBox(height: SizeManager.s20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Methods.getText(StringsManager.chooseDate).toCapitalized(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: SizeManager.s5),
                        CustomButton(
                          buttonType: ButtonType.preIconPostClickableIcon,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await Methods.selectDateFromPicker(
                              context: context,
                              title: StringsManager.selectDate,
                              initialDate: date ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(seconds: 365)),
                            ).then((dateTime) {
                              if(dateTime != null) {setState(() => date = dateTime);}
                            });
                          },
                          text: date == null
                              ? '${Methods.getText(StringsManager.date).toCapitalized()} *'
                              : Methods.formatDate(milliseconds: date!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                          iconData: FontAwesomeIcons.calendar,
                          postClickableIconData: date == null ? null : Icons.clear,
                          onPressedPostClickableIcon: date == null ? null : () {
                            FocusScope.of(context).unfocus();
                            setState(() => date = null);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                          width: double.infinity,
                          buttonColor: ColorsManager.white,
                          borderColor: ColorsManager.grey300,
                          iconColor: ColorsManager.grey,
                          textColor: date == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                          fontSize: SizeManager.s12,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SizeManager.s10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Methods.getText(StringsManager.chooseDate).toCapitalized(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: SizeManager.s5),
                        CustomButton(
                          buttonType: ButtonType.preIconPostClickableIcon,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await Methods.selectTimeFromPicker(
                              context: context,
                              initialTime: time ?? TimeOfDay.now(),
                            ).then((timeOfDay) {
                              if(timeOfDay != null) {setState(() => time = timeOfDay);}
                            });
                          },
                          text: time == null
                              ? '${Methods.getText(StringsManager.time).toCapitalized()} *'
                              : MyProviders.appProvider.isEnglish
                              ? time!.format(context)
                              : time!.format(context).contains(RegExp(r'AM'))
                              ? time!.format(context).replaceFirst(RegExp(r'AM'), 'صباحا')
                              : time!.format(context).replaceFirst(RegExp(r'PM'), 'مساءا'),
                          iconData: FontAwesomeIcons.clock,
                          postClickableIconData: time == null ? null : Icons.clear,
                          onPressedPostClickableIcon: time == null ? null : () {
                            FocusScope.of(context).unfocus();
                            setState(() => time = null);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                          width: double.infinity,
                          buttonColor: ColorsManager.white,
                          borderColor: ColorsManager.grey300,
                          iconColor: ColorsManager.grey,
                          textColor: time == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                          fontSize: SizeManager.s12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeManager.s20),
              CustomButton(
                onPressed: () async {
                  if(date != null && time != null) {
                    // Insert Booking Appointment
                    InsertBookingAppointmentParameters insertBookingAppointmentParameters = InsertBookingAppointmentParameters(
                      accountId: account.accountId,
                      userId: MyProviders.authenticationProvider.currentUser!.userId,
                      bookingDate: DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute).millisecondsSinceEpoch.toString(),
                      isViewed: false,
                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                    );
                    Either<Failure, BookingAppointmentModel> response = await DependencyInjection.insertBookingAppointmentUseCase.call(insertBookingAppointmentParameters);
                    await response.fold((failure) async {
                      // setState(() {isLoading = false;});
                      await Dialogs.failureOccurred(context: context, failure: failure);
                    }, (bookingAppointment) async {
                      Methods.sendNotificationToBusiness(
                        accountId: account.accountId,
                        title: 'حجز ميعاد',
                        body: '${"قام"} ${MyProviders.authenticationProvider.currentUser!.fullName} ${"بحجز ميعاد"}',
                      );
                      Dialogs.showBottomSheetMessage(
                        context: context,
                        message: Methods.getText(StringsManager.addedSuccessfully).toTitleCase(),
                        showMessage: ShowMessage.success,
                        thenMethod: () => Navigator.pop(context),
                      );
                    });
                  }



                  // if(formKey.currentState!.validate()) {
                  //   Navigator.pop(context);
                  //   await KashierPaymentService.chargeWallet(
                  //     context: context,
                  //     customerName: MyProviders.authenticationProvider.currentUser.fullName,
                  //     totalAmount: int.parse(textEditingControllerBalance.text.trim()),
                  //     onPaymentStatusPaid: () {
                  //       int balance = int.parse(textEditingControllerBalance.text.trim());
                  //       InsertWalletHistoryParameters insertWalletHistoryParameters = InsertWalletHistoryParameters(
                  //         userType: UserType.user,
                  //         userId: MyProviders.authenticationProvider.currentUser.userId,
                  //         accountId: null,
                  //         amount: balance,
                  //         walletTransactionType: WalletTransactionType.chargeWallet,
                  //         textAr: '${"تم شحن المحفظة برصيد"} $balance ${"جنية"}',
                  //         textEn: 'Charging the wallet with a balance of $balance EGP',
                  //         createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  //       );
                  //       walletHistoryProvider.insertWalletHistory(
                  //         context: context,
                  //         insertWalletHistoryParameters: insertWalletHistoryParameters,
                  //         successMessage: StringsManager.theBalanceHasBeenAddedToTheWallet,
                  //         isAddToMyBalance: true,
                  //       );
                  //     },
                  //   );
                  // }
                },
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.booking).toUpperCase(),
                width: double.infinity,
                height: SizeManager.s40,
              ),
            ],
          );
        },
      ),
    );

    // DateTime date = DateTime.now();
    // String? period;
    // bool isLoading = false;
    // bool isDone = false;
    // bool isValidate = false;
    // Timer? timer;
    // List<PeriodModel> selectedPeriods = [];
    // for(int i=0; i<periodsIds.length; i++) {
    //   int index = periodsData.indexWhere((element) => element.periodId == periodsIds[i]);
    //   selectedPeriods.add(periodsData[index]);
    // }
    //
    // Dialogs.showBottomSheet(
    //   context: context,
    //   thenMethod: () => timer?.cancel(),
    //   child: StatefulBuilder(
    //     builder: (context, setState) {
    //       return AbsorbPointerWidget(
    //         absorbing: isLoading,
    //         child: !isDone ? Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 title,
    //                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.black),
    //               ),
    //             ),
    //             const SizedBox(height: SizeManager.s20),
    //             Text(
    //               Methods.getText(StringsManager.chooseTheDate, appProvider.isEnglish).toCapitalized(),
    //               style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.black),
    //             ),
    //             const SizedBox(height: SizeManager.s10),
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: ColorsManager.white,
    //                 borderRadius: BorderRadius.circular(SizeManager.s10),
    //                 border: Border.all(color: ColorsManager.grey300),
    //               ),
    //               child: CalendarDatePicker(
    //                 initialDate: DateTime.now(),
    //                 firstDate: DateTime.now(),
    //                 lastDate: DateTime.now().add(const Duration(days: 30)),
    //                 onDateChanged: (value) => date = value,
    //               ),
    //             ),
    //             const SizedBox(height: SizeManager.s20),
    //             Text(
    //               Methods.getText(StringsManager.chooseThePeriod, appProvider.isEnglish).toCapitalized(),
    //               style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.black),
    //             ),
    //             ListView.builder(
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemBuilder: (context, index) => Material(
    //                 color: Colors.transparent,
    //                 child: RadioListTile(
    //                   value: selectedPeriods[index].periodId,
    //                   groupValue: period,
    //                   onChanged: (val) {
    //                     setState(() {
    //                       period = val;
    //                       isValidate = true;
    //                     });
    //                   },
    //                   title: Text(
    //                     appProvider.isEnglish ? selectedPeriods[index].nameEn : selectedPeriods[index].nameAr,
    //                     style: Theme.of(context).textTheme.bodyLarge,
    //                   ),
    //                 ),
    //               ),
    //               itemCount: selectedPeriods.length,
    //             ),
    //             const SizedBox(height: SizeManager.s20),
    //             IgnorePointer(
    //               ignoring: !isValidate,
    //               child: CustomButton(
    //                 buttonType: ButtonType.text,
    //                 onPressed: () async {
    //                   Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureAboutTheProcessOfBookingAConsultation, appProvider.isEnglish).toCapitalized()).then((value) async {
    //                     if(value) {
    //                       setState(() => isLoading = true);
    //
    //                       // Insert Transaction
    //                       TransactionModel transactionModel = TransactionModel(
    //                         transactionId: 0,
    //                         targetId: targetId,
    //                         userAccountId: userAccountProvider.userAccount!.userAccountId,
    //                         name: name,
    //                         phoneNumber: userAccountProvider.userAccount!.phoneNumber,
    //                         emailAddress: userAccountProvider.userAccount!.emailAddress ?? 'null',
    //                         textAr: '$textAr ${selectedPeriods.firstWhere((element) => element.periodId == period).nameAr}',
    //                         textEn: '$textEn ${selectedPeriods.firstWhere((element) => element.periodId == period).nameEn}',
    //                         bookingDateTimeStamp: date.millisecondsSinceEpoch.toString(),
    //                         transactionType: transactionType,
    //                         isViewed: false,
    //                         createdAt: DateTime.now(),
    //                       );
    //                       InsertTransactionParameters parameters = InsertTransactionParameters(
    //                         transactionModel: transactionModel,
    //                       );
    //                       Either<Failure, TransactionModel> response = await transactionsProvider.insertTransactionImpl(parameters);
    //                       response.fold((failure) async {
    //                         setState(() {isLoading = false;});
    //                         Dialogs.failureOccurred(context, failure);
    //                       }, (transaction) async {
    //                         CacheHelper.setData(key: PREFERENCES_KEY_IS_TRANSACTIONS_PAGE_VIEWED, value: false);
    //                         NotificationService.pushNotification(topic: '$targetId${transactionsProvider.getKeyword(transactionType)}', title: 'حجز ميعاد', body: 'العميل $name قام بحجز ميعاد بتاريخ ${intl.DateFormat.yMMMMd('ar_EG').format(DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch))} فى الفترة ${periodsData.firstWhere((element) => element.periodId == period).nameAr}');
    //                         transactionsProvider.addTransaction(transaction);
    //                         setState(() {
    //                           isLoading = false;
    //                           isDone = true;
    //                         });
    //                         timer = Timer(const Duration(seconds: ConstantsManager.bottomSheetClosedDuration), () => Navigator.pop(context));
    //                       });
    //                     }
    //                   });
    //                 },
    //                 text: Methods.getText(StringsManager.book, appProvider.isEnglish).toTitleCase(),
    //                 buttonColor: isValidate ? ColorsManager.secondaryColor : ColorsManager.secondaryColor.withOpacity(0.5),
    //               ),
    //             ),
    //           ],
    //         ) : messageWidget(
    //           context: context,
    //           message: Methods.getText(StringsManager.consultationBooked, appProvider.isEnglish).toCapitalized(),
    //           showMessage: ShowMessage.success,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  // static Future<AccountModel?> chooseBetterLawyer(BuildContext context) async {
  //   LawyersProvider lawyersProvider = Provider.of<LawyersProvider>(context, listen: false);
  //   InstantConsultationCommentModel? selectedInstantConsultationComment;
  //   LawyerModel? result;
  //
  //   await Dialogs.showBottomSheet(
  //     context: context,
  //     child: StatefulBuilder(
  //       builder: (context, setState) {
  //         return Column(
  //           children: [
  //             Center(
  //               child: Text(
  //                 Methods.getText(StringsManager.chooseTheBestLawyer).toTitleCase(),
  //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.bold),
  //               ),
  //             ),
  //             const SizedBox(height: SizeManager.s20),
  //             ListView.separated(
  //               shrinkWrap: true,
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: instantConsultationsCommentsProvider.commentsForTransaction.length,
  //               itemBuilder: (context, index) {
  //                 return InkWell(
  //                   onTap: () => setState(() => selectedInstantConsultationComment = instantConsultationsCommentsProvider.commentsForTransaction[index]),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       border: Border.all(
  //                         color: selectedInstantConsultationComment != null && selectedInstantConsultationComment!.instantConsultationCommentId == instantConsultationsCommentsProvider.commentsForTransaction[index].instantConsultationCommentId
  //                             ? ColorsManager.primaryColor
  //                             : Colors.transparent,
  //                         width: SizeManager.s2,
  //                       ),
  //                     ),
  //                     child: InstantConsultationCommentItem(
  //                       instantConsultationCommentModel: instantConsultationsCommentsProvider.commentsForTransaction[index],
  //                       index: index,
  //                       isSupportOnTap: false,
  //                       boxColor: ColorsManager.grey1,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
  //             ),
  //             const SizedBox(height: SizeManager.s20),
  //             CustomButton(
  //               buttonType: ButtonType.text,
  //               text: Methods.getText(StringsManager.ok, appProvider.isEnglish).toCapitalized(),
  //               onPressed: () {
  //                 if(selectedInstantConsultationComment != null) result = lawyersProvider.getLawyerWithId(selectedInstantConsultationComment!.lawyerId);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   return Future.value(result);
  // }
}