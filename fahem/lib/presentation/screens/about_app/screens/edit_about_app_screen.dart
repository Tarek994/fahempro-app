import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/about_app_model.dart';
import 'package:fahem/domain/usecases/about_app/edit_about_app_usecase.dart';
import 'package:fahem/presentation/screens/about_app/controllers/edit_about_app_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';

class EditAboutAppScreen extends StatefulWidget {
  final AboutAppModel aboutAppModel;

  const EditAboutAppScreen({
    super.key,
    required this.aboutAppModel,
  });

  @override
  State<EditAboutAppScreen> createState() => _EditAboutAppScreenState();
}

class _EditAboutAppScreenState extends State<EditAboutAppScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTextAr = TextEditingController();
  final TextEditingController _textEditingControllerTextEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingControllerTextAr.text = widget.aboutAppModel.textAr;
    _textEditingControllerTextEn.text = widget.aboutAppModel.textEn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditAboutAppProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.editAboutApp),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Text Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerTextAr,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.text).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Text En *
                          CustomTextFormField(
                            controller: _textEditingControllerTextEn,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.text).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                EditAboutAppParameters editAboutAppParameters = EditAboutAppParameters(
                                  textAr: _textEditingControllerTextAr.text.trim(),
                                  textEn: _textEditingControllerTextEn.text.trim(),
                                );
                                provider.editAboutApp(context: context, parameters: editAboutAppParameters);
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: FontAwesomeIcons.penToSquare,
                            text: Methods.getText(StringsManager.edit).toTitleCase(),
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
    _textEditingControllerTextAr.dispose();
    _textEditingControllerTextEn.dispose();
  }
}