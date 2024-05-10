import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/presentation/screens/playlists/controllers/insert_edit_playlist_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/edit_playlist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/insert_playlist_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditPlaylistScreen extends StatefulWidget {
  final PlaylistModel? playlistModel;

  const InsertEditPlaylistScreen({
    super.key,
    this.playlistModel,
  });

  @override
  State<InsertEditPlaylistScreen> createState() => _InsertEditPlaylistScreenState();
}

class _InsertEditPlaylistScreenState extends State<InsertEditPlaylistScreen> {
  late InsertEditPlaylistProvider insertEditPlaylistProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameArController = TextEditingController();
  final TextEditingController _playlistNameEnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditPlaylistProvider = Provider.of<InsertEditPlaylistProvider>(context, listen: false);

    if(widget.playlistModel != null) {
      _playlistNameArController.text = widget.playlistModel!.playlistNameAr;
      _playlistNameEnController.text = widget.playlistModel!.playlistNameEn;
      insertEditPlaylistProvider.setPlaylistImage(widget.playlistModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditPlaylistProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.playlistModel == null ? StringsManager.addPlaylist : StringsManager.editPlaylist,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Playlist Image
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SizedBox(
                              width: SizeManager.s120,
                              height: SizeManager.s120,
                              child: Stack(
                                children: [
                                  Container(
                                    width: SizeManager.s120,
                                    height: SizeManager.s120,
                                    decoration: BoxDecoration(
                                      color: ColorsManager.grey100,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: ColorsManager.white, width: SizeManager.s5),
                                    ),
                                    child: ImageTypeWidget(
                                      image: provider.playlistImage,
                                      imageDirectory: ApiConstants.playlistsDirectory,
                                      title: StringsManager.image,
                                      imageFileBorderRadius: SizeManager.s100,
                                      imageNetworkWidth: SizeManager.s50,
                                      imageNetworkHeight: SizeManager.s50,
                                      imageNetworkBoxShape: BoxShape.circle,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CustomButton(
                                      buttonType: ButtonType.icon,
                                      onPressed: () async {
                                        if(provider.playlistImage == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) provider.changePlaylistImage(xFile);
                                        }
                                        else {
                                          provider.changePlaylistImage(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.playlistImage == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.playlistImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          // playlistNameAr *
                          CustomTextFormField(
                            controller: _playlistNameArController,
                            labelText: '${Methods.getText(StringsManager.playlistName).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.play,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // playlistNameEn *
                          CustomTextFormField(
                            controller: _playlistNameEnController,
                            labelText: '${Methods.getText(StringsManager.playlistName).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.play,
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditPlaylistProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.playlistModel == null) {
                                  InsertPlaylistParameters insertPlaylistParameters = InsertPlaylistParameters(
                                    image: '',
                                    playlistNameAr: _playlistNameArController.text.trim(),
                                    playlistNameEn: _playlistNameEnController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),

                                  );
                                  insertEditPlaylistProvider.insertPlaylist(context: context, insertPlaylistParameters: insertPlaylistParameters);
                                }
                                else {
                                  EditPlaylistParameters editPlaylistParameters = EditPlaylistParameters(
                                    playlistId: widget.playlistModel!.playlistId,
                                    image: provider.playlistImage is String ? provider.playlistImage : '',
                                    playlistNameAr: _playlistNameArController.text.trim(),
                                    playlistNameEn: _playlistNameEnController.text.trim(),
                                  );
                                  insertEditPlaylistProvider.editPlaylist(context: context, editPlaylistParameters: editPlaylistParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.playlistModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.playlistModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _playlistNameArController.dispose();
    _playlistNameEnController.dispose();
    super.dispose();
  }
}