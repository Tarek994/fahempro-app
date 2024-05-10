import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/domain/usecases/playlists_comments/insert_playlist_comment_usecase.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlist_details_provider.dart';
import 'package:fahem/presentation/screens/playlists/widgets/extra_widget_in_playlist_details.dart';
import 'package:fahem/presentation/screens/playlists_comments/widgets/playlist_comment_list_item.dart';
import 'package:fahem/presentation/screens/videos/widgets/video_list_item.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistDetailsScreen extends StatefulWidget {

  const PlaylistDetailsScreen({super.key});

  @override
  State<PlaylistDetailsScreen> createState() => _PlaylistDetailsScreenState();
}

class _PlaylistDetailsScreenState extends State<PlaylistDetailsScreen> {
  late PlaylistDetailsProvider playlistDetailsProvider;

  @override
  void initState() {
    super.initState();
    playlistDetailsProvider = Provider.of<PlaylistDetailsProvider>(context, listen: false);
    playlistDetailsProvider.videosAddListenerScrollController();
    playlistDetailsProvider.playlistsCommentsAddListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        playlistDetailsProvider.fetchVideos(),
        playlistDetailsProvider.fetchPlaylistsComments(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistDetailsProvider>(
      builder: (context, provider, _) {
        if(provider.currentPlaylistDetailsPages == PlaylistDetailsPages.aboutVideo) {
          return Scaffold(
            backgroundColor: ColorsManager.white,
            body: CustomFullLoading(
              child: CustomScrollView(
                slivers: [
                  DefaultSliverAppBar(
                    customTitle: MyProviders.appProvider.isEnglish ? provider.playlistModel.playlistNameEn : provider.playlistModel.playlistNameAr,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ExtraWidgetInPlaylistDetails(),
                        if(provider.currentVideo != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(SizeManager.s16),
                            child: Text(
                              MyProviders.appProvider.isEnglish ? provider.currentVideo!.aboutVideoEn : provider.currentVideo!.aboutVideoAr,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s2),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if(provider.currentPlaylistDetailsPages == PlaylistDetailsPages.videos) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchVideos(),
              ]);
            },
            scrollController: provider.videosScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            title: MyProviders.appProvider.isEnglish ? provider.playlistModel.playlistNameEn : provider.playlistModel.playlistNameAr,
            searchFilterOrderWidget: null,
            scaffoldColor: ColorsManager.white,
            isDataNotEmpty: provider.videos.isNotEmpty,
            dataCount: provider.videos.length,
            totalResults: provider.videosPaginationModel == null ? 0 : provider.videosPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.videosViewStyle,
            changeViewStyleToList: () => provider.changeVideosViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changeVideosViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => VideoListItem(videoModel: provider.videos[index]),
            gridItemBuilder: null,
            dataState: provider.videosDataState,
            hasMore: provider.videosHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoVideos,
            extraWidget: const ExtraWidgetInPlaylistDetails(),
          );
        }
        if(provider.currentPlaylistDetailsPages == PlaylistDetailsPages.comments) {
          return TemplateListScreen(
            reFetchData: () async {
              await Future.wait([
                provider.reFetchPlaylistsComments(),
              ]);
            },
            scrollController: provider.playlistsCommentsScrollController,
            goToInsertScreen: null,
            appBarColor: ColorsManager.white,
            title: MyProviders.appProvider.isEnglish ? provider.playlistModel.playlistNameEn : provider.playlistModel.playlistNameAr,
            searchFilterOrderWidget: null,
            scaffoldColor: ColorsManager.white,
            isDataNotEmpty: provider.playlistsComments.isNotEmpty,
            dataCount: provider.playlistsComments.length,
            totalResults: provider.playlistsCommentsPaginationModel == null ? 0 : provider.playlistsCommentsPaginationModel!.total,
            supportedViewStyle: const [ViewStyle.list],
            currentViewStyle: provider.playlistsCommentsViewStyle,
            changeViewStyleToList: () => provider.changePlaylistsCommentsViewStyle(ViewStyle.list),
            changeViewStyleToGrid: () => provider.changePlaylistsCommentsViewStyle(ViewStyle.grid),
            listItemBuilder: (context, index) => PlaylistCommentListItem(playlistCommentModel: provider.playlistsComments[index]),
            gridItemBuilder: null,
            dataState: provider.playlistsCommentsDataState,
            hasMore: provider.playlistsCommentsHasMore,
            noDataMsgInScreen: StringsManager.thereAreNoComments,
            extraWidget: Column(
              children: [
                const ExtraWidgetInPlaylistDetails(),
                AddCommentWidget(playlistId: provider.playlistModel.playlistId),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    playlistDetailsProvider.setIsScreenDisposed(true);
    playlistDetailsProvider.setCurrentPlaylistDetailsPages(PlaylistDetailsPages.aboutVideo);
    playlistDetailsProvider.videosScrollController.dispose();
    playlistDetailsProvider.playlistsCommentsScrollController.dispose();
  }
}

class AddCommentWidget extends StatefulWidget {
  final int playlistId;

  const AddCommentWidget({
    super.key,
    required this.playlistId,
  });

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  late PlaylistDetailsProvider playlistDetailsProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    playlistDetailsProvider = Provider.of<PlaylistDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if(MyProviders.authenticationProvider.currentUser == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(SizeManager.s16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: _commentController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              borderRadius: SizeManager.s20,
              fillColor: ColorsManager.grey1,
              labelText: Methods.getText(StringsManager.writeYourCommentHere).toTitleCase(),
              validator: Validator.validateEmpty,
            ),
            const SizedBox(height: SizeManager.s10),
            CustomButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if(_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  InsertPlaylistCommentParameters parameters = InsertPlaylistCommentParameters(
                    playlistId: widget.playlistId,
                    userId: MyProviders.authenticationProvider.currentUser!.userId,
                    comment: _commentController.text.trim(),
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  await DependencyInjection.insertPlaylistCommentUseCase.call(parameters).then((response) {
                    response.fold((failure) {}, (playlistComment) {
                      playlistDetailsProvider.insertInPlaylistsComments(playlistComment);
                      _commentController.clear();
                    });
                  });
                  setState(() => _isLoading = false);
                }
              },
              buttonType: ButtonType.text,
              isLoading: _isLoading,
              text: Methods.getText(StringsManager.send).toCapitalized(),
              width: double.infinity,
              height: SizeManager.s35,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
