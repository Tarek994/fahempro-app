import 'dart:convert';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/static/country_model.dart';
import 'package:fahem/data/models/static/currency_model.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

String? globalSearchText;
OrderByType? globalOrderBy;
String? globalFilters;

void _resetSearchOrderFiltersToDefault() {
  globalSearchText = null;
  globalOrderBy = null;
  globalFilters = null;
}

bool isExistInFilters(List<FilterModel> filters, Filters filter) {
  int index = filters.indexWhere((element) => element.filter == filter);
  return index != -1;
}

FilterModel getFilterModel(List<FilterModel> filters, Filters filter) {
  FilterModel filterModel = filters.firstWhere((element) => element.filter == filter);
  return filterModel;
}

Map<String, dynamic> getResults(List<FilterModel> filters) {
  Map<String, dynamic> results = {};
  if (isExistInFilters(filters, Filters.gender)) {
    Gender gender = (getFilterModel(filters, Filters.gender).value);
    results.addAll({Filters.gender.name: gender.name});
  }
  if (isExistInFilters(filters, Filters.commentStatus)) {
    CommentStatus commentStatus = (getFilterModel(filters, Filters.commentStatus).value);
    results.addAll({Filters.commentStatus.name: commentStatus.name});
  }
  if (isExistInFilters(filters, Filters.userType)) {
    UserType userType = (getFilterModel(filters, Filters.userType).value);
    results.addAll({Filters.userType.name: userType.name});
  }
  if (isExistInFilters(filters, Filters.walletTransactionType)) {
    WalletTransactionType walletTransactionType = (getFilterModel(filters, Filters.walletTransactionType).value);
    results.addAll({Filters.walletTransactionType.name: walletTransactionType.name});
  }
  if (isExistInFilters(filters, Filters.withdrawalRequestStatus)) {
    WithdrawalRequestStatus withdrawalRequestStatus = (getFilterModel(filters, Filters.withdrawalRequestStatus).value);
    results.addAll({Filters.withdrawalRequestStatus.name: withdrawalRequestStatus.name});
  }
  if (isExistInFilters(filters, Filters.paymentType)) {
    PaymentType paymentType = (getFilterModel(filters, Filters.paymentType).value);
    results.addAll({Filters.paymentType.name: paymentType.name});
  }
  if (isExistInFilters(filters, Filters.startDateOfCreated)) {
    DateTime dateTime = (getFilterModel(filters, Filters.startDateOfCreated).value);
    results.addAll({Filters.startDateOfCreated.name: dateTime.millisecondsSinceEpoch});
  }
  if (isExistInFilters(filters, Filters.endDateOfCreated)) {
    DateTime dateTime = (getFilterModel(filters, Filters.endDateOfCreated).value);
    results.addAll({Filters.endDateOfCreated.name: dateTime.add(const Duration(days: 1)).millisecondsSinceEpoch-1000});
  }
  if (isExistInFilters(filters, Filters.startPeriodDate)) {
    DateTime dateTime = (getFilterModel(filters, Filters.startPeriodDate).value);
    results.addAll({Filters.startPeriodDate.name: dateTime.millisecondsSinceEpoch});
  }
  if (isExistInFilters(filters, Filters.endPeriodDate)) {
    DateTime dateTime = (getFilterModel(filters, Filters.endPeriodDate).value);
    results.addAll({Filters.endPeriodDate.name: dateTime.add(const Duration(days: 1)).millisecondsSinceEpoch-1000});
  }
  if (isExistInFilters(filters, Filters.singleDate)) {
    DateTime dateTime = (getFilterModel(filters, Filters.singleDate).value);
    results.addAll({Filters.singleDate.name: dateTime.millisecondsSinceEpoch});
  }
  if (isExistInFilters(filters, Filters.isFeatured)) {
    bool isFeatured = (getFilterModel(filters, Filters.isFeatured).value);
    results.addAll({Filters.isFeatured.name: isFeatured});
  }
  if (isExistInFilters(filters, Filters.isSuper)) {
    bool isSuper = (getFilterModel(filters, Filters.isSuper).value);
    results.addAll({Filters.isSuper.name: isSuper});
  }
  if (isExistInFilters(filters, Filters.isAvailable)) {
    bool isAvailable = (getFilterModel(filters, Filters.isAvailable).value);
    results.addAll({Filters.isAvailable.name: isAvailable});
  }
  if (isExistInFilters(filters, Filters.isDone)) {
    bool isDone = (getFilterModel(filters, Filters.isDone).value);
    results.addAll({Filters.isDone.name: isDone});
  }
  if (isExistInFilters(filters, Filters.user)) {
    UserModel user = (getFilterModel(filters, Filters.user).value);
    results.addAll({Filters.user.name: user.userId});
  }
  if (isExistInFilters(filters, Filters.account)) {
    AccountModel account = (getFilterModel(filters, Filters.account).value);
    results.addAll({Filters.account.name: account.accountId});
  }
  if (isExistInFilters(filters, Filters.mainCategory)) {
    MainCategoryModel mainCategory = (getFilterModel(filters, Filters.mainCategory).value);
    results.addAll({Filters.mainCategory.name: mainCategory.mainCategoryId});
  }
  if (isExistInFilters(filters, Filters.category)) {
    CategoryModel category = (getFilterModel(filters, Filters.category).value);
    results.addAll({Filters.category.name: category.categoryId});
  }
  if (isExistInFilters(filters, Filters.playlist)) {
    PlaylistModel playlist = (getFilterModel(filters, Filters.playlist).value);
    results.addAll({Filters.playlist.name: playlist.playlistId});
  }
  if (isExistInFilters(filters, Filters.instantConsultation)) {
    InstantConsultationModel instantConsultation = (getFilterModel(filters, Filters.instantConsultation).value);
    results.addAll({Filters.instantConsultation.name: instantConsultation.instantConsultationId});
  }
  if (isExistInFilters(filters, Filters.country)) {
    CountryModel country = (getFilterModel(filters, Filters.country).value);
    results.addAll({Filters.country.name: country.countryId});
  }
  if (isExistInFilters(filters, Filters.currency)) {
    CurrencyModel currency = (getFilterModel(filters, Filters.currency).value);
    results.addAll({Filters.currency.name: currency.currencyId});
  }
  return results;
}

class SearchFilterOrderWidget extends StatefulWidget {
  final bool isSupportSearch;
  final bool isSupportOrder;
  final bool isSupportFilters;
  final String? hintText;
  final List<OrderByType> ordersItems;
  final List<FiltersType> filtersItems;
  final Map<String, String>? customText;
  final DataState dataState;
  final Function reFetchData;

  const SearchFilterOrderWidget({
    super.key,
    this.isSupportSearch = true,
    this.isSupportOrder = true,
    this.isSupportFilters = true,
    this.hintText,
    required this.ordersItems,
    required this.filtersItems,
    this.customText,
    required this.dataState,
    required this.reFetchData,
  });

  @override
  State<SearchFilterOrderWidget> createState() => _SearchFilterOrderWidgetState();
}

class _SearchFilterOrderWidgetState extends State<SearchFilterOrderWidget> {
  final TextEditingController _textEditingControllerSearch = TextEditingController();
  List<FilterModel> _currentFiltersSelection = [];
  OrderByType? _currentOrderByType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SizeManager.s8),
      child: SizedBox(
        height: SizeManager.s45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if(widget.isSupportSearch) Expanded(
              child: CustomTextFormField(
                enabled: widget.dataState != DataState.loading,
                controller: _textEditingControllerSearch,
                hintText: widget.hintText == null ? null : Methods.getText(widget.hintText!).toCapitalized(),
                prefixIconData: Icons.search,
                suffixIcon: CustomButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if(_textEditingControllerSearch.text.trim().isEmpty) return;
                    if(globalSearchText == _textEditingControllerSearch.text.trim()) return;
                    globalSearchText = _textEditingControllerSearch.text.trim();
                    widget.reFetchData();
                  },
                  buttonColor: Colors.transparent,
                  textColor: ColorsManager.lightPrimaryColor,
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.search).toCapitalized(),
                ),
                onChanged: (val) async {
                  if(val.trim().isEmpty && globalSearchText != null) {
                    globalSearchText = null;
                    widget.reFetchData();
                  }
                },
                onClickClearIcon: () async {
                  if(globalSearchText == null) return;
                  globalSearchText = null;
                  widget.reFetchData();
                },
                isSupportClearSuffixIcon: false,
                isSupportClearPrefixIcon: true,
              ),
            ),
            if(widget.isSupportOrder) IconButton(
              onPressed: widget.dataState == DataState.loading ? null : () async {
                FocusScope.of(context).unfocus();
                await Dialogs.orderByDialog(
                  context: context,
                  currentValue: _currentOrderByType,
                  items: widget.ordersItems,
                ).then((orderByType) async {
                  if(orderByType != null) {
                    if(_currentOrderByType == orderByType) return;
                    _currentOrderByType = orderByType;
                    globalOrderBy = _currentOrderByType;
                    widget.reFetchData();
                  }
                });
              },
              icon: const Icon(FontAwesomeIcons.sort, size: SizeManager.s20, color: ColorsManager.lightPrimaryColor),
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            if(widget.isSupportFilters && widget.filtersItems.isNotEmpty) ...[
              const SizedBox(width: SizeManager.s5),
              IconButton(
                onPressed: widget.dataState == DataState.loading ? null : () async {
                  FocusScope.of(context).unfocus();
                  await Dialogs.showBottomSheet(
                    context: context,
                    child: FiltersBtmSheet(
                      items: widget.filtersItems,
                      customText: widget.customText,
                    ),
                  ).then((_) async {
                    Map<String, dynamic> currentFiltersSelectionResults = getResults(_currentFiltersSelection);
                    Map<String, dynamic> filtersResultDataResults = getResults(FiltersResult.filters);
                    debugPrint(filtersResultDataResults.toString());
                    if(currentFiltersSelectionResults.toString() == filtersResultDataResults.toString()) return;
                    _currentFiltersSelection = FiltersResult.filters;
                    globalFilters = jsonEncode(filtersResultDataResults);
                    widget.reFetchData();
                  });
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(FontAwesomeIcons.filter, size: SizeManager.s20, color: ColorsManager.lightPrimaryColor),
                    if(_currentFiltersSelection.isNotEmpty) const PositionedDirectional(
                      top: -3,
                      start: -3,
                      child: CircleAvatar(radius: SizeManager.s5, backgroundColor: ColorsManager.black),
                    ),
                  ],
                ),
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerSearch.dispose();
    FiltersResult.filters = [];
    _resetSearchOrderFiltersToDefault();
    super.dispose();
  }
}