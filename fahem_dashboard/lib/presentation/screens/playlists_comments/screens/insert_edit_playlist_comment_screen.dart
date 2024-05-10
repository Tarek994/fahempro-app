import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/screens/playlists_comments/controllers/insert_edit_playlist_comment_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/playlist_comment_model.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/edit_playlist_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/insert_playlist_comment_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditPlaylistCommentScreen extends StatefulWidget {
  final PlaylistCommentModel? playlistCommentModel;

  const InsertEditPlaylistCommentScreen({
    super.key,
    this.playlistCommentModel,
  });

  @override
  State<InsertEditPlaylistCommentScreen> createState() => _InsertEditPlaylistCommentScreenState();
}

class _InsertEditPlaylistCommentScreenState extends State<InsertEditPlaylistCommentScreen> {
  late InsertEditPlaylistCommentProvider insertEditPlaylistCommentProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditPlaylistCommentProvider = Provider.of<InsertEditPlaylistCommentProvider>(context, listen: false);

    if(widget.playlistCommentModel != null) {
      _commentController.text = widget.playlistCommentModel!.comment;
      insertEditPlaylistCommentProvider.setPlaylist(widget.playlistCommentModel!.playlist);
      insertEditPlaylistCommentProvider.setUser(widget.playlistCommentModel!.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditPlaylistCommentProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.playlistCommentModel == null ? StringsManager.addPlaylistComment : StringsManager.editPlaylistComment,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Playlist *
                          CustomButton(
                            onPressed: () {
                              Dialogs.playlistsBottomSheet(context: context).then((playlist) {
                                if(playlist != null) {
                                  insertEditPlaylistCommentProvider.changePlaylist(playlist);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.playlist == null
                                ? Methods.getText(StringsManager.choosePlaylist).toCapitalized()
                                : (MyProviders.appProvider.isEnglish ? provider.playlist!.playlistNameEn : provider.playlist!.playlistNameAr),
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.playlist == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.playlist == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditPlaylistCommentProvider.changeUser(user);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.user == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.user == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Comment *
                          CustomTextFormField(
                            controller: _commentController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.comment).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditPlaylistCommentProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.playlistCommentModel == null) {
                                  InsertPlaylistCommentParameters insertPlaylistCommentParameters = InsertPlaylistCommentParameters(
                                    playlistId: provider.playlist!.playlistId,
                                    userId: provider.user!.userId,
                                    comment: _commentController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditPlaylistCommentProvider.insertPlaylistComment(context: context, insertPlaylistCommentParameters: insertPlaylistCommentParameters);
                                }
                                else {
                                  EditPlaylistCommentParameters editPlaylistCommentParameters = EditPlaylistCommentParameters(
                                    playlistCommentId: widget.playlistCommentModel!.playlistCommentId,
                                    playlistId: provider.playlist!.playlistId,
                                    userId: provider.user!.userId,
                                    comment: _commentController.text.trim(),
                                  );
                                  insertEditPlaylistCommentProvider.editPlaylistComment(context: context, editPlaylistCommentParameters: editPlaylistCommentParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.playlistCommentModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.playlistCommentModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}