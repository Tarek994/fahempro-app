import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/screens/features/controllers/insert_edit_feature_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/feature_model.dart';
import 'package:fahem_business/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_business/domain/usecases/features/insert_feature_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditFeatureScreen extends StatefulWidget {
  final FeatureModel? featureModel;

  const InsertEditFeatureScreen({
    super.key,
    this.featureModel,
  });

  @override
  State<InsertEditFeatureScreen> createState() => _InsertEditFeatureScreenState();
}

class _InsertEditFeatureScreenState extends State<InsertEditFeatureScreen> {
  late InsertEditFeatureProvider insertEditFeatureProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _featureArController = TextEditingController();
  final TextEditingController _featureEnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertEditFeatureProvider = Provider.of<InsertEditFeatureProvider>(context, listen: false);

    if(widget.featureModel != null) {
      _featureArController.text = widget.featureModel!.featureAr;
      _featureEnController.text = widget.featureModel!.featureEn;
      insertEditFeatureProvider.setMainCategory(widget.featureModel!.mainCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditFeatureProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.featureModel == null ? StringsManager.addFeature : StringsManager.editFeature,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Main Category *
                          CustomButton(
                            onPressed: () {
                              Dialogs.mainCategoriesBottomSheet(context: context).then((mainCategory) {
                                if(mainCategory != null) {
                                  provider.changeMainCategory(mainCategory);
                                }
                              });
                            },
                            buttonType: ButtonType.postSpacerText,
                            text: provider.mainCategory == null
                                ? '${Methods.getText(StringsManager.chooseMainCategory).toCapitalized()} *'
                                : (MyProviders.appProvider.isEnglish ? provider.mainCategory!.nameEn : provider.mainCategory!.nameAr),
                            width: double.infinity,
                            buttonColor: ColorsManager.white,
                            borderColor: ColorsManager.grey300,
                            textColor: provider.mainCategory == null ? ColorsManager.grey : ColorsManager.black,
                            fontSize: SizeManager.s12,
                            isRequired: provider.isButtonClicked && provider.mainCategory == null,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Feature Ar *
                          CustomTextFormField(
                            controller: _featureArController,
                            labelText: '${Methods.getText(StringsManager.feature).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: Icons.task_alt,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Feature En *
                          CustomTextFormField(
                            controller: _featureEnController,
                            labelText: '${Methods.getText(StringsManager.feature).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: Icons.task_alt,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditFeatureProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.featureModel == null) {
                                  InsertFeatureParameters insertFeatureParameters = InsertFeatureParameters(
                                    mainCategoryId: provider.mainCategory!.mainCategoryId,
                                    featureAr: _featureArController.text.trim(),
                                    featureEn: _featureEnController.text.trim(),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditFeatureProvider.insertFeature(context: context, insertFeatureParameters: insertFeatureParameters);
                                }
                                else {
                                  EditFeatureParameters editFeatureParameters = EditFeatureParameters(
                                    featureId: widget.featureModel!.featureId,
                                    mainCategoryId: provider.mainCategory!.mainCategoryId,
                                    featureAr: _featureArController.text.trim(),
                                    featureEn: _featureEnController.text.trim(),
                                  );
                                  insertEditFeatureProvider.editFeature(context: context, editFeatureParameters: editFeatureParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.featureModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.featureModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _featureArController.dispose();
    _featureEnController.dispose();
    super.dispose();
  }
}