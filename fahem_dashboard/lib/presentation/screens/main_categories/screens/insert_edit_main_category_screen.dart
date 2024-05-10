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
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/edit_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/insert_main_category_usecase.dart';
import 'package:fahem_dashboard/presentation/screens/main_categories/controllers/insert_edit_main_category_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditMainCategoryScreen extends StatefulWidget {
  final MainCategoryModel? mainCategoryModel;

  const InsertEditMainCategoryScreen({
    super.key,
    this.mainCategoryModel,
  });

  @override
  State<InsertEditMainCategoryScreen> createState() => _InsertEditMainCategoryScreenState();
}

class _InsertEditMainCategoryScreenState extends State<InsertEditMainCategoryScreen> {
  late InsertEditMainCategoryProvider insertEditMainCategoryProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerNameAr = TextEditingController();
  final TextEditingController _textEditingControllerNameEn = TextEditingController();
  final TextEditingController _textEditingControllerCustomOrder = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    insertEditMainCategoryProvider = Provider.of<InsertEditMainCategoryProvider>(context, listen: false);

    if(widget.mainCategoryModel != null) {
      _textEditingControllerNameAr.text = widget.mainCategoryModel!.nameAr;
      _textEditingControllerNameEn.text = widget.mainCategoryModel!.nameEn;
      _textEditingControllerCustomOrder.text = widget.mainCategoryModel!.customOrder.toString();
      insertEditMainCategoryProvider.setMainCategoryImage(widget.mainCategoryModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditMainCategoryProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.mainCategoryModel == null ? StringsManager.addMainCategory : StringsManager.editMainCategory),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // MainCategory Image *
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
                                    image: provider.mainCategoryImage,
                                    imageDirectory: ApiConstants.mainCategoriesDirectory,
                                    title: StringsManager.image,
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
                                      if(provider.mainCategoryImage == null) {
                                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(xFile != null) insertEditMainCategoryProvider.changeMainCategoryImage(xFile);
                                      }
                                      else {
                                        insertEditMainCategoryProvider.changeMainCategoryImage(null);
                                      }
                                    },
                                    isCircleBorder: true,
                                    iconData: provider.mainCategoryImage == null ? Icons.image : Icons.clear,
                                    buttonColor: provider.mainCategoryImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                    iconSize: SizeManager.s20,
                                    width: SizeManager.s35,
                                    height: SizeManager.s35,
                                  ),
                                ),
                              ],
                            ),
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
                              if(_formKey.currentState!.validate() && insertEditMainCategoryProvider.isAllDataValid()) {
                                if(widget.mainCategoryModel == null) {
                                  InsertMainCategoryParameters insertMainCategoryParameters = InsertMainCategoryParameters(
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    image: '',
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditMainCategoryProvider.insertMainCategory(context: context, insertMainCategoryParameters: insertMainCategoryParameters);
                                }
                                else {
                                  EditMainCategoryParameters editMainCategoryParameters = EditMainCategoryParameters(
                                    mainCategoryId: widget.mainCategoryModel!.mainCategoryId,
                                    nameAr: _textEditingControllerNameAr.text.trim(),
                                    nameEn: _textEditingControllerNameEn.text.trim(),
                                    image: insertEditMainCategoryProvider.mainCategoryImage is String ? insertEditMainCategoryProvider.mainCategoryImage : '',
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                  );
                                  insertEditMainCategoryProvider.editMainCategory(context: context, editMainCategoryParameters: editMainCategoryParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.mainCategoryModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.mainCategoryModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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