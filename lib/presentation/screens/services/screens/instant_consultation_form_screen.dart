import 'dart:io';

import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/usecases/instant_consultations/insert_instant_consultation_usecase.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_consultation_form_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class InstantConsultationFormScreen extends StatefulWidget {

  const InstantConsultationFormScreen({super.key});

  @override
  State<InstantConsultationFormScreen> createState() => _InstantConsultationFormScreenState();
}

class _InstantConsultationFormScreenState extends State<InstantConsultationFormScreen> {
  late InstantConsultationFormProvider instantConsultationFormProvider;
  late UserModel currentUser = MyProviders.authenticationProvider.currentUser!;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerName = TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber = TextEditingController();
  final TextEditingController _textEditingControllerEmail = TextEditingController();
  final TextEditingController _textEditingControllerConsultation = TextEditingController();

  @override
  void initState() {
    super.initState();
    instantConsultationFormProvider = Provider.of<InstantConsultationFormProvider>(context, listen: false);

    _textEditingControllerName.text = currentUser.fullName;
    _textEditingControllerPhoneNumber.text = currentUser.phoneNumber ?? '';
    _textEditingControllerEmail.text = currentUser.emailAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InstantConsultationFormProvider>(
        builder: (context, instantConsultationFormProvider, _) {
          return CustomFullLoading(
            isShowLoading: instantConsultationFormProvider.isLoading,
            waitForDone: instantConsultationFormProvider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.instantConsultation),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   '${Methods.getText(StringsManager.name).toCapitalized()} *',
                          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                          // ),
                          // const SizedBox(height: SizeManager.s5),
                          // CustomTextFormField(
                          //   controller: _textEditingControllerName,
                          //   textInputAction: TextInputAction.next,
                          //   borderColor: ColorsManager.grey,
                          //   hintText: Methods.getText(StringsManager.pleaseWriteTheFullName).toCapitalized(),
                          //   prefixIcon: const Icon(Icons.person_outlined, color: ColorsManager.grey),
                          //   suffixIcon: IconButton(
                          //     onPressed: () => _textEditingControllerName.clear(),
                          //     icon: const Icon(Icons.clear, color: ColorsManager.lightPrimaryColor),
                          //   ),
                          //   validator: Validator.validateEmpty,
                          // ),
                          //
                          // const SizedBox(height: SizeManager.s20),
                          //
                          // Text(
                          //   '${Methods.getText(StringsManager.phoneNumber).toCapitalized()} *',
                          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                          // ),
                          // const SizedBox(height: SizeManager.s5),
                          // CustomTextFormField(
                          //   controller: _textEditingControllerPhoneNumber,
                          //   textInputAction: TextInputAction.next,
                          //   keyboardType: TextInputType.phone,
                          //   maxLength: 11,
                          //   borderColor: ColorsManager.grey,
                          //   hintText: Methods.getText(StringsManager.mobileNumberConsistingOf11Digits).toCapitalized(),
                          //   prefixIcon: const Icon(Icons.phone, color: ColorsManager.grey),
                          //   suffixIcon: IconButton(
                          //     onPressed: () => _textEditingControllerPhoneNumber.clear(),
                          //     icon: const Icon(Icons.clear, color: ColorsManager.lightPrimaryColor),
                          //   ),
                          //   validator: Validator.validatePhoneNumber,
                          // ),
                          //
                          // const SizedBox(height: SizeManager.s20),
                          //
                          // Text(
                          //   Methods.getText(StringsManager.emailAddress).toCapitalized(),
                          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                          // ),
                          // const SizedBox(height: SizeManager.s5),
                          // CustomTextFormField(
                          //   controller: _textEditingControllerEmail,
                          //   textInputAction: TextInputAction.next,
                          //   keyboardType: TextInputType.emailAddress,
                          //   borderColor: ColorsManager.grey,
                          //   hintText: Methods.getText(StringsManager.emailAddress).toCapitalized(),
                          //   prefixIcon: const Icon(Icons.email_outlined, color: ColorsManager.grey),
                          //   suffixIcon: IconButton(
                          //     onPressed: () => _textEditingControllerEmail.clear(),
                          //     icon: const Icon(Icons.clear, color: ColorsManager.lightPrimaryColor),
                          //   ),
                          //   validator: Validator.validateEmailAddressAllowEmpty,
                          // ),
                          //
                          // const SizedBox(height: SizeManager.s20),
                          Text(
                            '${Methods.getText(StringsManager.theInstantConsultation).toCapitalized()} *',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          CustomTextFormField(
                            controller: _textEditingControllerConsultation,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            hintText: '${Methods.getText(StringsManager.descriptionOfTheInstantConsultation).toCapitalized()} (${Methods.getText(StringsManager.detailedAndClearExplanation)})',
                            borderRadius: SizeManager.s20,
                            fillColor: ColorsManager.grey100,
                            enabledBorderColor: ColorsManager.grey300,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // images
                          Text(
                            Methods.getText(StringsManager.attachImages).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
                          ),
                          const SizedBox(height: SizeManager.s10),
                          Container(
                            padding: const EdgeInsets.all(SizeManager.s10),
                            decoration: BoxDecoration(
                              color: ColorsManager.grey100,
                              borderRadius: BorderRadius.circular(SizeManager.s10),
                              border: Border.all(color: ColorsManager.grey300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeManager.s100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                                    itemBuilder: (context, index) {
                                      return index == instantConsultationFormProvider.images.length ? Container(
                                        width: SizeManager.s100,
                                        height: SizeManager.s100,
                                        decoration: BoxDecoration(
                                          color: ColorsManager.white,
                                          borderRadius: BorderRadius.circular(SizeManager.s15),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                              if(xFile != null) instantConsultationFormProvider.addInImages(xFile.path);
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
                                            instantConsultationFormProvider.images[index].startsWith(ConstantsManager.fahemImageFromFile) ? Image.file(
                                              File(instantConsultationFormProvider.images[index]),
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              fit: BoxFit.cover,
                                            ) : ImageWidget(
                                              image: instantConsultationFormProvider.images[index],
                                              imageDirectory: ApiConstants.instantConsultationsDirectory,
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
                                                    if(xFile != null) instantConsultationFormProvider.editInImages(image: xFile.path, index: index);
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
                                                  onPressed: () async => instantConsultationFormProvider.removeFromImages(index),
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
                                    itemCount: instantConsultationFormProvider.images.length + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: SizeManager.s50,
                                  padding: const EdgeInsets.all(SizeManager.s10),
                                  decoration: BoxDecoration(
                                    color: ColorsManager.lightPrimaryColor,
                                    border: Border.all(color: ColorsManager.lightPrimaryColor),
                                    borderRadius: const BorderRadiusDirectional.only(
                                      topStart: Radius.circular(SizeManager.s10),
                                      bottomStart: Radius.circular(SizeManager.s10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Methods.getText(StringsManager.serviceCost).toTitleCase(),
                                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.black),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: SizeManager.s50,
                                  padding: const EdgeInsets.all(SizeManager.s10),
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    border: Border.all(color: ColorsManager.lightPrimaryColor),
                                    borderRadius: const BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(SizeManager.s10),
                                      bottomEnd: Radius.circular(SizeManager.s10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${500} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeightManager.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          CustomButton(
                            buttonType: ButtonType.text,
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                InsertInstantConsultationParameters parameters = InsertInstantConsultationParameters(
                                  userId: currentUser.userId,
                                  consultation: _textEditingControllerConsultation.text.trim(),
                                  isDone: false,
                                  bestInstantConsultationCommentId: null,
                                  isViewed: false,
                                  images: [],
                                  createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                );
                                instantConsultationFormProvider.onPressedSendConsultation(context: context, insertInstantConsultationParameters: parameters);
                              }
                            },
                            text: Methods.getText(StringsManager.sendConsultation).toTitleCase(),
                            width: double.infinity,
                            textFontWeight: FontWeightManager.black,
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
    _textEditingControllerName.dispose();
    _textEditingControllerPhoneNumber.dispose();
    _textEditingControllerEmail.dispose();
    _textEditingControllerConsultation.dispose();
    super.dispose();
  }
}