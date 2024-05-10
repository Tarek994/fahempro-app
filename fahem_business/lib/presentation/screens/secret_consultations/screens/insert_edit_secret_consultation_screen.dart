import 'dart:io';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/presentation/screens/secret_consultations/controllers/insert_edit_secret_consultation_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/secret_consultation_model.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/edit_secret_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/insert_secret_consultation_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditSecretConsultationScreen extends StatefulWidget {
  final SecretConsultationModel? secretConsultationModel;

  const InsertEditSecretConsultationScreen({
    super.key,
    this.secretConsultationModel,
  });

  @override
  State<InsertEditSecretConsultationScreen> createState() => _InsertEditSecretConsultationScreenState();
}

class _InsertEditSecretConsultationScreenState extends State<InsertEditSecretConsultationScreen> {
  late InsertEditSecretConsultationProvider insertEditSecretConsultationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _consultationController = TextEditingController();
  final TextEditingController _replyTypeValueController = TextEditingController();
  SecretConsultationReplyType? _secretConsultationReplyType;

  @override
  void initState() {
    super.initState();
    insertEditSecretConsultationProvider = Provider.of<InsertEditSecretConsultationProvider>(context, listen: false);

    if(widget.secretConsultationModel != null) {
      _consultationController.text = widget.secretConsultationModel!.consultation;
      _replyTypeValueController.text = widget.secretConsultationModel!.replyTypeValue;
      insertEditSecretConsultationProvider.setUser(widget.secretConsultationModel!.user);
      insertEditSecretConsultationProvider.setImages(widget.secretConsultationModel!.images);
      insertEditSecretConsultationProvider.setIsReplied(widget.secretConsultationModel!.isReplied);
      _secretConsultationReplyType = widget.secretConsultationModel!.secretConsultationReplyType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditSecretConsultationProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(
                  title: widget.secretConsultationModel == null ? StringsManager.addSecretConsultation : StringsManager.editSecretConsultation,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // User *
                          CustomButton(
                            onPressed: () {
                              Dialogs.usersBottomSheet(context: context).then((user) {
                                if(user != null) {
                                  insertEditSecretConsultationProvider.changeUser(user);
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

                          // Consultation *
                          CustomTextFormField(
                            controller: _consultationController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: '${Methods.getText(StringsManager.consultation).toTitleCase()} *',
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // images
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8),
                                  child: Text(
                                    Methods.getText(StringsManager.attachImages).toCapitalized(),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                                  ),
                                ),
                                const SizedBox(height: SizeManager.s20),
                                SizedBox(
                                  height: SizeManager.s100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                                    itemBuilder: (context, index) {
                                      return index == provider.images.length ? Container(
                                        width: SizeManager.s100,
                                        height: SizeManager.s100,
                                        decoration: BoxDecoration(
                                          color: ColorsManager.grey100,
                                          borderRadius: BorderRadius.circular(SizeManager.s15),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                              if(xFile != null) provider.addInImages(xFile.path);
                                            },
                                            borderRadius: BorderRadius.circular(SizeManager.s15),
                                            child: const Icon(Icons.add, size: SizeManager.s30, color: ColorsManager.black),
                                          ),
                                        ),
                                      ) : Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: SizeManager.s100,
                                        height: SizeManager.s100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(SizeManager.s15),
                                        ),
                                        child: Stack(
                                          children: [
                                            provider.images[index].startsWith(ConstantsManager.fahemBusinessImageFromFile) ? Image.file(
                                              File(provider.images[index]),
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              fit: BoxFit.cover,
                                            ) : ImageWidget(
                                              image: provider.images[index],
                                              imageDirectory: ApiConstants.secretConsultationsDirectory,
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              isShowFullImageScreen: true,
                                            ),
                                            PositionedDirectional(
                                              top: SizeManager.s0,
                                              start: SizeManager.s0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(SizeManager.s5),
                                                child: CustomButton(
                                                  onPressed: () async {
                                                    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                    if(xFile != null) provider.editInImages(image: xFile.path, index: index);
                                                  },
                                                  buttonType: ButtonType.icon,
                                                  iconData: Icons.edit,
                                                  width: SizeManager.s30,
                                                  height: SizeManager.s30,
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: SizeManager.s0,
                                              end: SizeManager.s0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(SizeManager.s5),
                                                child: CustomButton(
                                                  onPressed: () async => provider.removeFromImages(index),
                                                  buttonType: ButtonType.icon,
                                                  iconData: Icons.delete,
                                                  width: SizeManager.s30,
                                                  height: SizeManager.s30,
                                                  padding: EdgeInsets.zero,
                                                  buttonColor: ColorsManager.red700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: provider.images.length + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // isReplied *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.isReplied,
                              onChanged: (value) => provider.changeIsReplied(value!),
                              title: Text(
                                Methods.getText(StringsManager.theConsultationHasBeenReplied).toTitleCase(),
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
                          const SizedBox(height: SizeManager.s20),

                          // secretConsultationReplyType *
                          CustomDropdownButtonFormField(
                            currentValue: _secretConsultationReplyType,
                            valuesText: List.generate(SecretConsultationReplyType.values.length, (index) => SecretConsultationReplyType.toText(SecretConsultationReplyType.values[index])),
                            valuesObject: SecretConsultationReplyType.values,
                            onChanged: (value) => setState(() => _secretConsultationReplyType = value as SecretConsultationReplyType),
                            labelText: '${Methods.getText(StringsManager.replyToTheConsultationThrough).toCapitalized()} *',
                            prefixIconData: FontAwesomeIcons.comment,
                            suffixIcon: _secretConsultationReplyType == null ? const Icon(
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
                                  setState(() => _secretConsultationReplyType = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // replyTypeValue *
                          CustomTextFormField(
                            controller: _replyTypeValueController,
                            keyboardType: TextInputType.phone,
                            labelText: '${Methods.getText(StringsManager.phoneNumber).toTitleCase()} *',
                            prefixIconData: Icons.phone,
                            validator: Validator.validatePhoneNumber,
                          ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditSecretConsultationProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                if(widget.secretConsultationModel == null) {
                                  InsertSecretConsultationParameters insertSecretConsultationParameters = InsertSecretConsultationParameters(
                                    userId: provider.user!.userId,
                                    consultation: _consultationController.text.trim(),
                                    isViewed: false,
                                    isReplied: provider.isReplied,
                                    secretConsultationReplyType: _secretConsultationReplyType!,
                                    replyTypeValue: _replyTypeValueController.text.trim(),
                                    images: [],
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditSecretConsultationProvider.insertSecretConsultation(context: context, insertSecretConsultationParameters: insertSecretConsultationParameters);
                                }
                                else {
                                  EditSecretConsultationParameters editSecretConsultationParameters = EditSecretConsultationParameters(
                                    secretConsultationId: widget.secretConsultationModel!.secretConsultationId,
                                    userId: provider.user!.userId,
                                    consultation: _consultationController.text.trim(),
                                    isViewed: widget.secretConsultationModel!.isViewed,
                                    isReplied: provider.isReplied,
                                    secretConsultationReplyType: _secretConsultationReplyType!,
                                    replyTypeValue: _replyTypeValueController.text.trim(),
                                    images: widget.secretConsultationModel!.images,
                                  );
                                  insertEditSecretConsultationProvider.editSecretConsultation(context: context, editSecretConsultationParameters: editSecretConsultationParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.secretConsultationModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.secretConsultationModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _consultationController.dispose();
    _replyTypeValueController.dispose();
    super.dispose();
  }
}