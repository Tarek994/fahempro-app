import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlists_provider.dart';
import 'package:fahem/presentation/screens/playlists/widgets/playlist_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

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
          goToInsertScreen:  null,
          screenTitle: StringsManager.videos,
          appBarColor: Colors.transparent,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.playlists.isNotEmpty,
          dataCount: provider.playlists.length,
          totalResults: null,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => PlaylistListItem(
            playlistModel: provider.playlists[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoPlaylists,
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