import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/playlist_model.dart';
import 'package:fahem_business/presentation/screens/playlists/widgets/extra_widget_in_top_playlists.dart';
import 'package:fahem_business/presentation/screens/playlists/widgets/playlist_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/playlists/controllers/playlists_provider.dart';
import 'package:fahem_business/presentation/screens/playlists/widgets/playlist_list_item.dart';
import 'package:fahem_business/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/template_list_screen.dart';

class PlaylistsScreen extends StatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  late PlaylistsProvider playlistsProvider;

  @override
  void initState() {
    super.initState();
    playlistsProvider = Provider.of<PlaylistsProvider>(context, listen: false);
    playlistsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await playlistsProvider.fetchData());
  }

  void _onInsert(PlaylistModel? playlist) {
    if(playlist != null) {
      playlistsProvider.insertInPlaylists(playlist);
      if(playlistsProvider.paginationModel != null) playlistsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(PlaylistModel? playlist) {
    if(playlist != null) {
      playlistsProvider.editInPlaylists(playlist);
    }
  }

  void _onDelete(int playlistId) {
    playlistsProvider.deletePlaylist(context: context, playlistId: playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addPlaylist) ? () {
            Methods.routeTo(context, Routes.insertEditPlaylistScreen, arguments: null, then: (playlist) => _onInsert(playlist));
          } : null,
          screenTitle: StringsManager.playlists,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByName,
            ordersItems: const [OrderByType.playlistsNewestFirst, OrderByType.playlistsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.playlists.isNotEmpty,
          dataCount: provider.playlists.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list, ViewStyle.grid],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => PlaylistListItem(
            playlistModel: provider.playlists[index],
            onEdit: (playlist) => _onEdit(playlist),
            onDelete: () => _onDelete(provider.playlists[index].playlistId),
          ),
          gridItemBuilder: (context, index) => PlaylistGridItem(
            playlistModel: provider.playlists[index],
            onEdit: (playlist) => _onEdit(playlist),
            onDelete: () => _onDelete(provider.playlists[index].playlistId),
          ),
          itemHeightInGrid: SizeManager.s100,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoPlaylists,
          extraWidget: const ExtraWidgetInTopPlaylists(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    playlistsProvider.setIsScreenDisposed(true);
    playlistsProvider.scrollController.dispose();
  }
}