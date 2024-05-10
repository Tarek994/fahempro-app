import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/domain/usecases/social_media/edit_social_media_usecase.dart';
import 'package:fahem/domain/usecases/social_media/insert_social_media_usecase.dart';
import 'package:fahem/presentation/screens/social_media/controllers/insert_edit_social_media_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditSocialMediaScreen extends StatefulWidget {
  final SocialMediaModel? socialMediaModel;

  const InsertEditSocialMediaScreen({
    super.key,
    this.socialMediaModel,
  });

  @override
  State<InsertEditSocialMediaScreen> createState() => _InsertEditSocialMediaScreenState();
}

class _InsertEditSocialMediaScreenState extends State<InsertEditSocialMediaScreen> {
  late InsertEditSocialMediaProvider insertEditSocialMediaProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerNameAr = TextEditingController();
  final TextEditingController _textEditingControllerNameEn = TextEditingController();
  final TextEditingController _textEditingControllerLink = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditSocialMediaProvider = Provider.of<InsertEditSocialMediaProvider>(context, listen: false);

    if(widget.socialMediaModel != null) {
      _textEditingControllerNameAr.text = widget.socialMediaModel!.nameAr;
      _textEditingControllerNameEn.text = widget.socialMediaModel!.nameEn;
      _textEditingControllerLink.text = widget.socialMediaModel!.link;
      insertEditSocialMediaProvider.setSocialMediaImage(widget.socialMediaModel!.image);
      insertEditSocialMediaProvider.setIsAvailable(widget.socialMediaModel!.isAvailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditSocialMediaProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.socialMediaModel == null ? StringsManager.addSocialMedia : StringsManager.editSocialMedia),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // SocialMedia Image *
                          SizedBox(
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
                                    image: provider.socialMediaImage,
                                    imageDirectory: ApiConstants.socialMediaDirectory,
                                    title: StringsManager.socialMediaImage,
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
                                      if(provider.socialMediaImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditSocialMediaProvider.changeSocialMediaImage(xFile);
                                      }
                                      else {
                                        insertEditSocialMediaProvider.changeSocialMediaImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.socialMediaImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.socialMediaImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),
                          
                          // Name Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerNameAr,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Name En *
                          CustomTextFormField(
                            controller: _textEditingControllerNameEn,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Link *
                          CustomTextFormField(
                            controller: _textEditingControllerLink,
                            keyboardType: TextInputType.url,
                            labelText: '${Methods.getText(StringsManager.link).toTitleCase()} *',
                            prefixIconData: FontAwesomeIcons.link,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // isAvailable *
                          CheckboxListTile(
                            value: provider.isAvailable,
                            onChanged: (value) => provider.changeIsAvailable(value!),
                            title: Text(
                              Methods.getText(StringsManager.activationSocialMedia).toTitleCase(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            tileColor: ColorsManager.white,
                            activeColor: ColorsManager.lightPrimaryColor,
                            checkColor: ColorsManager.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(SizeManager.s10),
                              side: const BorderSide(color: ColorsManager.grey300),
                            ),
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate() && insertEditSocialMediaProvider.isAllDataValid()) {
                                if(widget.socialMediaModel == null) {
                                  InsertSocialMediaParameters insertSocialMediaParameters = InsertSocialMediaParameters(
                                    image: '',
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    link: _textEditingControllerLink.text.trim(),
                                    isAvailable: insertEditSocialMediaProvider.isAvailable,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditSocialMediaProvider.insertSocialMedia(context: context, insertSocialMediaParameters: insertSocialMediaParameters);
                                }
                                else {
                                  EditSocialMediaParameters editSocialMediaParameters = EditSocialMediaParameters(
                                    image: insertEditSocialMediaProvider.socialMediaImage is String ? insertEditSocialMediaProvider.socialMediaImage : '',
                                    socialMediaId: widget.socialMediaModel!.socialMediaId,
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    link: _textEditingControllerLink.text.trim(),
                                    isAvailable: insertEditSocialMediaProvider.isAvailable,
                                  );
                                  insertEditSocialMediaProvider.editSocialMedia(context: context, editSocialMediaParameters: editSocialMediaParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.socialMediaModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.socialMediaModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    super.dispose();
    _textEditingControllerNameAr.dispose();
    _textEditingControllerNameEn.dispose();
    _textEditingControllerLink.dispose();
  }
}