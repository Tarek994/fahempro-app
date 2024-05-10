import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/screens/admins/controllers/insert_edit_admin_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_container_decoration.dart';
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
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/data/models/admin_model.dart';
import 'package:fahem_business/domain/usecases/admins/edit_admin_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/insert_admin_usecase.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditAdminScreen extends StatefulWidget {
  final AdminModel? adminModel;

  const InsertEditAdminScreen({
    super.key,
    this.adminModel,
  });

  @override
  State<InsertEditAdminScreen> createState() => _InsertEditAdminScreenState();
}

class _InsertEditAdminScreenState extends State<InsertEditAdminScreen> {
  late InsertEditAdminProvider insertEditAdminProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerFullName = TextEditingController();
  final TextEditingController _textEditingControllerEmailAddress = TextEditingController();
  final TextEditingController _textEditingControllerPassword = TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber = TextEditingController();
  final TextEditingController _textEditingControllerBio = TextEditingController();
  Gender? _gender;

  @override
  void initState() {
    super.initState();
    insertEditAdminProvider = Provider.of<InsertEditAdminProvider>(context, listen: false);

    if(widget.adminModel != null) {
      _textEditingControllerFullName.text = widget.adminModel!.fullName;
      _textEditingControllerEmailAddress.text = widget.adminModel!.emailAddress;
      _textEditingControllerPassword.text = widget.adminModel!.password;
      _textEditingControllerPhoneNumber.text = widget.adminModel!.phoneNumber ?? '';
      _textEditingControllerBio.text = widget.adminModel!.bio ?? '';
      _gender = widget.adminModel!.gender;
      insertEditAdminProvider.setPersonalImage(widget.adminModel!.personalImage);
      insertEditAdminProvider.setCoverImage(widget.adminModel!.coverImage);
      if(widget.adminModel!.birthDate != null) insertEditAdminProvider.setBirthDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.adminModel!.birthDate!)));
      insertEditAdminProvider.setSelectedPermissions(List.generate(widget.adminModel!.permissions.length, (index) => AdminPermissions.values.firstWhere((element) => element == widget.adminModel!.permissions[index])).toList());
      insertEditAdminProvider.setIsSuper(widget.adminModel!.isSuper);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditAdminProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.adminModel == null ? StringsManager.addAdmin : StringsManager.editAdmin),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Images
                          SizedBox(
                            width: double.infinity,
                            height: SizeManager.s260,
                            child: Stack(
                              children: [
                                // Cover Image
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
                                          image: provider.coverImage,
                                          imageDirectory: ApiConstants.adminsDirectory,
                                          defaultImage: ImagesManager.defaultAvatar,
                                          title: StringsManager.coverImage,
                                          imageFileBorderRadius: SizeManager.s10,
                                          imageNetworkWidth: SizeManager.s200,
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
                                              if(provider.coverImage == null) {
                                                XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                if(xFile != null) insertEditAdminProvider.changeCoverImage(xFile);
                                              }
                                              else {
                                                insertEditAdminProvider.changeCoverImage(null);
                                              }
                                            },
                                            isCircleBorder: true,
                                            iconData: provider.coverImage == null ? Icons.image : Icons.clear,
                                            buttonColor: provider.coverImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                            iconSize: SizeManager.s20,
                                            width: SizeManager.s35,
                                            height: SizeManager.s35,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Personal Image
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: SizedBox(
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
                                            image: provider.personalImage,
                                            imageDirectory: ApiConstants.adminsDirectory,
                                            defaultImage: ImagesManager.defaultAvatar,
                                            title: StringsManager.personalImage,
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
                                              if(provider.personalImage == null) {
                                                XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                if(xFile != null) insertEditAdminProvider.changePersonalImage(xFile);
                                              }
                                              else {
                                                insertEditAdminProvider.changePersonalImage(null);
                                              }
                                            },
                                            isCircleBorder: true,
                                            iconData: provider.personalImage == null ? Icons.image : Icons.clear,
                                            buttonColor: provider.personalImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                            iconSize: SizeManager.s20,
                                            width: SizeManager.s35,
                                            height: SizeManager.s35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          // Data (Mandatory)
                          CustomContainerDecoration(
                            title: '${Methods.getText(StringsManager.data).toCapitalized()} (${Methods.getText(StringsManager.mandatory).toCapitalized()})',
                            child: Padding(
                              padding: const EdgeInsets.all(SizeManager.s15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // Full Name *
                                  CustomTextFormField(
                                    controller: _textEditingControllerFullName,
                                    labelText: '${Methods.getText(StringsManager.name).toTitleCase()} *',
                                    prefixIconData: Icons.person_2_outlined,
                                    validator: Validator.validateEmpty,
                                  ),
                                  const SizedBox(height: SizeManager.s20),

                                  // Email Address *
                                  CustomTextFormField(
                                    controller: _textEditingControllerEmailAddress,
                                    keyboardType: TextInputType.emailAddress,
                                    labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} *',
                                    prefixIconData: Icons.email_outlined,
                                    validator: Validator.validateEmailAddress,
                                  ),
                                  const SizedBox(height: SizeManager.s20),


                                  // Password *
                                  CustomTextFormField(
                                    isPasswordField: true,
                                    controller: _textEditingControllerPassword,
                                    labelText: '${Methods.getText(StringsManager.password).toTitleCase()} *',
                                    prefixIconData: Icons.lock_outline, 
                                    validator: Validator.validatePasswordLength,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Data (Optional)
                          CustomContainerDecoration(
                            title: '${Methods.getText(StringsManager.data).toCapitalized()} (${Methods.getText(StringsManager.optional).toCapitalized()})',
                            child: Padding(
                              padding: const EdgeInsets.all(SizeManager.s15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // Phone Number
                                  CustomTextFormField(
                                    controller: _textEditingControllerPhoneNumber,
                                    keyboardType: TextInputType.phone,
                                    labelText: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                                    maxLength: 11,
                                    prefixIconData: Icons.phone,
                                    validator: Validator.validatePhoneNumberAllowEmpty,
                                  ),
                                  const SizedBox(height: SizeManager.s20),

                                  // Gender
                                  CustomDropdownButtonFormField(
                                    currentValue: _gender,
                                    valuesText: List.generate(Gender.values.length, (index) => Gender.toText(Gender.values[index])),
                                    valuesObject: Gender.values,
                                    onChanged: (value) => setState(() => _gender = value as Gender),
                                    labelText: Methods.getText(StringsManager.gender).toCapitalized(),
                                    prefixIconData: FontAwesomeIcons.venusMars,
                                    suffixIcon: _gender == null ? const Icon(
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
                                          setState(() => _gender = null);
                                        },
                                        icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: SizeManager.s20),

                                  // Birth Date
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CustomButton(
                                        buttonType: ButtonType.preIconPostClickableIcon,
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          insertEditAdminProvider.onPressedBirthDate(context);
                                        },
                                        text: provider.birthDate == null
                                            ? Methods.getText(StringsManager.birthDate).toCapitalized()
                                            : Methods.formatDate(milliseconds: provider.birthDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                                        iconData: FontAwesomeIcons.calendar,
                                        postClickableIconData: provider.birthDate == null ? null : Icons.clear,
                                        onPressedPostClickableIcon: provider.birthDate == null ? null : () {
                                          FocusScope.of(context).unfocus();
                                          insertEditAdminProvider.changeBirthDate(null);
                                        },
                                        padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                        width: double.infinity,
                                        buttonColor: ColorsManager.white,
                                        borderColor: ColorsManager.grey300,
                                        iconColor: ColorsManager.grey,
                                        textColor: provider.birthDate == null ? ColorsManager.grey : ColorsManager.black,
                                        fontSize: SizeManager.s12,
                                      ),
                                      if(provider.birthDate != null) PositionedDirectional(
                                        start: 36,
                                        top: -5,
                                        child: Text(
                                          Methods.getText(StringsManager.birthDate).toCapitalized(),
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: SizeManager.s20),

                                  // Bio
                                  CustomTextFormField(
                                    controller: _textEditingControllerBio,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    maxLines: 5,
                                    borderRadius: SizeManager.s20,
                                    labelText: Methods.getText(StringsManager.bio).toTitleCase(),
                                  ),
                                  const SizedBox(height: SizeManager.s20),

                                  // Is Super *
                                  Material(
                                    color: Colors.transparent,
                                    child: CheckboxListTile(
                                      value: provider.isSuper,
                                      onChanged: (value) => provider.changeIsSuper(value!),
                                      title: Text(
                                        Methods.getText(StringsManager.allowAllPermissions).toTitleCase(),
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

                                  // Permissions *
                                  if(!provider.isSuper) ...[
                                    const SizedBox(height: SizeManager.s20),
                                    Container(
                                      padding: const EdgeInsets.all(SizeManager.s10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorsManager.white,
                                        borderRadius: BorderRadius.circular(SizeManager.s10),
                                        border: Border.all(color: ColorsManager.grey300),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(FontAwesomeIcons.userLock, size: SizeManager.s12, color: ColorsManager.grey),
                                              const SizedBox(width: SizeManager.s10),
                                              Flexible(
                                                child: Text(
                                                  '${Methods.getText(StringsManager.chooseAdminPermissions).toCapitalized()} *',
                                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: SizeManager.s20),
                                          Wrap(
                                            spacing: SizeManager.s10,
                                            runSpacing: SizeManager.s10,
                                            children: List.generate(AdminPermissions.values.length, (index) {
                                              bool isSelected = insertEditAdminProvider.selectedPermissions.indexWhere((element) => element == AdminPermissions.values[index]) != -1;
                                              return InkWell(
                                                onTap: () {
                                                  FocusScope.of(context).unfocus();
                                                  insertEditAdminProvider.toggleSelectedPermission(AdminPermissions.values[index]);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(SizeManager.s5),
                                                  decoration: BoxDecoration(
                                                    color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey100,
                                                    border: Border.all(color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey300),
                                                    borderRadius: BorderRadius.circular(SizeManager.s5),
                                                  ),
                                                  child: Text(
                                                    MyProviders.appProvider.isEnglish ? AdminPermissions.values[index].nameEn : AdminPermissions.values[index].nameAr,
                                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                      color: isSelected ? ColorsManager.white : ColorsManager.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditAdminProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && insertEditAdminProvider.isAllDataValid()) {
                                if(widget.adminModel == null) {
                                  InsertAdminParameters insertAdminParameters = InsertAdminParameters(
                                    fullName: _textEditingControllerFullName.text.trim(),
                                    personalImage: null,
                                    coverImage: null,
                                    bio: _textEditingControllerBio.text.trim().isEmpty ? null : _textEditingControllerBio.text.trim(),
                                    emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                    password: _textEditingControllerPassword.text,
                                    dialingCode: null,
                                    phoneNumber: _textEditingControllerPhoneNumber.text.trim().isEmpty ? null : _textEditingControllerPhoneNumber.text.trim(),
                                    birthDate: insertEditAdminProvider.birthDate?.millisecondsSinceEpoch.toString(),
                                    countryId: null,
                                    gender: _gender,
                                    permissions: insertEditAdminProvider.isSuper ? [] : insertEditAdminProvider.selectedPermissions.map((element) => element).toList(),
                                    isSuper: insertEditAdminProvider.isSuper,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditAdminProvider.insertAdmin(context: context, insertAdminParameters: insertAdminParameters);
                                }
                                else {
                                  EditAdminParameters editAdminParameters = EditAdminParameters(
                                    adminId: widget.adminModel!.adminId,
                                    fullName: _textEditingControllerFullName.text.trim(),
                                    personalImage: insertEditAdminProvider.personalImage is String ? insertEditAdminProvider.personalImage : null,
                                    coverImage: insertEditAdminProvider.coverImage is String ? insertEditAdminProvider.coverImage : null,
                                    bio: _textEditingControllerBio.text.trim().isEmpty ? null : _textEditingControllerBio.text.trim(),
                                    emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                    password: _textEditingControllerPassword.text,
                                    dialingCode: widget.adminModel!.dialingCode,
                                    phoneNumber: _textEditingControllerPhoneNumber.text.trim().isEmpty ? null : _textEditingControllerPhoneNumber.text.trim(),
                                    birthDate: insertEditAdminProvider.birthDate?.millisecondsSinceEpoch.toString(),
                                    countryId: widget.adminModel?.countryId,
                                    gender: _gender,
                                    permissions: insertEditAdminProvider.isSuper ? [] : insertEditAdminProvider.selectedPermissions.map((element) => element).toList(),
                                    isSuper: insertEditAdminProvider.isSuper,
                                  );
                                  insertEditAdminProvider.editAdmin(context: context, editAdminParameters: editAdminParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.adminModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.adminModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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
    _textEditingControllerFullName.dispose();
    _textEditingControllerEmailAddress.dispose();
    _textEditingControllerPassword.dispose();
    _textEditingControllerPhoneNumber.dispose();
    _textEditingControllerBio.dispose();
    super.dispose();
  }
}