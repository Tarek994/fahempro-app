import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/suggested_message_model.dart';
import 'package:fahem/domain/usecases/suggested_messages/edit_suggested_message_usecase.dart';
import 'package:fahem/domain/usecases/suggested_messages/insert_suggested_message_usecase.dart';
import 'package:fahem/presentation/screens/suggested_messages/controllers/insert_edit_suggested_message_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditSuggestedMessageScreen extends StatefulWidget {
  final SuggestedMessageModel? suggestedMessageModel;

  const InsertEditSuggestedMessageScreen({super.key, this.suggestedMessageModel});

  @override
  State<InsertEditSuggestedMessageScreen> createState() => _InsertEditSuggestedMessageScreenState();
}

class _InsertEditSuggestedMessageScreenState extends State<InsertEditSuggestedMessageScreen> {
  late InsertEditSuggestedMessageProvider insertEditSuggestedMessageProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerMessageAr = TextEditingController();
  final TextEditingController _textEditingControllerMessageEn = TextEditingController();
  final TextEditingController _textEditingControllerAnswerAr = TextEditingController();
  final TextEditingController _textEditingControllerAnswerEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditSuggestedMessageProvider = Provider.of<InsertEditSuggestedMessageProvider>(context, listen: false);

    if(widget.suggestedMessageModel != null) {
      _textEditingControllerMessageAr.text = widget.suggestedMessageModel!.messageAr;
      _textEditingControllerMessageEn.text = widget.suggestedMessageModel!.messageEn;
      _textEditingControllerAnswerAr.text = widget.suggestedMessageModel!.answerAr;
      _textEditingControllerAnswerEn.text = widget.suggestedMessageModel!.answerEn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditSuggestedMessageProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.suggestedMessageModel == null ? StringsManager.addSuggestedMessage : StringsManager.editSuggestedMessage,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Message Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerMessageAr,
                            labelText: '${Methods.getText(StringsManager.message).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: Icons.message,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Message En *
                          CustomTextFormField(
                            controller: _textEditingControllerMessageEn,
                            labelText: '${Methods.getText(StringsManager.message).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: Icons.message,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Answer Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerAnswerAr,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            labelText: '${Methods.getText(StringsManager.answer).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Answer En *
                          CustomTextFormField(
                            controller: _textEditingControllerAnswerEn,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            labelText: '${Methods.getText(StringsManager.answer).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                if(widget.suggestedMessageModel == null) {
                                  InsertSuggestedMessageParameters insertSuggestedMessageParameters = InsertSuggestedMessageParameters(
                                    messageAr: _textEditingControllerMessageAr.text.trim(),
                                    messageEn: _textEditingControllerMessageEn.text.trim(),
                                    answerAr: _textEditingControllerAnswerAr.text.trim(),
                                    answerEn: _textEditingControllerAnswerEn.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditSuggestedMessageProvider.insertSuggestedMessage(context: context, insertSuggestedMessageParameters: insertSuggestedMessageParameters);
                                }
                                else {
                                  EditSuggestedMessageParameters editSuggestedMessageParameters = EditSuggestedMessageParameters(
                                    suggestedMessageId: widget.suggestedMessageModel!.suggestedMessageId,
                                    messageAr: _textEditingControllerMessageAr.text.trim(),
                                    messageEn: _textEditingControllerMessageEn.text.trim(),
                                    answerAr: _textEditingControllerAnswerAr.text.trim(),
                                    answerEn: _textEditingControllerAnswerEn.text.trim(),
                                  );
                                  insertEditSuggestedMessageProvider.editSuggestedMessage(context: context, editSuggestedMessageParameters: editSuggestedMessageParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.suggestedMessageModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.suggestedMessageModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _textEditingControllerMessageAr.dispose();
    _textEditingControllerMessageEn.dispose();
    _textEditingControllerAnswerAr.dispose();
    _textEditingControllerAnswerEn.dispose();
  }
}