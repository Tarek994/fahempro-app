import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/service_description_model.dart';
import 'package:fahem_dashboard/domain/usecases/service_description/edit_service_description_usecase.dart';
import 'package:fahem_dashboard/presentation/screens/service_description/controllers/edit_service_description_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';

class EditServiceDescriptionScreen extends StatefulWidget {
  final ServiceDescriptionModel serviceDescriptionModel;

  const EditServiceDescriptionScreen({
    super.key,
    required this.serviceDescriptionModel,
  });

  @override
  State<EditServiceDescriptionScreen> createState() => _EditServiceDescriptionScreenState();
}

class _EditServiceDescriptionScreenState extends State<EditServiceDescriptionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTextAr = TextEditingController();
  final TextEditingController _textEditingControllerTextEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingControllerTextAr.text = widget.serviceDescriptionModel.textAr;
    _textEditingControllerTextEn.text = widget.serviceDescriptionModel.textEn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditServiceDescriptionProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.editServiceDescription),
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
                                EditServiceDescriptionParameters editServiceDescriptionParameters = EditServiceDescriptionParameters(
                                  textAr: _textEditingControllerTextAr.text.trim(),
                                  textEn: _textEditingControllerTextEn.text.trim(),
                                );
                                provider.editServiceDescription(context: context, parameters: editServiceDescriptionParameters);
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