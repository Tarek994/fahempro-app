import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/insert_category_usecase.dart';
import 'package:fahem_dashboard/presentation/screens/categories/controllers/insert_edit_category_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditCategoryScreen extends StatefulWidget {
  final CategoryModel? categoryModel;

  const InsertEditCategoryScreen({
    super.key,
    this.categoryModel,
  });

  @override
  State<InsertEditCategoryScreen> createState() => _InsertEditCategoryScreenState();
}

class _InsertEditCategoryScreenState extends State<InsertEditCategoryScreen> {
  late InsertEditCategoryProvider insertEditCategoryProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerNameAr = TextEditingController();
  final TextEditingController _textEditingControllerNameEn = TextEditingController();
  final TextEditingController _textEditingControllerCustomOrder = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    insertEditCategoryProvider = Provider.of<InsertEditCategoryProvider>(context, listen: false);

    if(widget.categoryModel != null) {
      _textEditingControllerNameAr.text = widget.categoryModel!.nameAr;
      _textEditingControllerNameEn.text = widget.categoryModel!.nameEn;
      _textEditingControllerCustomOrder.text = widget.categoryModel!.customOrder.toString();
      insertEditCategoryProvider.setCategoryImage(widget.categoryModel!.image);
      insertEditCategoryProvider.setMainCategory(widget.categoryModel!.mainCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditCategoryProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.categoryModel == null ? StringsManager.addCategory : StringsManager.editCategory),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Category Image *
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
                                    image: provider.categoryImage,
                                    imageDirectory: ApiConstants.categoriesDirectory,
                                    title: StringsManager.categoryImage,
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
                                      if(provider.categoryImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditCategoryProvider.changeCategoryImage(xFile);
                                      }
                                      else {
                                        insertEditCategoryProvider.changeCategoryImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.categoryImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.categoryImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Main Category *
                          CustomButton(
                            onPressed: () {
                              Dialogs.mainCategoriesBottomSheet(context: context).then((mainCategory) {
                                if(mainCategory != null) {
                                  insertEditCategoryProvider.changeMainCategory(mainCategory);
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

                          // Name Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerNameAr,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: Icons.category,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Name En *
                          CustomTextFormField(
                            controller: _textEditingControllerNameEn,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: Icons.category,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Custom Order
                          CustomTextFormField(
                            controller: _textEditingControllerCustomOrder,
                            keyboardType: TextInputType.number,
                            labelText: Methods.getText(StringsManager.customOrder).toTitleCase(),
                            prefixIconData: Icons.sort_by_alpha,
                            validator: Validator.validateIntegerNumberAllowEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              provider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && insertEditCategoryProvider.isAllDataValid()) {
                                if(widget.categoryModel == null) {
                                  InsertCategoryParameters insertCategoryParameters = InsertCategoryParameters(
                                    mainCategoryId: insertEditCategoryProvider.mainCategory!.mainCategoryId,
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    image: '',
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditCategoryProvider.insertCategory(context: context, insertCategoryParameters: insertCategoryParameters);
                                }
                                else {
                                  EditCategoryParameters editCategoryParameters = EditCategoryParameters(
                                    categoryId: widget.categoryModel!.categoryId,
                                    mainCategoryId: insertEditCategoryProvider.mainCategory!.mainCategoryId,
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    image: insertEditCategoryProvider.categoryImage is String ? insertEditCategoryProvider.categoryImage : '',
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                  );
                                  insertEditCategoryProvider.editCategory(context: context, editCategoryParameters: editCategoryParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.categoryModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.categoryModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
  }
}