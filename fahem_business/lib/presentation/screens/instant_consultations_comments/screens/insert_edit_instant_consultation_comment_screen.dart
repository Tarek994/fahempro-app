import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/instant_consultations_comments/controllers/insert_edit_instant_consultation_comment_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/edit_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/insert_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditInstantConsultationCommentScreen extends StatefulWidget {
  final InstantConsultationCommentModel? instantConsultationCommentModel;

  const InsertEditInstantConsultationCommentScreen({
    super.key,
    this.instantConsultationCommentModel,
  });

  @override
  State<InsertEditInstantConsultationCommentScreen> createState() => _InsertEditInstantConsultationCommentScreenState();
}

class _InsertEditInstantConsultationCommentScreenState extends State<InsertEditInstantConsultationCommentScreen> {
  late InsertEditInstantConsultationCommentProvider insertEditInstantConsultationCommentProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _reasonOfRejectController = TextEditingController();
  CommentStatus? _commentStatus;

  @override
  void initState() {
    super.initState();
    insertEditInstantConsultationCommentProvider = Provider.of<InsertEditInstantConsultationCommentProvider>(context, listen: false);

    if(widget.instantConsultationCommentModel != null) {
      _commentController.text = widget.instantConsultationCommentModel!.comment;
      _reasonOfRejectController.text = widget.instantConsultationCommentModel!.reasonOfReject ?? '';
      _commentStatus = widget.instantConsultationCommentModel!.commentStatus;
      insertEditInstantConsultationCommentProvider.setInstantConsultation(widget.instantConsultationCommentModel!.instantConsultation);
      insertEditInstantConsultationCommentProvider.setAccount(widget.instantConsultationCommentModel!.account);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditInstantConsultationCommentProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.instantConsultationCommentModel == null ? StringsManager.addComment : StringsManager.editComment,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // instantConsultation *
                          CustomButton(
                            onPressed: () {
                              Dialogs.instantConsultationsBottomSheet(context: context).then((instantConsultation) {
                                if(instantConsultation != null) {
                                  insertEditInstantConsultationCommentProvider.changeInstantConsultation(instantConsultation);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.instantConsultation == null
                                ? Methods.getText(StringsManager.chooseInstantConsultation).toCapitalized()
                                : '#${provider.instantConsultation!.instantConsultationId}',
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.instantConsultation == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.instantConsultation == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Account *
                          CustomButton(
                            onPressed: () {
                              Dialogs.accountsBottomSheet(context: context).then((account) {
                                if(account != null) {
                                  insertEditInstantConsultationCommentProvider.changeAccount(account);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.account == null ? Methods.getText(StringsManager.chooseAccount).toCapitalized() : provider.account!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.account == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.account == null,
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
                          const SizedBox(height: SizeManager.s20),

                          // Comment Status *
                          CustomDropdownButtonFormField(
                            currentValue: _commentStatus,
                            valuesText: List.generate(CommentStatus.values.length, (index) => CommentStatus.toText(CommentStatus.values[index])),
                            valuesObject: CommentStatus.values,
                            onChanged: (value) => setState(() => _commentStatus = value as CommentStatus),
                            labelText: '${Methods.getText(StringsManager.commentStatus).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.gear,
                            suffixIcon: _commentStatus == null ? const Icon(
                              Icons.arrow_drop_down,
                              size: SizeManager.s20,
                              color: ColorsManager.grey,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _commentStatus = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Reason Of Reject *
                          if(_commentStatus == CommentStatus.rejected) ...[
                            CustomTextFormField(
                              controller: _reasonOfRejectController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 2,
                              borderRadius: SizeManager.s10,
                              labelText: '${Methods.getText(StringsManager.reasonOfReject).toTitleCase()} *',
                              validator: Validator.validateEmpty,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditInstantConsultationCommentProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.instantConsultationCommentModel == null) {
                                  InsertInstantConsultationCommentParameters insertInstantConsultationCommentParameters = InsertInstantConsultationCommentParameters(
                                    instantConsultationId: provider.instantConsultation!.instantConsultationId,
                                    accountId: provider.account!.accountId,
                                    comment: _commentController.text.trim(),
                                    commentStatus: _commentStatus!,
                                    reasonOfReject: _commentStatus == CommentStatus.rejected ? _reasonOfRejectController.text.trim() : null,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditInstantConsultationCommentProvider.insertInstantConsultationComment(context: context, insertInstantConsultationCommentParameters: insertInstantConsultationCommentParameters);
                                }
                                else {
                                  EditInstantConsultationCommentParameters editInstantConsultationCommentParameters = EditInstantConsultationCommentParameters(
                                    instantConsultationCommentId: widget.instantConsultationCommentModel!.instantConsultationCommentId,
                                    instantConsultationId: provider.instantConsultation!.instantConsultationId,
                                    accountId: provider.account!.accountId,
                                    comment: _commentController.text.trim(),
                                    commentStatus: _commentStatus!,
                                    reasonOfReject: _commentStatus == CommentStatus.rejected ? _reasonOfRejectController.text.trim() : null,
                                  );
                                  insertEditInstantConsultationCommentProvider.editInstantConsultationComment(context: context, editInstantConsultationCommentParameters: editInstantConsultationCommentParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.instantConsultationCommentModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.instantConsultationCommentModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _reasonOfRejectController.dispose();
    super.dispose();
  }
}