import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/presentation/screens/social_media/controllers/social_media_provider.dart';
import 'package:fahem/presentation/screens/social_media/widgets/social_media_grid_item.dart';
import 'package:fahem/presentation/screens/social_media/widgets/social_media_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  late SocialMediaProvider socialMediaProvider;

  @override
  void initState() {
    super.initState();
    socialMediaProvider = Provider.of<SocialMediaProvider>(context, listen: false);
    socialMediaProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await socialMediaProvider.fetchData());
  }

  void _onInsert(SocialMediaModel? socialMedia) {
    if(socialMedia != null) {
      socialMediaProvider.insertInSocialMedia(socialMedia);
      if(socialMediaProvider.paginationModel != null) socialMediaProvider.paginationModel!.total++;
    }
  }

  void _onEdit(SocialMediaModel? socialMedia) {
    if(socialMedia != null) {
      socialMediaProvider.editInSocialMedia(socialMedia);
    }
  }

  void _onDelete(int socialMediaId) {
    socialMediaProvider.deleteSocialMedia(context: context, socialMediaId: socialMediaId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialMediaProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addSocialMedia) ? () {
            Methods.routeTo(context, Routes.insertEditSocialMediaScreen, arguments: null, then: (socialMedia) => _onInsert(socialMedia));
          } : null,
          screenTitle: StringsManager.socialMedia,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.socialMediaNewestFirst, OrderByType.socialMediaOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.isAvailable],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.socialMedia.isNotEmpty,
          dataCount: provider.socialMedia.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => SocialMediaListItem(socialMediaModel: provider.socialMedia[index], onEdit: (socialMedia) => _onEdit(socialMedia), onDelete: () => _onDelete(provider.socialMedia[index].socialMediaId)),
          gridItemBuilder: (context, index) => SocialMediaGridItem(socialMediaModel: provider.socialMedia[index], onEdit: (socialMedia) => _onEdit(socialMedia), onDelete: () => _onDelete(provider.socialMedia[index].socialMediaId)),
          itemHeightInGrid: SizeManager.s100,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoSocialMedia,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    socialMediaProvider.setIsScreenDisposed(true);
    socialMediaProvider.scrollController.dispose();
  }
}