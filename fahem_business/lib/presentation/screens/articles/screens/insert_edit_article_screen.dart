import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/article_model.dart';
import 'package:fahem_business/domain/usecases/articles/edit_article_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/insert_article_usecase.dart';
import 'package:fahem_business/presentation/screens/articles/controllers/insert_edit_article_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditArticleScreen extends StatefulWidget {
  final ArticleModel? articleModel;

  const InsertEditArticleScreen({
    super.key,
    this.articleModel,
  });

  @override
  State<InsertEditArticleScreen> createState() => _InsertEditArticleScreenState();
}

class _InsertEditArticleScreenState extends State<InsertEditArticleScreen> {
  late InsertEditArticleProvider insertEditArticleProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerTitleAr = TextEditingController();
  final TextEditingController _textEditingControllerTitleEn = TextEditingController();
  final TextEditingController _textEditingControllerArticleAr = TextEditingController();
  final TextEditingController _textEditingControllerArticleEn = TextEditingController();
  final TextEditingController _textEditingControllerCustomOrder = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    insertEditArticleProvider = Provider.of<InsertEditArticleProvider>(context, listen: false);

    if(widget.articleModel != null) {
      _textEditingControllerTitleAr.text = widget.articleModel!.titleAr;
      _textEditingControllerTitleEn.text = widget.articleModel!.titleEn;
      _textEditingControllerArticleAr.text = widget.articleModel!.articleAr;
      _textEditingControllerArticleEn.text = widget.articleModel!.articleEn;
      _textEditingControllerCustomOrder.text = widget.articleModel!.customOrder.toString();
      insertEditArticleProvider.setArticleImage(widget.articleModel!.image);
      insertEditArticleProvider.setIsAvailable(widget.articleModel!.isAvailable);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditArticleProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            isShowOpacityBackground: true,
            waitForDone: provider.isLoading,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.articleModel == null ? StringsManager.addArticle : StringsManager.editArticle),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Article Image *
                          SizedBox(
                            width: double.infinity,
                            height: SizeManager.s200,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: SizeManager.s200,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.circular(SizeManager.s10),
                                    border: Border.all(color: ColorsManager.grey300),
                                  ),
                                  child: ImageTypeWidget(
                                    image: provider.articleImage,
                                    imageDirectory: ApiConstants.articlesDirectory,
                                    title: StringsManager.articleImage,
                                    imageFileBorderRadius: SizeManager.s10,
                                    imageNetworkWidth: double.infinity,
                                    imageNetworkHeight: SizeManager.s200,
                                    imageNetworkBorderRadius: SizeManager.s10,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5, vertical: SizeManager.s10),
                                    child: CustomButton(
                                      buttonType: ButtonType.icon,
                                      onPressed: () async {
                                        if(provider.articleImage == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) insertEditArticleProvider.changeArticleImage(xFile);
                                        }
                                        else {
                                          insertEditArticleProvider.changeArticleImage(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.articleImage == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.articleImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),
                          
                          // Title Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerTitleAr,
                            labelText: '${Methods.getText(StringsManager.title).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Title En *
                          CustomTextFormField(
                            controller: _textEditingControllerTitleEn,
                            labelText: '${Methods.getText(StringsManager.title).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
                            prefixIconData: FontAwesomeIcons.solidFile,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Article Ar *
                          CustomTextFormField(
                            controller: _textEditingControllerArticleAr,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.article).toTitleCase()} (${Methods.getText(StringsManager.ar).toTitleCase()}) *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Article En *
                          CustomTextFormField(
                            controller: _textEditingControllerArticleEn,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.article).toTitleCase()} (${Methods.getText(StringsManager.en).toTitleCase()}) *',
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
                          const SizedBox(height: SizeManager.s20),

                          // isAvailable *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.isAvailable,
                              onChanged: (value) => provider.changeIsAvailable(value!),
                              title: Text(
                                Methods.getText(StringsManager.theArticleIsAvailable).toTitleCase(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              tileColor: ColorsManager.white,
                              activeColor: ColorsManager.lightPrimaryColor,
                              checkColor: ColorsManager.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SizeManager.s10),
                                side: const BorderSide(color: ColorsManager.grey300),
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate() && insertEditArticleProvider.isAllDataValid()) {
                                if(widget.articleModel == null) {
                                  InsertArticleParameters insertArticleParameters = InsertArticleParameters(
                                    image: '',
                                    titleAr: _textEditingControllerTitleAr.text.trim(),
                                    titleEn: _textEditingControllerTitleEn.text.trim(),
                                    articleAr: _textEditingControllerArticleAr.text.trim(),
                                    articleEn: _textEditingControllerArticleEn.text.trim(),
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                    isAvailable: provider.isAvailable,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditArticleProvider.insertArticle(context: context, insertArticleParameters: insertArticleParameters);
                                }
                                else {
                                  EditArticleParameters editArticleParameters = EditArticleParameters(
                                    image: insertEditArticleProvider.articleImage is String ? insertEditArticleProvider.articleImage : '',
                                    articleId: widget.articleModel!.articleId,
                                    titleAr: _textEditingControllerTitleAr.text.trim(),
                                    titleEn: _textEditingControllerTitleEn.text.trim(),
                                    articleAr: _textEditingControllerArticleAr.text.trim(),
                                    articleEn: _textEditingControllerArticleEn.text.trim(),
                                    customOrder: int.parse(_textEditingControllerCustomOrder.text.trim()),
                                    isAvailable: provider.isAvailable,
                                  );
                                  insertEditArticleProvider.editArticle(context: context, editArticleParameters: editArticleParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.preIcon,
                            iconData: widget.articleModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.articleModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _textEditingControllerTitleAr.dispose();
    _textEditingControllerTitleEn.dispose();
    _textEditingControllerArticleAr.dispose();
    _textEditingControllerArticleEn.dispose();
  }
}