import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlist_details_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExtraWidgetInPlaylistDetails extends StatefulWidget {

  const ExtraWidgetInPlaylistDetails({super.key});

  @override
  State<ExtraWidgetInPlaylistDetails> createState() => _ExtraWidgetInPlaylistDetailsState();
}

class _ExtraWidgetInPlaylistDetailsState extends State<ExtraWidgetInPlaylistDetails> {
  late PlaylistDetailsProvider playlistDetailsProvider;
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    playlistDetailsProvider = Provider.of<PlaylistDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistDetailsProvider>(
      builder: (context, provider, _) {
        if(provider.currentVideo != null) {
          if(_youtubePlayerController == null) {
            _youtubePlayerController = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(provider.currentVideo!.link)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
              ),
            );
          }
          else {
            if(YoutubePlayer.convertUrlToId(provider.currentVideo!.link) != _youtubePlayerController!.initialVideoId) {
              _youtubePlayerController!.load(YoutubePlayer.convertUrlToId(provider.currentVideo!.link)!, startAt:0);
              _youtubePlayerController!.play();
            }
          }
        }

        return Container(
          color: ColorsManager.grey100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(_youtubePlayerController != null) YoutubePlayerBuilder(
                player: YoutubePlayer(controller: _youtubePlayerController!),
                builder: (context, player) => player,
              ),
              if(provider.currentVideo != null) ...[
                // Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     ImageWidget(
                //       image: Methods.getYoutubeThumbnail(YoutubePlayer.convertUrlToId(currentVideo.link)!),
                //       width: double.infinity,
                //       height: SizeManager.s200,
                //       isShowFullImageScreen: false,
                //     ),
                //     CustomButton(
                //       onPressed: () {
                //         Methods.openUrl(url: currentVideo.link);
                //       },
                //       buttonType: ButtonType.icon,
                //       iconData: Icons.play_arrow,
                //       padding: EdgeInsets.zero,
                //       isCircleBorder: true,
                //       width: SizeManager.s50,
                //       height: SizeManager.s50,
                //       iconSize: SizeManager.s30,
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  child: Text(
                    MyProviders.appProvider.isEnglish ? provider.currentVideo!.titleEn : provider.currentVideo!.titleAr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeightManager.black,
                      fontSize: SizeManager.s18,
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: SizeManager.s45,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          if(playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.aboutVideo) return;
                          playlistDetailsProvider.changeCurrentPlaylistDetailsPages(PlaylistDetailsPages.aboutVideo);
                        },
                        buttonType: ButtonType.text,
                        text: Methods.getText(StringsManager.aboutVideo).toCapitalized(),
                        buttonColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.aboutVideo ? ColorsManager.white : ColorsManager.grey100,
                        textColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.aboutVideo ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                        borderRadius: SizeManager.s0,
                        width: double.infinity,
                        textFontWeight: FontWeightManager.black,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          if(playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.videos) return;
                          playlistDetailsProvider.setCurrentPlaylistDetailsPages(PlaylistDetailsPages.videos);
                          playlistDetailsProvider.reFetchVideos();
                        },
                        buttonType: ButtonType.text,
                        text: Methods.getText(StringsManager.restOfTheVideos).toCapitalized(),
                        buttonColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.videos ? ColorsManager.white : ColorsManager.grey100,
                        textColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.videos ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                        borderRadius: SizeManager.s0,
                        width: double.infinity,
                        textFontWeight: FontWeightManager.black,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          if(playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.comments) return;
                          playlistDetailsProvider.setCurrentPlaylistDetailsPages(PlaylistDetailsPages.comments);
                          playlistDetailsProvider.reFetchPlaylistsComments();
                        },
                        buttonType: ButtonType.text,
                        text: Methods.getText(StringsManager.comments).toCapitalized(),
                        buttonColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.comments ? ColorsManager.white : ColorsManager.grey100,
                        textColor: playlistDetailsProvider.currentPlaylistDetailsPages == PlaylistDetailsPages.comments ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                        borderRadius: SizeManager.s0,
                        width: double.infinity,
                        textFontWeight: FontWeightManager.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
