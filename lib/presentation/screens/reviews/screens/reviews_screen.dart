import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/reviews/controllers/reviews_provider.dart';
import 'package:fahem/presentation/screens/accounts/widgets/review_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late ReviewsProvider reviewsProvider;

  @override
  void initState() {
    super.initState();
    reviewsProvider = Provider.of<ReviewsProvider>(context, listen: false);
    reviewsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await reviewsProvider.fetchData());
  }

  void _onInsert(ReviewModel? review) {
    if(review != null) {
      reviewsProvider.insertInReviews(review);
      if(reviewsProvider.paginationModel != null) reviewsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(ReviewModel? review) {
    if(review != null) {
      reviewsProvider.editInReviews(review);
    }
  }

  void _onDelete(int reviewId) {
    reviewsProvider.deleteReview(context: context, reviewId: reviewId);
  }

  String _getTitle() {
    if(reviewsProvider.reviewsArgs == null) {
      return Methods.getText(StringsManager.reviews).toTitleCase();
    }
    else {
      if(reviewsProvider.reviewsArgs!.account != null) {
        return reviewsProvider.reviewsArgs!.account!.fullName;
      }
      else {
        return Methods.getText(StringsManager.reviews).toTitleCase();
      }
    }
  }

  List<FiltersType> _getFiltersItems() {
    if(reviewsProvider.reviewsArgs == null) {
      return const [FiltersType.dateOfCreated];
    }
    else {
      if(reviewsProvider.reviewsArgs!.account != null) {
        return const [FiltersType.dateOfCreated];
      }
      else {
        return const [FiltersType.dateOfCreated];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          title: _getTitle(),
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByReview,
            ordersItems: const [OrderByType.reviewsNewestFirst, OrderByType.reviewsOldestFirst],
            filtersItems: _getFiltersItems(),
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.reviews.isNotEmpty,
          dataCount: provider.reviews.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ReviewListItem(
            reviewModel: provider.reviews[index],
            index: index,
            onEdit: (review) => _onEdit(review),
            onDelete: () => _onDelete(provider.reviews[index].reviewId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoReviews,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    reviewsProvider.setIsScreenDisposed(true);
    reviewsProvider.scrollController.dispose();
  }
}