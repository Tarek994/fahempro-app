import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlist_details_provider.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListItem extends StatelessWidget {
  final VideoModel videoModel;

  const VideoListItem({
    super.key,
    required this.videoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistDetailsProvider>(
      builder: (context, playlistDetailsProvider, _) {
        return Hover(
          onTap: () {
            playlistDetailsProvider.changeCurrentVideo(videoModel);
          },
          color: ColorsManager.grey1,
          child: Row(
            children: [
              ImageWidget(
                image: Methods.getYoutubeThumbnail(YoutubePlayer.convertUrlToId(videoModel.link)!),
                width: SizeManager.s100,
                height: SizeManager.s100,
                borderRadius: SizeManager.s10,
                isShowFullImageScreen: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyProviders.appProvider.isEnglish ? videoModel.titleEn : videoModel.titleAr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightManager.bold,
                          fontSize: SizeManager.s16,
                        ),
                      ),
                      const SizedBox(height: SizeManager.s10),
                      DateWidget(createdAt: videoModel.createdAt),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}