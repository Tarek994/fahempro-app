import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/playlist_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/presentation/screens/playlists_comments/controllers/playlists_comments_provider.dart';
import 'package:fahem_dashboard/presentation/screens/playlists_comments/widgets/playlist_comment_list_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/template_list_screen.dart';

class PlaylistsCommentsScreen extends StatefulWidget {
  const PlaylistsCommentsScreen({super.key});

  @override
  State<PlaylistsCommentsScreen> createState() => _PlaylistsCommentsScreenState();
}

class _PlaylistsCommentsScreenState extends State<PlaylistsCommentsScreen> {
  late PlaylistsCommentsProvider playlistsCommentsProvider;

  @override
  void initState() {
    super.initState();
    playlistsCommentsProvider = Provider.of<PlaylistsCommentsProvider>(context, listen: false);
    playlistsCommentsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await playlistsCommentsProvider.fetchData());
  }

  void _onInsert(PlaylistCommentModel? playlistComment) {
    if(playlistComment != null) {
      playlistsCommentsProvider.insertInPlaylistsComments(playlistComment);
      if(playlistsCommentsProvider.paginationModel != null) playlistsCommentsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(PlaylistCommentModel? playlistComment) {
    if(playlistComment != null) {
      playlistsCommentsProvider.editInPlaylistsComments(playlistComment);
    }
  }

  void _onDelete(int playlistCommentId) {
    playlistsCommentsProvider.deletePlaylistComment(context: context, playlistCommentId: playlistCommentId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsCommentsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoadingDelete,
          waitForDone: provider.isLoadingDelete,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: Methods.checkAdminPermission(AdminPermissions.addPlaylistComment) ? () {
            Methods.routeTo(context, Routes.insertEditPlaylistCommentScreen, arguments: null, then: (playlistComment) => _onInsert(playlistComment));
          } : null,
          screenTitle: StringsManager.playlistsComments,
          searchFilterOrderWidget: SearchFilterOrderWidget(
            hintText: StringsManager.searchByComment,
            ordersItems: const [OrderByType.playlistsCommentsNewestFirst, OrderByType.playlistsCommentsOldestFirst],
            filtersItems: const [FiltersType.dateOfCreated, FiltersType.playlist, FiltersType.user],
            dataState: provider.dataState,
            reFetchData: () async => await provider.reFetchData(),
            customText: {
              FiltersType.dateOfCreated.name: StringsManager.dateOfAdded,
            },
          ),
          isDataNotEmpty: provider.playlistsComments.isNotEmpty,
          dataCount: provider.playlistsComments.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => PlaylistCommentListItem(
            playlistCommentModel: provider.playlistsComments[index],
            onEdit: (playlistComment) => _onEdit(playlistComment),
            onDelete: () => _onDelete(provider.playlistsComments[index].playlistCommentId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoComments,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    playlistsCommentsProvider.setIsScreenDisposed(true);
    playlistsCommentsProvider.scrollController.dispose();
  }
}