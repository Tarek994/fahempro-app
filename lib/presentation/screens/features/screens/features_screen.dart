import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/feature_model.dart';
import 'package:fahem/presentation/screens/features/widgets/extra_widget_in_top_features.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/features/controllers/features_provider.dart';
import 'package:fahem/presentation/screens/features/widgets/feature_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  late FeaturesProvider featuresProvider;

  @override
  void initState() {
    super.initState();
    featuresProvider = Provider.of<FeaturesProvider>(context, listen: false);
    featuresProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await featuresProvider.fetchData());
  }

  void _onInsert(FeatureModel? feature) {
    if(feature != null) {
      featuresProvider.insertInFeatures(feature);
      if(featuresProvider.paginationModel != null) featuresProvider.paginationModel!.total++;
    }
  }

  void _onEdit(FeatureModel? feature) {
    if(feature != null) {
      featuresProvider.editInFeatures(feature);
    }
  }

  void _onDelete(int featureId) {
    featuresProvider.deleteFeature(context: context, featureId: featureId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturesProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addFeature) ? () {
            Methods.routeTo(context, Routes.insertEditFeatureScreen, arguments: null, then: (feature) => _onInsert(feature));
          } : null,
          screenTitle: StringsManager.features,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.featuresNewestFirst, OrderByType.featuresOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.mainCategory],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.features.isNotEmpty,
          dataCount: provider.features.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => FeatureListItem(
            featureModel: provider.features[index],
            onEdit: (feature) => _onEdit(feature),
            onDelete: () => _onDelete(provider.features[index].featureId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoFeatures,
          extraWidget: const ExtraWidgetInTopFeatures(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    featuresProvider.setIsScreenDisposed(true);
    featuresProvider.scrollController.dispose();
  }
}