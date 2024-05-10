import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/presentation/screens/reviews/controllers/insert_edit_review_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/review_model.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/edit_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditReviewScreen extends StatefulWidget {
  final ReviewModel? reviewModel;

  const InsertEditReviewScreen({
    super.key,
    this.reviewModel,
  });

  @override
  State<InsertEditReviewScreen> createState() => _InsertEditReviewScreenState();
}

class _InsertEditReviewScreenState extends State<InsertEditReviewScreen> {
  late InsertEditReviewProvider insertEditReviewProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _featureArController = TextEditingController();
  final TextEditingController _featureEnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditReviewProvider = Provider.of<InsertEditReviewProvider>(context, listen: false);

    if(widget.reviewModel != null) {
      _commentController.text = widget.reviewModel!.comment;
      _ratingController.text = widget.reviewModel!.rating.toInt().toString();
      insertEditReviewProvider.setAccount(widget.reviewModel!.account);
      insertEditReviewProvider.setUser(widget.reviewModel!.user);
      insertEditReviewProvider.setFeaturesAr(widget.reviewModel!.featuresAr);
      insertEditReviewProvider.setFeaturesEn(widget.reviewModel!.featuresEn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditReviewProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.reviewModel == null ? StringsManager.addReview : StringsManager.editReview,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Account *
                          CustomButton(
                            onPressed: () {
                              Dialogs.accountsBottomSheet(context: context).then((account) {
                                if(account != null) {
                                  insertEditReviewProvider.changeAccount(account);
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

                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditReviewProvider.changeUser(user);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.user == null ? Methods.getText(StringsManager.chooseUser).toCapitalized() : provider.user!.fullName,
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.user == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.user == null,
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

                          // Rating *
                          CustomTextFormField(
                            controller: _ratingController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.rating).toTitleCase()} *',
                            hintText: '(1 - 2 - 3 - 4 - 5)',
                            prefixIconData: FontAwesomeIcons.star,
                            validator: (value) => Validator.validateIntegerNumberAllowMax(value, 5),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Features Ar
                          Container(
                            padding: const EdgeInsets.all(SizeManager.s10),
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(SizeManager.s10),
                              border: Border.all(color: ColorsManager.grey300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  controller: _featureArController,
                                  labelText: '${Methods.getText(StringsManager.features).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()})',
                                  prefixIconData: Icons.task_alt,
                                  fillColor: ColorsManager.grey100,
                                  suffixIcon: CustomButton(
                                    onPressed: () async {
                                      insertEditReviewProvider.addInFeaturesAr(_featureArController.text.trim());
                                      _featureArController.clear();
                                    },
                                    buttonColor: Colors.transparent,
                                    textColor: ColorsManager.lightPrimaryColor,
                                    buttonType: ButtonType.text,
                                    text: Methods.getText(StringsManager.add).toCapitalized(),
                                  ),
                                  isSupportClearSuffixIcon: false,
                                  // validator: (value) {
                                  //   if(insertEditReviewProvider.featuresAr.isEmpty) {
                                  //     return Methods.getText(StringsManager.required).toCapitalized();
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: SizeManager.s10),
                                Wrap(
                                  spacing: SizeManager.s5,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(insertEditReviewProvider.featuresAr.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        insertEditReviewProvider.removeFromFeaturesAr(insertEditReviewProvider.featuresAr[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(SizeManager.s5),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.lightPrimaryColor,
                                          border: Border.all(color: ColorsManager.lightPrimaryColor),
                                          borderRadius: BorderRadius.circular(SizeManager.s5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              insertEditReviewProvider.featuresAr[index],
                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white),
                                            ),
                                            const SizedBox(width: SizeManager.s10),
                                            const Icon(Icons.clear, size: SizeManager.s14, color: ColorsManager.white),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Features En
                          Container(
                            padding: const EdgeInsets.all(SizeManager.s10),
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(SizeManager.s10),
                              border: Border.all(color: ColorsManager.grey300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  controller: _featureEnController,
                                  labelText: '${Methods.getText(StringsManager.features).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()})',
                                  prefixIconData: Icons.task_alt,
                                  fillColor: ColorsManager.grey100,
                                  suffixIcon: CustomButton(
                                    onPressed: () async {
                                      insertEditReviewProvider.addInFeaturesEn(_featureEnController.text.trim());
                                      _featureEnController.clear();
                                    },
                                    buttonColor: Colors.transparent,
                                    textColor: ColorsManager.lightPrimaryColor,
                                    buttonType: ButtonType.text,
                                    text: Methods.getText(StringsManager.add).toCapitalized(),
                                  ),
                                  isSupportClearSuffixIcon: false,
                                  // validator: (value) {
                                  //   if(insertEditReviewProvider.featuresEn.isEmpty) {
                                  //     return Methods.getText(StringsManager.required).toCapitalized();
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: SizeManager.s10),
                                Wrap(
                                  spacing: SizeManager.s5,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(insertEditReviewProvider.featuresEn.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        insertEditReviewProvider.removeFromFeaturesEn(insertEditReviewProvider.featuresEn[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(SizeManager.s5),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.lightPrimaryColor,
                                          border: Border.all(color: ColorsManager.lightPrimaryColor),
                                          borderRadius: BorderRadius.circular(SizeManager.s5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              insertEditReviewProvider.featuresEn[index],
                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white),
                                            ),
                                            const SizedBox(width: SizeManager.s10),
                                            const Icon(Icons.clear, size: SizeManager.s14, color: ColorsManager.white),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditReviewProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.reviewModel == null) {
                                  InsertReviewParameters insertReviewParameters = InsertReviewParameters(
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    comment: _commentController.text.trim(),
                                    rating: double.parse(_ratingController.text.trim()),
                                    featuresAr: insertEditReviewProvider.featuresAr,
                                    featuresEn: insertEditReviewProvider.featuresEn,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditReviewProvider.insertReview(context: context, insertReviewParameters: insertReviewParameters);
                                }
                                else {
                                  EditReviewParameters editReviewParameters = EditReviewParameters(
                                    reviewId: widget.reviewModel!.reviewId,
                                    accountId: provider.account!.accountId,
                                    userId: provider.user!.userId,
                                    comment: _commentController.text.trim(),
                                    rating: double.parse(_ratingController.text.trim()),
                                    featuresAr: insertEditReviewProvider.featuresAr,
                                    featuresEn: insertEditReviewProvider.featuresEn,
                                  );
                                  insertEditReviewProvider.editReview(context: context, editReviewParameters: editReviewParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.reviewModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.reviewModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _ratingController.dispose();
    _featureArController.dispose();
    _featureEnController.dispose();
    super.dispose();
  }
}