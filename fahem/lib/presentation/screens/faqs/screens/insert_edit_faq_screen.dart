import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/faq_model.dart';
import 'package:fahem/domain/usecases/faqs/edit_faq_usecase.dart';
import 'package:fahem/domain/usecases/faqs/insert_faq_usecase.dart';
import 'package:fahem/presentation/screens/faqs/controllers/insert_edit_faq_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';

class InsertEditFaqScreen extends StatefulWidget {
  final FaqModel? faqModel;

  const InsertEditFaqScreen({
    super.key,
    this.faqModel,
  });

  @override
  State<InsertEditFaqScreen> createState() => _InsertEditFaqScreenState();
}

class _InsertEditFaqScreenState extends State<InsertEditFaqScreen> {
  late InsertEditFaqProvider insertEditFaqProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerQuestionAr = TextEditingController();
  final TextEditingController _textEditingControllerQuestionEn = TextEditingController();
  final TextEditingController _textEditingControllerAnswerAr = TextEditingController();
  final TextEditingController _textEditingControllerAnswerEn = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditFaqProvider = Provider.of<InsertEditFaqProvider>(context, listen: false);

    if(widget.faqModel != null) {
      _textEditingControllerQuestionAr.text = widget.faqModel!.questionAr;
      _textEditingControllerQuestionEn.text = widget.faqModel!.questionEn;
      _textEditingControllerAnswerAr.text = widget.faqModel!.answerAr;
      _textEditingControllerAnswerEn.text = widget.faqModel!.answerEn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditFaqProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.faqModel == null ? StringsManager.addFaq : StringsManager.editFaq),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Question Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerQuestionAr,
                            labelText: '${Methods.getText(StringsManager.question).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Question En *
                          CustomTextFormField(
                            controller: _textEditingControllerQuestionEn,
                            labelText: '${Methods.getText(StringsManager.question).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Answer Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerAnswerAr,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
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
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.answer).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                if(widget.faqModel == null) {
                                  InsertFaqParameters insertFaqParameters = InsertFaqParameters(
                                    questionAr: _textEditingControllerQuestionAr.text.trim(),
                                    questionEn: _textEditingControllerQuestionEn.text.trim(),
                                    answerAr: _textEditingControllerAnswerAr.text.trim(),
                                    answerEn: _textEditingControllerAnswerEn.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditFaqProvider.insertFaq(context: context, insertFaqParameters: insertFaqParameters);
                                }
                                else {
                                  EditFaqParameters editFaqParameters = EditFaqParameters(
                                    faqId: widget.faqModel!.faqId,
                                    questionAr: _textEditingControllerQuestionAr.text.trim(),
                                    questionEn: _textEditingControllerQuestionEn.text.trim(),
                                    answerAr: _textEditingControllerAnswerAr.text.trim(),
                                    answerEn: _textEditingControllerAnswerEn.text.trim(),
                                  );
                                  insertEditFaqProvider.editFaq(context: context, editFaqParameters: editFaqParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.faqModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.faqModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _textEditingControllerQuestionAr.dispose();
    _textEditingControllerQuestionEn.dispose();
    _textEditingControllerAnswerAr.dispose();
    _textEditingControllerAnswerEn.dispose();
  }
}