import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/data/models/static/country_model.dart';
import 'package:fahem_dashboard/data/models/static/currency_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';

enum Filters {
  gender,
  userType,
  commentStatus,
  walletTransactionType,
  withdrawalRequestStatus,
  paymentType,
  startDateOfCreated,
  endDateOfCreated,
  startPeriodDate,
  endPeriodDate,
  singleDate,
  isFeatured,
  isSuper,
  isAvailable,
  isDone,
  user,
  account,
  mainCategory,
  category,
  playlist,
  instantConsultation,
  country,
  currency,
}

class FilterModel {
  Filters filter;
  dynamic value;

  FilterModel({required this.filter, required this.value});
}

class FiltersResult {
  static List<FilterModel> filters = [];
  static bool isApplyPressed = false;
}

class FiltersBtmSheet extends StatefulWidget {
  final List<FiltersType> items;
  final Map<String, String>? customText;

  const FiltersBtmSheet({
    super.key,
    required this.items,
    this.customText,
  });

  @override
  State<FiltersBtmSheet> createState() => _FiltersBtmSheetState();
}

class _FiltersBtmSheetState extends State<FiltersBtmSheet> {
  AdminModel currentAdmin = MyProviders.authenticationProvider.currentAdmin;

  Gender? gender;
  UserType? userType;
  CommentStatus? commentStatus;
  WalletTransactionType? walletTransactionType;
  WithdrawalRequestStatus? withdrawalRequestStatus;
  PaymentType? paymentType;
  DateTime? startDateOfCreated;
  DateTime? endDateOfCreated;
  DateTime? startPeriodDate;
  DateTime? endPeriodDate;
  DateTime? singleDate;
  bool? isFeatured;
  bool? isSuper;
  bool? isAvailable;
  bool? isDone;
  UserModel? user;
  AccountModel? account;
  MainCategoryModel? mainCategory;
  CategoryModel? category;
  PlaylistModel? playlist;
  InstantConsultationModel? instantConsultation;
  CountryModel? country;
  CurrencyModel? currency;

  void initData() {
    if (isExistInFilters(FiltersResult.filters, Filters.gender)) {
      gender = getFilterModel(FiltersResult.filters, Filters.gender).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.userType)) {
      userType = getFilterModel(FiltersResult.filters, Filters.userType).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.commentStatus)) {
      commentStatus = getFilterModel(FiltersResult.filters, Filters.commentStatus).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.walletTransactionType)) {
      walletTransactionType = getFilterModel(FiltersResult.filters, Filters.walletTransactionType).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.withdrawalRequestStatus)) {
      withdrawalRequestStatus = getFilterModel(FiltersResult.filters, Filters.withdrawalRequestStatus).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.paymentType)) {
      paymentType = getFilterModel(FiltersResult.filters, Filters.paymentType).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.startDateOfCreated)) {
      startDateOfCreated = getFilterModel(FiltersResult.filters, Filters.startDateOfCreated).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.endDateOfCreated)) {
      endDateOfCreated = getFilterModel(FiltersResult.filters, Filters.endDateOfCreated).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.startPeriodDate)) {
      startPeriodDate = getFilterModel(FiltersResult.filters, Filters.startPeriodDate).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.endPeriodDate)) {
      endPeriodDate = getFilterModel(FiltersResult.filters, Filters.endPeriodDate).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.singleDate)) {
      singleDate = getFilterModel(FiltersResult.filters, Filters.singleDate).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.isFeatured)) {
      isFeatured = getFilterModel(FiltersResult.filters, Filters.isFeatured).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.isSuper)) {
      isSuper = getFilterModel(FiltersResult.filters, Filters.isSuper).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.isAvailable)) {
      isAvailable = getFilterModel(FiltersResult.filters, Filters.isAvailable).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.isDone)) {
      isDone = getFilterModel(FiltersResult.filters, Filters.isDone).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.user)) {
      user = getFilterModel(FiltersResult.filters, Filters.user).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.account)) {
      account = getFilterModel(FiltersResult.filters, Filters.account).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.mainCategory)) {
      mainCategory = getFilterModel(FiltersResult.filters, Filters.mainCategory).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.category)) {
      category = getFilterModel(FiltersResult.filters, Filters.category).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.playlist)) {
      playlist = getFilterModel(FiltersResult.filters, Filters.playlist).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.instantConsultation)) {
      instantConsultation = getFilterModel(FiltersResult.filters, Filters.instantConsultation).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.country)) {
      country = getFilterModel(FiltersResult.filters, Filters.country).value;
    }
    if (isExistInFilters(FiltersResult.filters, Filters.currency)) {
      currency = getFilterModel(FiltersResult.filters, Filters.currency).value;
    }
  }

  bool isFoundAnyNotNull() {
    if(gender != null ||
        userType != null ||
        commentStatus != null ||
        walletTransactionType != null ||
        withdrawalRequestStatus != null ||
        paymentType != null ||
        startDateOfCreated != null ||
        endDateOfCreated != null ||
        startPeriodDate != null ||
        endPeriodDate != null ||
        singleDate != null ||
        isFeatured != null ||
        isSuper != null ||
        isAvailable != null ||
        isDone != null ||
        user != null ||
        account != null ||
        mainCategory != null ||
        category != null ||
        playlist != null ||
        instantConsultation != null ||
        country != null ||
        currency != null
    ) {
      return true;
    }
    return false;
  }

  void setAllToNull() {
    gender = null;
    userType = null;
    commentStatus = null;
    walletTransactionType = null;
    withdrawalRequestStatus = null;
    paymentType = null;
    startDateOfCreated = null;
    endDateOfCreated = null;
    startPeriodDate = null;
    endPeriodDate = null;
    singleDate = null;
    isFeatured = null;
    isSuper = null;
    isAvailable = null;
    isDone = null;
    user = null;
    account = null;
    mainCategory = null;
    category = null;
    playlist = null;
    instantConsultation = null;
    country = null;
    currency = null;
    FocusScope.of(context).unfocus();
  }

  bool _isAllDataValid() {
    return true;
  }

  void onPressedApply() {
    if (!_isAllDataValid()) return;
    FiltersResult.isApplyPressed = true;
    FiltersResult.filters = [
      if (gender != null) FilterModel(
        filter: Filters.gender,
        value: gender,
      ),
      if (userType != null) FilterModel(
        filter: Filters.userType,
        value: userType,
      ),
      if (commentStatus != null) FilterModel(
        filter: Filters.commentStatus,
        value: commentStatus,
      ),
      if (walletTransactionType != null) FilterModel(
        filter: Filters.walletTransactionType,
        value: walletTransactionType,
      ),
      if (withdrawalRequestStatus != null) FilterModel(
        filter: Filters.withdrawalRequestStatus,
        value: withdrawalRequestStatus,
      ),
      if (paymentType != null) FilterModel(
        filter: Filters.paymentType,
        value: paymentType,
      ),
      if (startDateOfCreated != null) FilterModel(
        filter: Filters.startDateOfCreated,
        value: DateTime(startDateOfCreated!.year, startDateOfCreated!.month, startDateOfCreated!.day),
      ),
      if (endDateOfCreated != null) FilterModel(
        filter: Filters.endDateOfCreated,
        value: DateTime(endDateOfCreated!.year, endDateOfCreated!.month, endDateOfCreated!.day),
      ),
      if (startPeriodDate != null) FilterModel(
        filter: Filters.startPeriodDate,
        value: DateTime(startPeriodDate!.year, startPeriodDate!.month, startPeriodDate!.day),
      ),
      if (endPeriodDate != null) FilterModel(
        filter: Filters.endPeriodDate,
        value: DateTime(endPeriodDate!.year, endPeriodDate!.month, endPeriodDate!.day),
      ),
      if (singleDate != null) FilterModel(
        filter: Filters.singleDate,
        value: DateTime(singleDate!.year, singleDate!.month, singleDate!.day),
      ),
      if (isFeatured != null) FilterModel(
        filter: Filters.isFeatured,
        value: isFeatured,
      ),
      if (isSuper != null) FilterModel(
        filter: Filters.isSuper,
        value: isSuper,
      ),
      if (isAvailable != null) FilterModel(
        filter: Filters.isAvailable,
        value: isAvailable,
      ),
      if (isDone != null) FilterModel(
        filter: Filters.isDone,
        value: isDone,
      ),
      if (user != null) FilterModel(
        filter: Filters.user,
        value: user,
      ),
      if (account != null) FilterModel(
        filter: Filters.account,
        value: account,
      ),
      if (mainCategory != null) FilterModel(
        filter: Filters.mainCategory,
        value: mainCategory,
      ),
      if (category != null) FilterModel(
        filter: Filters.category,
        value: category,
      ),
      if (playlist != null) FilterModel(
        filter: Filters.playlist,
        value: playlist,
      ),
      if (instantConsultation != null) FilterModel(
        filter: Filters.instantConsultation,
        value: instantConsultation,
      ),
      if (country != null) FilterModel(
        filter: Filters.country,
        value: country,
      ),
      if (currency != null) FilterModel(
        filter: Filters.currency,
        value: currency,
      ),
    ];
    Navigator.pop(context);
  }

  String _getStringFromCustomText({required FiltersType type, required String defaultText}) {
    if(widget.customText == null) return defaultText;
    if(widget.customText!.containsKey(type.name)) {return widget.customText![type.name]!;}
    return defaultText;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Methods.btmSheetSwiper(),
          const SizedBox(height: SizeManager.s20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        Methods.getText(StringsManager.filters).toTitleCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s16, fontWeight: FontWeightManager.semiBold),
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    const Icon(FontAwesomeIcons.filter, size: SizeManager.s18, color: ColorsManager.lightPrimaryColor),
                  ],
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              if(isFoundAnyNotNull()) CustomButton(
                onPressed: () => setState(() => setAllToNull()),
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.clearAll).toCapitalized(),
                height: SizeManager.s35,
                visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                buttonColor: Colors.transparent,
                textColor: ColorsManager.red700,
                fontSize: SizeManager.s12,
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s20),

          // Filters Selection
          if(isFoundAnyNotNull()) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Methods.getText(StringsManager.yourChoices).toCapitalized(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: SizeManager.s5),
              Wrap(
                spacing: SizeManager.s10,
                runSpacing: SizeManager.s10,
                children: [
                  if(gender != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.gender, defaultText: StringsManager.gender)).toCapitalized()}: ${Gender.toText(gender!)}',
                    onPressedClear: () => setState(() => gender = null),
                  ),
                  if(userType != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.userType, defaultText: StringsManager.accountType)).toCapitalized()}: ${UserType.toText(userType!)}',
                    onPressedClear: () => setState(() => userType = null),
                  ),
                  if(commentStatus != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.commentStatus, defaultText: StringsManager.commentStatus)).toCapitalized()}: ${CommentStatus.toText(commentStatus!)}',
                    onPressedClear: () => setState(() => commentStatus = null),
                  ),
                  if(walletTransactionType != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.walletTransactionType, defaultText: StringsManager.walletTransactionType)).toCapitalized()}: ${WalletTransactionType.toText(walletTransactionType!)}',
                    onPressedClear: () => setState(() => walletTransactionType = null),
                  ),
                  if(withdrawalRequestStatus != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.withdrawalRequestStatus, defaultText: StringsManager.withdrawalRequestStatus)).toCapitalized()}: ${WithdrawalRequestStatus.toText(withdrawalRequestStatus!)}',
                    onPressedClear: () => setState(() => withdrawalRequestStatus = null),
                  ),
                  if(paymentType != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.paymentType, defaultText: StringsManager.paymentType)).toCapitalized()}: ${PaymentType.toText(paymentType!)}',
                    onPressedClear: () => setState(() => paymentType = null),
                  ),
                  if(startDateOfCreated != null || endDateOfCreated != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.dateOfCreated, defaultText: StringsManager.dateOfAdded)).toCapitalized()}: ${Methods.getText(StringsManager.from)} ${startDateOfCreated == null ? '(-)' : '(${Methods.formatDate(milliseconds: startDateOfCreated!.millisecondsSinceEpoch, format: 'd MMMM yyyy')})'} ${Methods.getText(StringsManager.to)} ${endDateOfCreated == null ? '(-)' :  '(${Methods.formatDate(milliseconds: endDateOfCreated!.millisecondsSinceEpoch, format: 'd MMMM yyyy')})'}',
                    onPressedClear: () {
                      setState(() {
                        startDateOfCreated = null;
                        endDateOfCreated = null;
                      });
                    },
                  ),
                  if(startPeriodDate != null || endPeriodDate != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.periodDate, defaultText: StringsManager.period)).toCapitalized()}: ${Methods.getText(StringsManager.from)} ${startPeriodDate == null ? '(-)' : '(${Methods.formatDate(milliseconds: startPeriodDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy')})'} ${Methods.getText(StringsManager.to)} ${endPeriodDate == null ? '(-)' :  '(${Methods.formatDate(milliseconds: endPeriodDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy')})'}',
                    onPressedClear: () {
                      setState(() {
                        startPeriodDate = null;
                        endPeriodDate = null;
                      });
                    },
                  ),
                  if(singleDate != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.singleDate, defaultText: StringsManager.date)).toCapitalized()}: ${Methods.formatDate(milliseconds: singleDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy')}',
                    onPressedClear: () {
                      setState(() {
                        singleDate = null;
                      });
                    },
                  ),
                  if(isFeatured != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.isFeatured, defaultText: StringsManager.verifiedAccounts)).toCapitalized()}: ${Methods.getText(isFeatured! ? StringsManager.yes : StringsManager.no).toCapitalized()}',
                    onPressedClear: () => setState(() => isFeatured = null),
                  ),
                  if(isSuper != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.isSuper, defaultText: StringsManager.adminsWithAllPermissions)).toCapitalized()}: ${Methods.getText(isSuper! ? StringsManager.yes : StringsManager.no).toCapitalized()}',
                    onPressedClear: () => setState(() => isSuper = null),
                  ),
                  if(isAvailable != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.isAvailable, defaultText: StringsManager.isAvailable)).toCapitalized()}: ${Methods.getText(isAvailable! ? StringsManager.yes : StringsManager.no).toCapitalized()}',
                    onPressedClear: () => setState(() => isAvailable = null),
                  ),
                  if(isDone != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.isDone, defaultText: StringsManager.closedConsultations)).toCapitalized()}: ${Methods.getText(isDone! ? StringsManager.yes : StringsManager.no).toCapitalized()}',
                    onPressedClear: () => setState(() => isDone = null),
                  ),
                  if(user != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.user, defaultText: StringsManager.user)).toCapitalized()}: ${user!.fullName}',
                    onPressedClear: () => setState(() => user = null),
                  ),
                  if(account != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.account, defaultText: StringsManager.account)).toCapitalized()}: ${account!.fullName}',
                    onPressedClear: () => setState(() => account = null),
                  ),
                  if(mainCategory != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.mainCategory, defaultText: StringsManager.mainCategory)).toCapitalized()}: ${MyProviders.appProvider.isEnglish ? mainCategory!.nameEn : mainCategory!.nameAr}',
                    onPressedClear: () => setState(() => mainCategory = null),
                  ),
                  if(category != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.category, defaultText: StringsManager.category)).toCapitalized()}: ${MyProviders.appProvider.isEnglish ? category!.nameEn : category!.nameAr}',
                    onPressedClear: () => setState(() => category = null),
                  ),
                  if(playlist != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.playlist, defaultText: StringsManager.playlist)).toCapitalized()}: ${MyProviders.appProvider.isEnglish ? playlist!.playlistNameEn : playlist!.playlistNameAr}',
                    onPressedClear: () => setState(() => playlist = null),
                  ),
                  if(instantConsultation != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.instantConsultation, defaultText: StringsManager.instantConsultation)).toCapitalized()}: #${instantConsultation!.instantConsultationId}',
                    onPressedClear: () => setState(() => instantConsultation = null),
                  ),
                  if(country != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.country, defaultText: StringsManager.country)).toCapitalized()}: ${MyProviders.appProvider.isEnglish ? country!.countryNameEn : country!.countryNameAr}',
                    onPressedClear: () => setState(() => country = null),
                  ),
                  if(currency != null) _FilterSelectionItem(
                    text: '${Methods.getText(_getStringFromCustomText(type: FiltersType.currency, defaultText: StringsManager.currency)).toCapitalized()}: ${MyProviders.appProvider.isEnglish ? currency!.currencyNameEn : currency!.currencyNameAr}',
                    onPressedClear: () => setState(() => currency = null),
                  ),
                ],
              ),
              const SizedBox(height: SizeManager.s20),
            ],
          ),

          // gender Item
          if(widget.items.contains(FiltersType.gender)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.gender, defaultText: StringsManager.gender)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.gender),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => gender = Gender.male),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.male).toCapitalized(),
                        iconData: FontAwesomeIcons.person,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: gender == Gender.male ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: gender == Gender.male ? ColorsManager.white : ColorsManager.black,
                        iconColor: gender == Gender.male ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => gender = Gender.female),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.female).toCapitalized(),
                        iconData: FontAwesomeIcons.personDress,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: gender == Gender.female ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: gender == Gender.female ? ColorsManager.white : ColorsManager.black,
                        iconColor: gender == Gender.female ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // userType Item
          if(widget.items.contains(FiltersType.userType)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.userType, defaultText: StringsManager.accountType)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.userType),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => userType = UserType.account),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.businessAccount).toCapitalized(),
                        iconData: FontAwesomeIcons.solidUser,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: userType == UserType.account ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: userType == UserType.account ? ColorsManager.white : ColorsManager.black,
                        iconColor: userType == UserType.account ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => userType = UserType.user),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.userAccount).toCapitalized(),
                        iconData: FontAwesomeIcons.solidUser,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: userType == UserType.user ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: userType == UserType.user ? ColorsManager.white : ColorsManager.black,
                        iconColor: userType == UserType.user ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // commentStatus Item
          if(widget.items.contains(FiltersType.commentStatus)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.commentStatus, defaultText: StringsManager.commentStatus)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.commentStatus),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => commentStatus = CommentStatus.active),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.active).toCapitalized(),
                        iconData: Icons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: commentStatus == CommentStatus.active ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: commentStatus == CommentStatus.active ? ColorsManager.white : ColorsManager.black,
                        iconColor: commentStatus == CommentStatus.active ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => commentStatus = CommentStatus.pending),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.pending).toCapitalized(),
                        iconData: Icons.pending,
                        borderRadius: SizeManager.s0,
                        buttonColor: commentStatus == CommentStatus.pending ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: commentStatus == CommentStatus.pending ? ColorsManager.white : ColorsManager.black,
                        iconColor: commentStatus == CommentStatus.pending ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => commentStatus = CommentStatus.rejected),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.rejected).toCapitalized(),
                        iconData: Icons.close,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: commentStatus == CommentStatus.rejected ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: commentStatus == CommentStatus.rejected ? ColorsManager.white : ColorsManager.black,
                        iconColor: commentStatus == CommentStatus.rejected ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // walletTransactionType Item
          if(widget.items.contains(FiltersType.walletTransactionType)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.walletTransactionType, defaultText: StringsManager.walletTransactionType)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.walletTransactionType),
              children: [
                CustomDropdownButtonFormField(
                  currentValue: walletTransactionType,
                  valuesText: List.generate(WalletTransactionType.values.length, (index) => WalletTransactionType.toText(WalletTransactionType.values[index])),
                  valuesObject: WalletTransactionType.values,
                  onChanged: (value) => setState(() => walletTransactionType = value as WalletTransactionType),
                  hintText: Methods.getText(StringsManager.walletTransactionType).toCapitalized(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: SizeManager.s15),
                  fillColor: ColorsManager.grey1,
                  borderColor: Colors.transparent,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.black),
                  hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.black),
                  suffixIcon: walletTransactionType == null ? const Icon(
                    Icons.arrow_drop_down,
                    size: SizeManager.s20,
                    color: ColorsManager.grey,
                  ) : Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => walletTransactionType = null);
                      },
                      icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // withdrawalRequestStatus Item
          if(widget.items.contains(FiltersType.withdrawalRequestStatus)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.withdrawalRequestStatus, defaultText: StringsManager.withdrawalRequestStatus)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.withdrawalRequestStatus),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => withdrawalRequestStatus = WithdrawalRequestStatus.done),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.done).toCapitalized(),
                        iconData: FontAwesomeIcons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: withdrawalRequestStatus == WithdrawalRequestStatus.done ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: withdrawalRequestStatus == WithdrawalRequestStatus.done ? ColorsManager.white : ColorsManager.black,
                        iconColor: withdrawalRequestStatus == WithdrawalRequestStatus.done ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => withdrawalRequestStatus = WithdrawalRequestStatus.pending),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.pending).toCapitalized(),
                        iconData: Icons.pending,
                        borderRadius: SizeManager.s0,
                        buttonColor: withdrawalRequestStatus == WithdrawalRequestStatus.pending ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: withdrawalRequestStatus == WithdrawalRequestStatus.pending ? ColorsManager.white : ColorsManager.black,
                        iconColor: withdrawalRequestStatus == WithdrawalRequestStatus.pending ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => withdrawalRequestStatus = WithdrawalRequestStatus.rejected),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.rejected).toCapitalized(),
                        iconData: FontAwesomeIcons.xmark,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: withdrawalRequestStatus == WithdrawalRequestStatus.rejected ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: withdrawalRequestStatus == WithdrawalRequestStatus.rejected ? ColorsManager.white : ColorsManager.black,
                        iconColor: withdrawalRequestStatus == WithdrawalRequestStatus.rejected ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // paymentType Item
          if(widget.items.contains(FiltersType.paymentType)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.paymentType, defaultText: StringsManager.paymentType)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.paymentType),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => paymentType = PaymentType.wallet),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.wallet).toCapitalized(),
                        iconData: FontAwesomeIcons.wallet,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: paymentType == PaymentType.wallet ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: paymentType == PaymentType.wallet ? ColorsManager.white : ColorsManager.black,
                        iconColor: paymentType == PaymentType.wallet ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => paymentType = PaymentType.instaPay),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.instaPay).toCapitalized(),
                        iconData: FontAwesomeIcons.at,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: paymentType == PaymentType.instaPay ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: paymentType == PaymentType.instaPay ? ColorsManager.white : ColorsManager.black,
                        iconColor: paymentType == PaymentType.instaPay ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // Date Of Created Item
          if(widget.items.contains(FiltersType.dateOfCreated)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.dateOfCreated, defaultText: StringsManager.dateOfAdded)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.startDateOfCreated) || isExistInFilters(FiltersResult.filters, Filters.endDateOfCreated),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                            child: Text(
                              Methods.getText(StringsManager.startDate).toCapitalized(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomButton(
                            buttonType: ButtonType.preIcon,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await Methods.selectDateFromPicker(
                                context: context,
                                title: StringsManager.startDate,
                                initialDate: startDateOfCreated ?? DateTime.now(),
                                firstDate: DateTime(2023, 1, 1),
                                lastDate: DateTime.now(),
                              ).then((dateTime) {
                                if(dateTime != null) {setState(() => startDateOfCreated = dateTime);}
                              });
                            },
                            text: startDateOfCreated == null
                                ? Methods.getText(StringsManager.chooseDate).toCapitalized()
                                : Methods.formatDate(milliseconds: startDateOfCreated!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                            iconData: FontAwesomeIcons.calendar,
                            buttonColor: ColorsManager.grey1,
                            textColor: ColorsManager.black,
                            iconColor: ColorsManager.black,
                            width: double.infinity,
                            fontSize: SizeManager.s12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                            child: Text(
                              Methods.getText(StringsManager.endDate).toCapitalized(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomButton(
                            buttonType: ButtonType.preIcon,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await Methods.selectDateFromPicker(
                                context: context,
                                title: StringsManager.endDate,
                                initialDate: endDateOfCreated ?? DateTime.now(),
                                firstDate: DateTime(2023, 1, 1),
                                lastDate: DateTime.now(),
                              ).then((dateTime) {
                                if(dateTime != null) {setState(() => endDateOfCreated = dateTime);}
                              });
                            },
                            text: endDateOfCreated == null
                                ? Methods.getText(StringsManager.chooseDate).toCapitalized()
                                : Methods.formatDate(milliseconds: endDateOfCreated!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                            iconData: FontAwesomeIcons.calendar,
                            buttonColor: ColorsManager.grey1,
                            textColor: ColorsManager.black,
                            iconColor: ColorsManager.black,
                            width: double.infinity,
                            fontSize: SizeManager.s12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // Period Date Item
          if(widget.items.contains(FiltersType.periodDate)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.periodDate, defaultText: StringsManager.period)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.startPeriodDate) || isExistInFilters(FiltersResult.filters, Filters.endPeriodDate),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                            child: Text(
                              Methods.getText(StringsManager.startDate).toCapitalized(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomButton(
                            buttonType: ButtonType.preIcon,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await Methods.selectDateFromPicker(
                                context: context,
                                title: StringsManager.startDate,
                                initialDate: startPeriodDate ?? DateTime.now(),
                                firstDate: DateTime(2023, 1, 1),
                                lastDate: DateTime.now(),
                              ).then((dateTime) {
                                if(dateTime != null) {setState(() => startPeriodDate = dateTime);}
                              });
                            },
                            text: startPeriodDate == null
                                ? Methods.getText(StringsManager.chooseDate).toCapitalized()
                                : Methods.formatDate(milliseconds: startPeriodDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                            iconData: FontAwesomeIcons.calendar,
                            buttonColor: ColorsManager.grey1,
                            textColor: ColorsManager.black,
                            iconColor: ColorsManager.black,
                            width: double.infinity,
                            fontSize: SizeManager.s12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                            child: Text(
                              Methods.getText(StringsManager.endDate).toCapitalized(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s5),
                          CustomButton(
                            buttonType: ButtonType.preIcon,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await Methods.selectDateFromPicker(
                                context: context,
                                title: StringsManager.endDate,
                                initialDate: endPeriodDate ?? DateTime.now(),
                                firstDate: DateTime(2023, 1, 1),
                                lastDate: DateTime.now(),
                              ).then((dateTime) {
                                if(dateTime != null) {setState(() => endPeriodDate = dateTime);}
                              });
                            },
                            text: endPeriodDate == null
                                ? Methods.getText(StringsManager.chooseDate).toCapitalized()
                                : Methods.formatDate(milliseconds: endPeriodDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                            iconData: FontAwesomeIcons.calendar,
                            buttonColor: ColorsManager.grey1,
                            textColor: ColorsManager.black,
                            iconColor: ColorsManager.black,
                            width: double.infinity,
                            fontSize: SizeManager.s12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // singleDate Item
          if(widget.items.contains(FiltersType.singleDate)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.singleDate, defaultText: StringsManager.date)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.singleDate),
              children: [
                CustomButton(
                  buttonType: ButtonType.preIcon,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Methods.selectDateFromPicker(
                      context: context,
                      title: StringsManager.endDate,
                      initialDate: singleDate ?? DateTime.now(),
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now(),
                    ).then((dateTime) {
                      if(dateTime != null) {setState(() => singleDate = dateTime);}
                    });
                  },
                  text: singleDate == null
                      ? Methods.getText(StringsManager.date).toCapitalized()
                      : Methods.formatDate(milliseconds: singleDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                  iconData: FontAwesomeIcons.calendar,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                  iconColor: ColorsManager.black,
                  width: double.infinity,
                  fontSize: SizeManager.s12,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // isFeatured Item
          if(widget.items.contains(FiltersType.isFeatured)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.isFeatured, defaultText: StringsManager.verifiedAccounts)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.isFeatured),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isFeatured = true),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.yes).toCapitalized(),
                        iconData: FontAwesomeIcons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isFeatured != null && isFeatured! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isFeatured != null && isFeatured! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isFeatured != null && isFeatured! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isFeatured = false),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.no).toCapitalized(),
                        iconData: FontAwesomeIcons.xmark,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isFeatured != null && !isFeatured! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isFeatured != null && !isFeatured! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isFeatured != null && !isFeatured! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // isSuper Item
          if(widget.items.contains(FiltersType.isSuper)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.isSuper, defaultText: StringsManager.adminsWithAllPermissions)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.isSuper),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isSuper = true),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.yes).toCapitalized(),
                        iconData: FontAwesomeIcons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isSuper != null && isSuper! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isSuper != null && isSuper! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isSuper != null && isSuper! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isSuper = false),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.no).toCapitalized(),
                        iconData: FontAwesomeIcons.xmark,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isSuper != null && !isSuper! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isSuper != null && !isSuper! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isSuper != null && !isSuper! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // isAvailable Item
          if(widget.items.contains(FiltersType.isAvailable)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.isAvailable, defaultText: StringsManager.isAvailable)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.isAvailable),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isAvailable = true),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.yes).toCapitalized(),
                        iconData: FontAwesomeIcons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isAvailable != null && isAvailable! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isAvailable != null && isAvailable! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isAvailable != null && isAvailable! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isAvailable = false),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.no).toCapitalized(),
                        iconData: FontAwesomeIcons.xmark,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isAvailable != null && !isAvailable! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isAvailable != null && !isAvailable! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isAvailable != null && !isAvailable! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // isDone Item
          if(widget.items.contains(FiltersType.isDone)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.isDone, defaultText: StringsManager.closedConsultations)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.isDone),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isDone = true),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.yes).toCapitalized(),
                        iconData: FontAwesomeIcons.check,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(SizeManager.s10),
                            bottomStart: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isDone != null && isDone! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isDone != null && isDone! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isDone != null && isDone! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => setState(() => isDone = false),
                        buttonType: ButtonType.preIcon,
                        text: Methods.getText(StringsManager.no).toCapitalized(),
                        iconData: FontAwesomeIcons.xmark,
                        roundedRectangleBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(SizeManager.s10),
                            bottomEnd: Radius.circular(SizeManager.s10),
                          ),
                        ),
                        buttonColor: isDone != null && !isDone! ? ColorsManager.lightPrimaryColor : ColorsManager.grey1,
                        textColor: isDone != null && !isDone! ? ColorsManager.white : ColorsManager.black,
                        iconColor: isDone != null && !isDone! ? ColorsManager.white : ColorsManager.black,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // User Item
          if(widget.items.contains(FiltersType.user)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.user, defaultText: StringsManager.user)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.user),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.usersBottomSheet(context: context).then((userModel) {
                    setState(() => user = userModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: user == null
                      ? Methods.getText(StringsManager.chooseUser).toCapitalized()
                      : user!.fullName,
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // Account Item
          if(widget.items.contains(FiltersType.account)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.account, defaultText: StringsManager.account)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.account),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.accountsBottomSheet(context: context).then((accountModel) {
                    setState(() => account = accountModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: account == null
                      ? Methods.getText(StringsManager.chooseAccount).toCapitalized()
                      : account!.fullName,
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // MainCategory Item
          if(widget.items.contains(FiltersType.mainCategory)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.mainCategory, defaultText: StringsManager.mainCategory)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.mainCategory),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.mainCategoriesBottomSheet(context: context).then((mainCategoryModel) {
                    setState(() => mainCategory = mainCategoryModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: mainCategory == null
                      ? Methods.getText(StringsManager.chooseMainCategory).toCapitalized()
                      : (MyProviders.appProvider.isEnglish ? mainCategory!.nameEn : mainCategory!.nameAr),
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // category Item
          if(widget.items.contains(FiltersType.category)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.category, defaultText: StringsManager.category)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.category),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.categoriesBottomSheet(
                    context: context,
                    // filtersMap: '',
                  ).then((categoryModel) {
                    setState(() => category = categoryModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: category == null
                      ? Methods.getText(StringsManager.chooseCategory).toCapitalized()
                      : (MyProviders.appProvider.isEnglish ? category!.nameEn : category!.nameAr),
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // playlist Item
          if(widget.items.contains(FiltersType.playlist)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.playlist, defaultText: StringsManager.playlist)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.playlist),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.playlistsBottomSheet(context: context).then((playlistModel) {
                    setState(() => playlist = playlistModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: playlist == null
                      ? Methods.getText(StringsManager.choosePlaylist).toCapitalized()
                      : (MyProviders.appProvider.isEnglish ? playlist!.playlistNameEn : playlist!.playlistNameAr),
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // instantConsultation Item
          if(widget.items.contains(FiltersType.instantConsultation)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.instantConsultation, defaultText: StringsManager.instantConsultation)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.instantConsultation),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.instantConsultationsBottomSheet(context: context).then((instantConsultationModel) {
                    setState(() => instantConsultation = instantConsultationModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: instantConsultation == null
                      ? Methods.getText(StringsManager.chooseInstantConsultation).toCapitalized()
                      : '#${instantConsultation!.instantConsultationId}',
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // Country Item
          if(widget.items.contains(FiltersType.country)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.country, defaultText: StringsManager.country)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.country),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.countriesBottomSheet(context: context).then((countryModel) {
                    setState(() => country = countryModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: country == null
                      ? Methods.getText(StringsManager.chooseCountry).toCapitalized()
                      : (MyProviders.appProvider.isEnglish ? country!.countryNameEn : country!.countryNameAr),
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          // Currency Item
          if(widget.items.contains(FiltersType.currency)) ...[
            _FilterItem(
              title: Methods.getText(_getStringFromCustomText(type: FiltersType.currency, defaultText: StringsManager.currency)).toCapitalized(),
              initiallyExpanded: isExistInFilters(FiltersResult.filters, Filters.currency),
              children: [
                CustomButton(
                  onPressed: () => Dialogs.currenciesBottomSheet(context: context).then((currencyModel) {
                    setState(() => currency = currencyModel);
                  }),
                  buttonType: ButtonType.postSpacerText,
                  text: currency == null
                      ? Methods.getText(StringsManager.chooseCurrency).toCapitalized()
                      : (MyProviders.appProvider.isEnglish ? currency!.currencyNameEn : currency!.currencyNameAr),
                  width: double.infinity,
                  buttonColor: ColorsManager.grey1,
                  textColor: ColorsManager.black,
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],

          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: () => onPressedApply(),
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.apply).toCapitalized(),
            width: double.infinity,
            borderRadius: SizeManager.s10,
            buttonColor: ColorsManager.lightSecondaryColor,
          ),
        ],
      ),
    );
  }
}

class _FilterSelectionItem extends StatelessWidget {
  final String text;
  final Function() onPressedClear;

  const _FilterSelectionItem({required this.text, required this.onPressedClear});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
      decoration: BoxDecoration(
        color: ColorsManager.grey200,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: IconButton(
              onPressed: onPressedClear,
              icon: const Icon(Icons.clear, color: ColorsManager.red, size: SizeManager.s16),
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final String title;
  final bool initiallyExpanded;
  final List<Widget> children;

  const _FilterItem({required this.title, required this.initiallyExpanded, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeManager.s10),
        border: Border.all(color: ColorsManager.grey300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeManager.s10),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            fontFamily: FontFamilyManager.montserratArabic,
          ),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            collapsedBackgroundColor: ColorsManager.white,
            backgroundColor: ColorsManager.white,
            collapsedTextColor: ColorsManager.black,
            textColor: ColorsManager.lightPrimaryColor,
            collapsedIconColor: ColorsManager.black,
            iconColor: ColorsManager.lightPrimaryColor,
            tilePadding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
            childrenPadding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16, top: SizeManager.s8),
            expandedAlignment: MyProviders.appProvider.isEnglish ? Alignment.topLeft : Alignment.topRight,
            title: Text(
              title,
              style: const TextStyle(fontSize: SizeManager.s14),
            ),
            children: children,
          ),
        ),
      ),
    );
  }
}