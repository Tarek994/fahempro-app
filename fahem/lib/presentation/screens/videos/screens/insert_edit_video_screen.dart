import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/videos/controllers/insert_edit_video_provider.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/domain/usecases/videos/edit_video_usecase.dart';
import 'package:fahem/domain/usecases/videos/insert_video_usecase.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditVideoScreen extends StatefulWidget {
  final VideoModel? videoModel;

  const InsertEditVideoScreen({
    super.key,
    this.videoModel,
  });

  @override
  State<InsertEditVideoScreen> createState() => _InsertEditVideoScreenState();
}

class _InsertEditVideoScreenState extends State<InsertEditVideoScreen> {
  late InsertEditVideoProvider insertEditVideoProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleArController = TextEditingController();
  final TextEditingController _titleEnController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _aboutVideoArController = TextEditingController();
  final TextEditingController _aboutVideoEnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditVideoProvider = Provider.of<InsertEditVideoProvider>(context, listen: false);

    if(widget.videoModel != null) {
      _titleArController.text = widget.videoModel!.titleAr;
      _titleEnController.text = widget.videoModel!.titleEn;
      _linkController.text = widget.videoModel!.link;
      _aboutVideoArController.text = widget.videoModel!.aboutVideoAr;
      _aboutVideoEnController.text = widget.videoModel!.aboutVideoEn;
      insertEditVideoProvider.setPlaylist(widget.videoModel!.playlist);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditVideoProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.videoModel == null ? StringsManager.addVideo : StringsManager.editVideo,
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
                                  insertEditVideoProvider.changePlaylist(playlist);
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
                            textColor: provider.playlist == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.playlist == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // titleAr *
                          CustomTextFormField(
                            controller: _titleArController,
                            labelText: '${Methods.getText(StringsManager.title).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // titleEn *
                          CustomTextFormField(
                            controller: _titleEnController,
                            labelText: '${Methods.getText(StringsManager.title).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Link *
                          CustomTextFormField(
                            controller: _linkController,
                            labelText: '${Methods.getText(StringsManager.link).toTitleCase()} *',
                            validator: Validator.validateLink,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // aboutVideoAr *
                          CustomTextFormField(
                            controller: _aboutVideoArController,
                            labelText: '${Methods.getText(StringsManager.aboutVideo).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // aboutVideoEn *
                          CustomTextFormField(
                            controller: _aboutVideoEnController,
                            labelText: '${Methods.getText(StringsManager.aboutVideo).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditVideoProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.videoModel == null) {
                                  InsertVideoParameters insertVideoParameters = InsertVideoParameters(
                                    playlistId: provider.playlist!.playlistId,
                                    titleAr: _titleArController.text.trim(),
                                    titleEn: _titleEnController.text.trim(),
                                    link: _linkController.text.trim(),
                                    aboutVideoAr: _aboutVideoArController.text.trim(),
                                    aboutVideoEn: _aboutVideoEnController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditVideoProvider.insertVideo(context: context, insertVideoParameters: insertVideoParameters);
                                }
                                else {
                                  EditVideoParameters editVideoParameters = EditVideoParameters(
                                    videoId: widget.videoModel!.videoId,
                                    playlistId: provider.playlist!.playlistId,
                                    titleAr: _titleArController.text.trim(),
                                    titleEn: _titleEnController.text.trim(),
                                    link: _linkController.text.trim(),
                                    aboutVideoAr: _aboutVideoArController.text.trim(),
                                    aboutVideoEn: _aboutVideoEnController.text.trim(),
                                  );
                                  insertEditVideoProvider.editVideo(context: context, editVideoParameters: editVideoParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.videoModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.videoModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _titleArController.dispose();
    _titleEnController.dispose();
    _linkController.dispose();
    _aboutVideoArController.dispose();
    _aboutVideoEnController.dispose();
    super.dispose();
  }
}