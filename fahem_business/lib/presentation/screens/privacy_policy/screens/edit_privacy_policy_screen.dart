import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/privacy_policy_model.dart';
import 'package:fahem_business/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';
import 'package:fahem_business/presentation/screens/privacy_policy/controllers/edit_privacy_policy_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';

class EditPrivacyPolicyScreen extends StatefulWidget {
  final PrivacyPolicyModel privacyPolicyModel;

  const EditPrivacyPolicyScreen({
    super.key,
    required this.privacyPolicyModel,
  });

  @override
  State<EditPrivacyPolicyScreen> createState() => _EditPrivacyPolicyScreenState();
}

class _EditPrivacyPolicyScreenState extends State<EditPrivacyPolicyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTextAr = TextEditingController();
  final TextEditingController _textEditingControllerTextEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingControllerTextAr.text = widget.privacyPolicyModel.textAr;
    _textEditingControllerTextEn.text = widget.privacyPolicyModel.textEn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditPrivacyPolicyProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.editPrivacyPolicy),
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
                                EditPrivacyPolicyParameters editPrivacyPolicyParameters = EditPrivacyPolicyParameters(
                                  textAr: _textEditingControllerTextAr.text.trim(),
                                  textEn: _textEditingControllerTextEn.text.trim(),
                                );
                                provider.editPrivacyPolicy(context: context, parameters: editPrivacyPolicyParameters);
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