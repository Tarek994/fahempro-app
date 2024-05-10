import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/home/controllers/home_provider.dart';
import 'package:fahem/presentation/screens/home/widgets/main_title.dart';
import 'package:fahem/presentation/screens/playlists/widgets/playlist_list_item.dart';
import 'package:fahem/presentation/shared/widgets/my_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistsWidget extends StatelessWidget {

  const PlaylistsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          return ConditionalBuilder(
            condition: homeProvider.playlists.isNotEmpty,
            builder: (_) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    child: MainTitle(
                      onPressed: () => Methods.routeTo(context, Routes.playlistsScreen),
                      title: StringsManager.videos,
                    ),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  SizedBox(
                    height: SizeManager.s150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                      itemBuilder: (context, index) => SizedBox(
                        width: SizeManager.s300,
                        child: PlaylistListItem(
                          playlistModel: homeProvider.playlists[index],
                          index: index,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                      itemCount: homeProvider.playlists.length,
                    ),
                  ),
                ],
              );
            },
            fallback: (_) {
              if(homeProvider.playlistsDataState == DataState.loading) {
                return _Loading();
              }
              if(homeProvider.playlistsDataState == DataState.empty) {
                return _Empty();
              }
              if(homeProvider.playlistsDataState == DataState.error) {
                return MyErrorWidget(onPressed: () => homeProvider.reFetchPlaylists());
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return const Padding(
    //   padding: EdgeInsets.all(SizeManager.s10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       SizedBox(
    //         width: SizeManager.s25,
    //         height: SizeManager.s25,
    //         child: CircularProgressIndicator(strokeWidth: SizeManager.s3),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _Empty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(SizeManager.s10),
    //     child: Text(
    //       Methods.getText(StringsManager.thereAreNoPlaylists).toCapitalized(),
    //       style: Theme.of(context).textTheme.bodySmall,
    //     ),
    //   ),
    // );
  }
}