import 'package:dartz/dartz.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/dependency_injection.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/category_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';
import 'package:fahem_business/data/response/categories_response.dart';
import 'package:fahem_business/domain/usecases/categories/delete_category_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/get_categories_usecase.dart';

class CategoriesProvider with ChangeNotifier {

  // region Get Categories
  final List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  addAllInCategories(List<CategoryModel> categories) {_categories.addAll(categories); notifyListeners();}
  insertInCategories(CategoryModel categoryModel) {_categories.insert(0, categoryModel); notifyListeners();}
  editInCategories(CategoryModel categoryModel) {
    int index = _categories.indexWhere((element) => element.categoryId == categoryModel.categoryId);
    if(index != -1) {
      _categories[index] = categoryModel;
      notifyListeners();
    }
  }
  _deleteFromCategories(int categoryId) {
    int index = _categories.indexWhere((element) => element.categoryId == categoryId);
    if(index != -1) {
      _categories.removeAt(index);
      notifyListeners();
    }
  }

  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;
  setDataState(DataState dataState) => _dataState = dataState;
  changeDataState(DataState dataState) {_dataState = dataState; notifyListeners();}

  bool _isScreenDisposed = false;
  bool get isScreenDisposed => _isScreenDisposed;
  setIsScreenDisposed(bool isScreenDisposed) => _isScreenDisposed = isScreenDisposed;

  bool _hasMore = true;
  bool get hasMore => _hasMore;
  setHasMore(bool hasMore) => _hasMore = hasMore;
  changeHasMore(bool hasMore) {_hasMore = hasMore; notifyListeners();}

  ViewStyle _viewStyle = ViewStyle.list;
  ViewStyle get viewStyle => _viewStyle;
  setViewStyle(ViewStyle viewStyle) => _viewStyle = viewStyle;
  changeViewStyle(ViewStyle viewStyle) {_viewStyle = viewStyle; notifyListeners();}

  ScrollController scrollController = ScrollController();
  PaginationModel? paginationModel;
  int limit = 20;
  int page = 1;

  Future<void> addListenerScrollController() async {
    scrollController.addListener(() async {
      if(_dataState != DataState.done) return;
      if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent)) {
        await fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    if(!_hasMore) return;
    changeDataState(DataState.loading);
    GetCategoriesParameters parameters = GetCategoriesParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.customOrderAsc,
      filtersMap: globalFilters,
    );
    Either<Failure, CategoriesResponse> response = await DependencyInjection.getCategoriesUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInCategories(data.categories);
      if(categories.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _categories.clear();
    setDataState(DataState.loading);
    setIsScreenDisposed(false);
    setHasMore(true);
    page = 1;
  }

  Future<void> reFetchData() async {
    if(_dataState == DataState.loading) return;
    _resetVariablesToDefault();
    await fetchData();
  }
  // endregion

  // region Delete Category
  bool _isLoadingDelete = false;
  bool get isLoadingDelete => _isLoadingDelete;
  changeIsLoadingDelete(bool isLoadingDelete) {_isLoadingDelete = isLoadingDelete; notifyListeners();}

  Future<void> deleteCategory({required BuildContext context, required int categoryId}) async {
    changeIsLoadingDelete(true);
    Either<Failure, void> response = await DependencyInjection.deleteCategoryUseCase.call(DeleteCategoryParameters(categoryId: categoryId));
    await response.fold((failure) async {
      changeIsLoadingDelete(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoadingDelete(false);
      _deleteFromCategories(categoryId);
      if(paginationModel != null) paginationModel!.total--;
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.deletedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
      );
    });
  }
  // endregion
}