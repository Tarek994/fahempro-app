import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/review_model.dart';
import 'package:fahem/data/models/static/pagination_model.dart';
import 'package:fahem/data/response/reviews_response.dart';
import 'package:fahem/domain/usecases/reviews/delete_review_usecase.dart';
import 'package:fahem/domain/usecases/reviews/get_reviews_usecase.dart';
import 'package:fahem/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem/presentation/btm_sheets/filters_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';

class AccountDetailsProvider with ChangeNotifier {
  final AccountModel accountModel;

  AccountDetailsProvider({required this.accountModel});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  // region Get Reviews
  final List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;
  addAllInReviews(List<ReviewModel> reviews) {_reviews.addAll(reviews); notifyListeners();}
  insertInReviews(ReviewModel reviewModel) {_reviews.insert(0, reviewModel); notifyListeners();}
  editInReviews(ReviewModel reviewModel) {
    int index = _reviews.indexWhere((element) => element.reviewId == reviewModel.reviewId);
    if(index != -1) {
      _reviews[index] = reviewModel;
      notifyListeners();
    }
  }
  _deleteFromReviews(int reviewId) {
    int index = _reviews.indexWhere((element) => element.reviewId == reviewId);
    if(index != -1) {
      _reviews.removeAt(index);
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

    Map<String, dynamic> filtersMap = {};
    if(globalFilters != null) filtersMap.addAll(jsonDecode(globalFilters!));
    filtersMap.addAll({Filters.account.name: accountModel.accountId});

    GetReviewsParameters parameters = GetReviewsParameters(
      isPaginated: true,
      limit: limit,
      page: page,
      searchText: globalSearchText,
      orderBy: globalOrderBy ?? OrderByType.reviewsNewestFirst,
      filtersMap: jsonEncode(filtersMap),
    );
    Either<Failure, ReviewsResponse> response = await DependencyInjection.getReviewsUseCase.call(parameters);
    if(isScreenDisposed) return;
    await response.fold((failure) async {
      Methods.showToast(failure: failure);
      changeDataState(DataState.error);
    }, (data) async {
      paginationModel = data.pagination;
      addAllInReviews(data.reviews);
      if(reviews.length == paginationModel!.total) {changeHasMore(false);}
      if(paginationModel!.total == 0) {changeDataState(DataState.empty);}
      else {changeDataState(DataState.done);}
      page += 1;
    });
  }

  void _resetVariablesToDefault() {
    _reviews.clear();
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

  // region Delete Review
  Future<void> deleteReview({required BuildContext context, required int reviewId}) async {
    changeIsLoading(true);
    Either<Failure, void> response = await DependencyInjection.deleteReviewUseCase.call(DeleteReviewParameters(reviewId: reviewId));
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async {
      changeIsLoading(false);
      _deleteFromReviews(reviewId);
      if(paginationModel != null) paginationModel!.total--;
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.deletedSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
      );
    });
  }
  // endregion

  // region Insert Review
  Future<void> insertReview({required BuildContext context, required InsertReviewParameters insertReviewParameters}) async {
    changeIsLoading(true);
    Either<Failure, ReviewModel> response = await DependencyInjection.insertReviewUseCase.call(insertReviewParameters);
    await response.fold((failure) async {
      changeIsLoading(false);
      await Dialogs.failureOccurred(context: context, failure: failure);
    }, (review) async {
      changeIsLoading(false);
      Methods.sendNotificationToBusiness(
        accountId: insertReviewParameters.accountId,
        title: 'تقييم',
        body: '(${insertReviewParameters.rating}) ${insertReviewParameters.comment}',
      );
      Dialogs.showBottomSheetMessage(
        context: context,
        message: Methods.getText(StringsManager.yourRatingHasBeenSentSuccessfully).toTitleCase(),
        showMessage: ShowMessage.success,
        // thenMethod: () => Navigator.pop(context, review),
      );
    });
  }
  // endregion
}