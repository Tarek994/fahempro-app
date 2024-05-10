import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/data/data_source/static/countries_data.dart';
import 'package:fahem_business/data/data_source/static/currencies_data.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:fahem_business/data/models/playlist_model.dart';
import 'package:fahem_business/data/models/static/country_model.dart';
import 'package:fahem_business/data/models/static/currency_model.dart';
import 'package:fahem_business/data/response/accounts_response.dart';
import 'package:fahem_business/data/response/instant_consultations_response.dart';
import 'package:fahem_business/data/response/main_categories_response.dart';
import 'package:fahem_business/data/response/playlists_response.dart';
import 'package:fahem_business/domain/usecases/accounts/get_accounts_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/get_playlists_usecase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/category_model.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:fahem_business/data/response/categories_response.dart';
import 'package:fahem_business/data/response/users_response.dart';
import 'package:fahem_business/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

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
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: SizeManager.s1_8),
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
                fontWeight: FontWeightManager.medium,
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.medium),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s16, fontWeight: FontWeightManager.semiBold),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
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
}