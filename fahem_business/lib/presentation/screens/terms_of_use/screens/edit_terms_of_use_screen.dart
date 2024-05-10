import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/terms_of_use_model.dart';
import 'package:fahem_business/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';
import 'package:fahem_business/presentation/screens/terms_of_use/controllers/edit_terms_of_use_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';

class EditTermsOfUseScreen extends StatefulWidget {
  final TermsOfUseModel termsOfUseModel;

  const EditTermsOfUseScreen({
    super.key,
    required this.termsOfUseModel,
  });

  @override
  State<EditTermsOfUseScreen> createState() => _EditTermsOfUseScreenState();
}

class _EditTermsOfUseScreenState extends State<EditTermsOfUseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTextAr = TextEditingController();
  final TextEditingController _textEditingControllerTextEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingControllerTextAr.text = widget.termsOfUseModel.textAr;
    _textEditingControllerTextEn.text = widget.termsOfUseModel.textEn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditTermsOfUseProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.editTermsOfUse),
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
                                EditTermsOfUseParameters editTermsOfUseParameters = EditTermsOfUseParameters(
                                  textAr: _textEditingControllerTextAr.text.trim(),
                                  textEn: _textEditingControllerTextEn.text.trim(),
                                );
                                provider.editTermsOfUse(context: context, parameters: editTermsOfUseParameters);
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