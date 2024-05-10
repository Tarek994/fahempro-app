import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/response/categories_response.dart';
import 'package:fahem/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/accounts_response.dart';
import 'package:fahem/domain/usecases/accounts/get_accounts_usecase.dart';

class CategoriesProvider with ChangeNotifier {
  final MainCategoryModel mainCategory;

  CategoriesProvider({required this.mainCategory});

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  // region Get Accounts
  final List<AccountModel> _accounts = [];
  List<AccountModel> get accounts => _accounts;
  addAllInAccounts(List<AccountModel> accounts) {_accounts.addAll(accounts); notifyListeners();}

  DataState _accountsDataState = DataState.loading;
  DataState get accountsDataState => _accountsDataState;
  setAccountsDataState(DataState accountsDataState) => _accountsDataState = accountsDataState;
  changeAccountsDataState(DataState accountsDataState) {_accountsDataState = accountsDataState; notifyListeners();}

  bool _accountsHasMore = true;
  bool get accountsHasMore => _accountsHasMore;
  setAccountsHasMore(bool accountsHasMore) => _accountsHasMore = accountsHasMore;
  changeAccountsHasMore(bool accountsHasMore) {_accountsHasMore = accountsHasMore; notifyListeners();}

  ViewStyle _accountsViewStyle = ViewStyle.list;
  ViewStyle get accountsViewStyle => _accountsViewStyle;
  setAccountsViewStyle(ViewStyle accountsViewStyle) => _accountsViewStyle = accountsViewStyle;
  changeAccountsViewStyle(ViewStyle accountsViewStyle) {_accountsViewStyle = accountsViewStyle; notifyListeners();}

  ScrollController accountsScrollController = ScrollController();
  PaginationModel? accountsPaginationModel;
  int accountsLimit = 20;
  int accountsPage = 1;

  Future<void> accountsAddListenerScrollController() async {
    accountsScrollController.addListener(() async {
      if(_accountsDataState != DataState.done) return;
      if(accountsScrollController.position.pixels >= (accountsScrollController.position.maxScrollExtent)) {
        await fetchAccounts();
      }
    });
  }

  Future<void> fetchAccounts() async {
    if(!_accountsHasMore) return;
    changeAccountsDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({'accountStatus': AccountStatus.active.name});
    filtersMap.addAll({Filters.mainCategory.name: mainCategory.mainCategoryId});
    // filtersMap.addAll({Filters.isFeatured.name: true});

    GetAccountsParameters parameters = GetAccountsParameters(
      isPaginated: true,
      limit: accountsLimit,
      page: accountsPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.highestRating,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, AccountsResponse> response = await DependencyInjection.getAccountsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeAccountsDataState(DataState.error);
    }, (data) async {
      accountsPaginationModel = data.pagination;
      addAllInAccounts(data.accounts);
      if(_accounts.length == accountsPaginationModel!.total) {changeAccountsHasMore(false);}
      if(accountsPaginationModel!.total == 0) {changeAccountsDataState(DataState.empty);}
      else {changeAccountsDataState(DataState.done);}
      accountsPage += 1;
    });
  }

  void _resetAccountsVariablesToDefault() {
    _accounts.clear();
    setAccountsDataState(DataState.loading);
    setIsScreenDisposed(false);
    setAccountsHasMore(true);
    accountsPage = 1;
  }

  Future<void> reFetchAccounts() async {
    if(_accountsDataState == DataState.loading) return;
    _resetAccountsVariablesToDefault();
    await fetchAccounts();
  }
  // endregion

  // region Get Categories
  final List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  addAllInCategories(List<CategoryModel> categories) {_categories.addAll(categories); notifyListeners();}

  DataState _categoriesDataState = DataState.loading;
  DataState get categoriesDataState => _categoriesDataState;
  setCategoriesDataState(DataState categoriesDataState) => _categoriesDataState = categoriesDataState;
  changeCategoriesDataState(DataState categoriesDataState) {_categoriesDataState = categoriesDataState; notifyListeners();}

  bool _categoriesHasMore = true;
  bool get categoriesHasMore => _categoriesHasMore;
  setCategoriesHasMore(bool categoriesHasMore) => _categoriesHasMore = categoriesHasMore;
  changeCategoriesHasMore(bool categoriesHasMore) {_categoriesHasMore = categoriesHasMore; notifyListeners();}

  ViewStyle _categoriesViewStyle = ViewStyle.list;
  ViewStyle get categoriesViewStyle => _categoriesViewStyle;
  setCategoriesViewStyle(ViewStyle categoriesViewStyle) => _categoriesViewStyle = categoriesViewStyle;
  changeCategoriesViewStyle(ViewStyle categoriesViewStyle) {_categoriesViewStyle = categoriesViewStyle; notifyListeners();}

  ScrollController categoriesScrollController = ScrollController();
  PaginationModel? categoriesPaginationModel;
  int categoriesLimit = 20;
  int categoriesPage = 1;

  Future<void> categoriesAddListenerScrollController() async {
    categoriesScrollController.addListener(() async {
      if(_categoriesDataState != DataState.done) return;
      if(categoriesScrollController.position.pixels >= (categoriesScrollController.position.maxScrollExtent)) {
        await fetchCategories();
      }
    });
  }

  Future<void> fetchCategories() async {
    if(!_categoriesHasMore) return;
    changeCategoriesDataState(DataState.loading);

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({Filters.mainCategory.name: mainCategory.mainCategoryId});

    GetCategoriesParameters parameters = GetCategoriesParameters(
      isPaginated: true,
      limit: categoriesLimit,
      page: categoriesPage,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.customOrderAsc,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, CategoriesResponse> response = await DependencyInjection.getCategoriesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeCategoriesDataState(DataState.error);
    }, (data) async {
      categoriesPaginationModel = data.pagination;
      addAllInCategories(data.categories);
      if(_categories.length == categoriesPaginationModel!.total) {changeCategoriesHasMore(false);}
      if(categoriesPaginationModel!.total == 0) {changeCategoriesDataState(DataState.empty);}
      else {changeCategoriesDataState(DataState.done);}
      categoriesPage += 1;
    });
  }

  void _resetCategoriesVariablesToDefault() {
    _categories.clear();
    setCategoriesDataState(DataState.loading);
    setIsScreenDisposed(false);
    setCategoriesHasMore(true);
    categoriesPage = 1;
  }

  Future<void> reFetchCategories() async {
    if(_categoriesDataState == DataState.loading) return;
    _resetCategoriesVariablesToDefault();
    await fetchCategories();
  }
  // endregion
}