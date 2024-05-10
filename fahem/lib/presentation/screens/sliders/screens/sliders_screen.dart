import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/slider_model.dart';
import 'package:fahem/presentation/screens/sliders/controllers/sliders_provider.dart';
import 'package:fahem/presentation/screens/sliders/widgets/slider_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlidersScreen extends StatefulWidget {

  const SlidersScreen({super.key});

  @override
  State<SlidersScreen> createState() => _SlidersScreenState();
}

class _SlidersScreenState extends State<SlidersScreen> {
  late SlidersProvider slidersProvider;

  @override
  void initState() {
    super.initState();
    slidersProvider = Provider.of<SlidersProvider>(context, listen: false);
    slidersProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await slidersProvider.fetchData());
  }

  void _onInsert(SliderModel? slider) {
    if(slider != null) {
      slidersProvider.insertInSliders(slider);
      if(slidersProvider.paginationModel != null) slidersProvider.paginationModel!.total++;
    }
  }

  void _onEdit(SliderModel? slider) {
    if(slider != null) {
      slidersProvider.editInSliders(slider);
    }
  }

  void _onDelete(int sliderId) {
    slidersProvider.deleteSlider(context: context, sliderId: sliderId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlidersProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addSlider) ? () {
            Methods.routeTo(context, Routes.insertEditSliderScreen, arguments: null, then: (slider) => _onInsert(slider));
          } : null,
          screenTitle: StringsManager.sliders,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.sliders.isNotEmpty,
          dataCount: provider.sliders.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => SliderListItem(sliderModel: provider.sliders[index], onEdit: (slider) => _onEdit(slider), onDelete: () => _onDelete(provider.sliders[index].sliderId)),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoSliders,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    slidersProvider.setIsScreenDisposed(true);
    slidersProvider.scrollController.dispose();
  }
}