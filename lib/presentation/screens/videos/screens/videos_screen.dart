import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/presentation/screens/videos/widgets/extra_widget_in_top_videos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/videos/controllers/videos_provider.dart';
import 'package:fahem/presentation/screens/videos/widgets/video_list_item.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late VideosProvider videosProvider;

  @override
  void initState() {
    super.initState();
    videosProvider = Provider.of<VideosProvider>(context, listen: false);
    videosProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await videosProvider.fetchData());
  }

  void _onInsert(VideoModel? video) {
    if(video != null) {
      videosProvider.insertInVideos(video);
      if(videosProvider.paginationModel != null) videosProvider.paginationModel!.total++;
    }
  }

  void _onEdit(VideoModel? video) {
    if(video != null) {
      videosProvider.editInVideos(video);
    }
  }

  void _onDelete(int videoId) {
    videosProvider.deleteVideo(context: context, videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideosProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addVideo) ? () {
            Methods.routeTo(context, Routes.insertEditVideoScreen, arguments: null, then: (video) => _onInsert(video));
          } : null,
          screenTitle: StringsManager.videos,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.videosNewestFirst, OrderByType.videosOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.playlist],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.videos.isNotEmpty,
          dataCount: provider.videos.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => VideoListItem(
            videoModel: provider.videos[index],
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoVideos,
          extraWidget: const ExtraWidgetInTopVideos(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    videosProvider.setIsScreenDisposed(true);
    videosProvider.scrollController.dispose();
  }
}