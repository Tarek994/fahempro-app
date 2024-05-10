import 'package:geolocator/geolocator.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/users/controllers/insert_edit_user_provider.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem/domain/usecases/users/insert_user_usecase.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class InsertEditUserScreen extends StatefulWidget {
  final UserModel? userModel;

  const InsertEditUserScreen({
    super.key,
    this.userModel,
  });

  @override
  State<InsertEditUserScreen> createState() => _InsertEditUserScreenState();
}

class _InsertEditUserScreenState extends State<InsertEditUserScreen> {
  late InsertEditUserProvider insertEditUserProvider;
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
    insertEditUserProvider = Provider.of<InsertEditUserProvider>(context, listen: false);

    if(widget.userModel != null) {
      _textEditingControllerFullName.text = widget.userModel!.fullName;
      _textEditingControllerEmailAddress.text = widget.userModel!.emailAddress ?? '';
      _textEditingControllerPassword.text = widget.userModel!.password ?? '';
      _textEditingControllerPhoneNumber.text = widget.userModel!.phoneNumber ?? '';
      _textEditingControllerBio.text = widget.userModel!.bio ?? '';
      _gender = widget.userModel!.gender;
      insertEditUserProvider.setPersonalImage(widget.userModel!.personalImage);
      insertEditUserProvider.setCoverImage(widget.userModel!.coverImage);
      if(widget.userModel!.birthDate != null) insertEditUserProvider.setBirthDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.userModel!.birthDate!)));
      insertEditUserProvider.setIsFeatured(widget.userModel!.isFeatured);
      insertEditUserProvider.setDialingCode(widget.userModel!.dialingCodeModel);
      insertEditUserProvider.setCountry(widget.userModel!.country);
      if(widget.userModel!.latitude != null && widget.userModel!.longitude != null) {
        insertEditUserProvider.setPosition(
          Position.fromMap({
            'latitude': widget.userModel!.latitude,
            'longitude': widget.userModel!.longitude,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InsertEditUserProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                DefaultSliverAppBar(title: widget.userModel == null ? StringsManager.addUser : StringsManager.editUser),
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
                                          imageDirectory: ApiConstants.usersDirectory,
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
                                                if(xFile != null) insertEditUserProvider.changeCoverImage(xFile);
                                              }
                                              else {
                                                insertEditUserProvider.changeCoverImage(null);
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
                                            imageDirectory: ApiConstants.usersDirectory,
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
                                                if(xFile != null) insertEditUserProvider.changePersonalImage(xFile);
                                              }
                                              else {
                                                insertEditUserProvider.changePersonalImage(null);
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
                          const SizedBox(height: SizeManager.s20),

                          // Dialing Code And Phone Number *
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  controller: _textEditingControllerPhoneNumber,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 11,
                                  labelText: '${Methods.getText(StringsManager.phoneNumber).toTitleCase()} *',
                                  prefixIconData: Icons.phone,
                                  validator: Validator.validatePhoneNumber,
                                ),
                              ),
                              const SizedBox(width: SizeManager.s10),
                              SizedBox(
                                width: SizeManager.s100,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CustomButton(
                                      onPressed: () => provider.onPressedDialingCode(context),
                                      buttonType: ButtonType.text,
                                      text: provider.dialingCode == null
                                          ? '${Methods.getText(StringsManager.code).toCapitalized()} *'
                                          : provider.dialingCode!.dialingCode,
                                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                      buttonColor: ColorsManager.white,
                                      borderColor: ColorsManager.grey300,
                                      iconColor: ColorsManager.grey,
                                      textColor: provider.dialingCode == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                                      fontSize: SizeManager.s12,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      isRequired: provider.isButtonClicked && provider.dialingCode == null,
                                      textDirection: TextDirection.ltr,
                                    ),
                                    if(provider.dialingCode != null) PositionedDirectional(
                                      start: 36,
                                      top: -5,
                                      child: Text(
                                        '${Methods.getText(StringsManager.code).toCapitalized()} *',
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Gender *
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
                              color: ColorsManager.lightPrimaryColor,
                            ) : Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _gender = null);
                                },
                                icon: const Icon(Icons.clear, size: SizeManager.s20, color: ColorsManager.lightPrimaryColor),
                              ),
                            ),
                            validator: (value) => Validator.validateEmptyDropdown(value),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Birth Date *
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomButton(
                                buttonType: ButtonType.preIconPostClickableIcon,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  insertEditUserProvider.onPressedBirthDate(context);
                                },
                                text: provider.birthDate == null
                                    ? '${Methods.getText(StringsManager.birthDate).toCapitalized()} *'
                                    : Methods.formatDate(milliseconds: provider.birthDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                                iconData: FontAwesomeIcons.calendar,
                                postClickableIconData: provider.birthDate == null ? null : Icons.clear,
                                onPressedPostClickableIcon: provider.birthDate == null ? null : () {
                                  FocusScope.of(context).unfocus();
                                  insertEditUserProvider.changeBirthDate(null);
                                },
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.grey300,
                                iconColor: ColorsManager.grey,
                                textColor: provider.birthDate == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                mainAxisAlignment: MainAxisAlignment.start,
                                isRequired: provider.isButtonClicked && provider.birthDate == null,
                              ),
                              if(provider.birthDate != null) PositionedDirectional(
                                start: 36,
                                top: -5,
                                child: Text(
                                  '${Methods.getText(StringsManager.birthDate).toCapitalized()} *',
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Country *
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  provider.onPressedCountry(context);
                                },
                                buttonType: provider.country == null ? ButtonType.preIconPostClickableIcon : ButtonType.preImage,
                                text: provider.country == null
                                    ? '${Methods.getText(StringsManager.country).toCapitalized()} *'
                                    : MyProviders.appProvider.isEnglish ? provider.country!.countryNameEn : provider.country!.countryNameAr,
                                iconData: Icons.location_city_outlined,
                                imageName: provider.country?.flag,
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.grey300,
                                iconColor: ColorsManager.grey,
                                textColor: provider.country == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                mainAxisAlignment: MainAxisAlignment.start,
                                isRequired: provider.isButtonClicked && provider.country == null,
                              ),
                              if(provider.country != null) PositionedDirectional(
                                start: 36,
                                top: -5,
                                child: Text(
                                  '${Methods.getText(StringsManager.country).toCapitalized()} *',
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: SizeManager.s20),

                          // Bio
                          // CustomTextFormField(
                          //   controller: _textEditingControllerBio,
                          //   keyboardType: TextInputType.multiline,
                          //   textInputAction: TextInputAction.newline,
                          //   maxLines: 5,
                          //   borderRadius: SizeManager.s20,
                          //   labelText: Methods.getText(StringsManager.bio).toTitleCase(),
                          // ),
                          // const SizedBox(height: SizeManager.s20),

                          // Is Featured *
                          // Material(
                          //   color: Colors.transparent,
                          //   child: CheckboxListTile(
                          //     value: provider.isFeatured,
                          //     onChanged: (value) => provider.changeIsFeatured(value!),
                          //     title: Text(
                          //       Methods.getText(StringsManager.theAccountIsFeature).toTitleCase(),
                          //       style: Theme.of(context).textTheme.bodySmall,
                          //     ),
                          //     tileColor: ColorsManager.white,
                          //     activeColor: ColorsManager.lightPrimaryColor,
                          //     checkColor: ColorsManager.white,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(SizeManager.s10),
                          //       side: const BorderSide(color: ColorsManager.grey300),
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              insertEditUserProvider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && insertEditUserProvider.isAllDataValid()) {
                                if(widget.userModel == null) {
                                  InsertUserParameters insertUserParameters = InsertUserParameters(
                                    fullName: _textEditingControllerFullName.text.trim(),
                                    personalImage: null,
                                    coverImage: null,
                                    bio: _textEditingControllerBio.text.trim().isEmpty ? null : _textEditingControllerBio.text.trim(),
                                    emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                    password: _textEditingControllerPassword.text,
                                    dialingCode: insertEditUserProvider.dialingCode?.dialingCode,
                                    phoneNumber: _textEditingControllerPhoneNumber.text.trim(),
                                    birthDate: insertEditUserProvider.birthDate?.millisecondsSinceEpoch.toString(),
                                    countryId: insertEditUserProvider.country?.countryId,
                                    gender: _gender,
                                    isFeatured: insertEditUserProvider.isFeatured,
                                    balance: 0,
                                    signInMethod: SignInMethod.emailAndPassword,
                                    latitude: null,
                                    longitude: null,
                                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  );
                                  insertEditUserProvider.insertUser(context: context, insertUserParameters: insertUserParameters);
                                }
                                else {
                                  EditUserParameters editUserParameters = EditUserParameters(
                                    userId: widget.userModel!.userId,
                                    fullName: _textEditingControllerFullName.text.trim(),
                                    personalImage: insertEditUserProvider.personalImage is String ? insertEditUserProvider.personalImage : null,
                                    coverImage: insertEditUserProvider.coverImage is String ? insertEditUserProvider.coverImage : null,
                                    bio: _textEditingControllerBio.text.trim().isEmpty ? null : _textEditingControllerBio.text.trim(),
                                    emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                    password: _textEditingControllerPassword.text,
                                    dialingCode: insertEditUserProvider.dialingCode?.dialingCode,
                                    phoneNumber: _textEditingControllerPhoneNumber.text.trim(),
                                    birthDate: insertEditUserProvider.birthDate?.millisecondsSinceEpoch.toString(),
                                    countryId: insertEditUserProvider.country?.countryId,
                                    gender: _gender,
                                    isFeatured: insertEditUserProvider.isFeatured,
                                    balance: widget.userModel!.balance,
                                    signInMethod: widget.userModel!.signInMethod,
                                    latitude: null,
                                    longitude: null,
                                  );
                                  insertEditUserProvider.editUser(context: context, editUserParameters: editUserParameters);
                                }
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: widget.userModel == null ? FontAwesomeIcons.plus : FontAwesomeIcons.penToSquare,
                            text: Methods.getText(widget.userModel == null ? StringsManager.add : StringsManager.edit).toTitleCase(),
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