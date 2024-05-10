import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/usecases/authentication_user/edit_user_profile_usecase.dart';
import 'package:fahem/presentation/screens/profile/controllers/edit_user_profile_provider.dart';
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
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class EditUserProfileScreen extends StatefulWidget {
  final UserModel userModel;

  const EditUserProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  late EditUserProfileProvider editUserProfileProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Gender? _gender;

  @override
  void initState() {
    super.initState();
    editUserProfileProvider = Provider.of<EditUserProfileProvider>(context, listen: false);

    _fullNameController.text = widget.userModel.fullName;
    _emailAddressController.text = widget.userModel.emailAddress ?? '';
    _phoneNumberController.text = widget.userModel.phoneNumber ?? '';
    _bioController.text = widget.userModel.bio ?? '';
    _gender = widget.userModel.gender;
    editUserProfileProvider.setPersonalImage(widget.userModel.personalImage);
    editUserProfileProvider.setCoverImage(widget.userModel.coverImage);
    if(widget.userModel.birthDate != null) editUserProfileProvider.setBirthDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.userModel.birthDate!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsManager.grey1,
      body: Consumer<EditUserProfileProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(
                  title: StringsManager.editMyProfile,
                  // customTitle: widget.userModel.fullName,
                ),
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
                                          color: ColorsManager.grey1,
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
                                                if(xFile != null) provider.changeCoverImage(xFile);
                                              }
                                              else {
                                                provider.changeCoverImage(null);
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
                                                if(xFile != null) provider.changePersonalImage(xFile);
                                              }
                                              else {
                                                provider.changePersonalImage(null);
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
                            controller: _fullNameController,
                            labelText: '${Methods.getText(StringsManager.name).toTitleCase()} *',
                            prefixIconData: Icons.person_2_outlined,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Email Address *
                          if(widget.userModel.signInMethod == SignInMethod.emailAndPassword) ...[
                            CustomTextFormField(
                              controller: _emailAddressController,
                              keyboardType: TextInputType.emailAddress,
                              labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} *',
                              prefixIconData: Icons.email_outlined,
                              validator: Validator.validateEmailAddress,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Dialing Code And Phone Number
                          if(widget.userModel.signInMethod != SignInMethod.phoneNumber) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _phoneNumberController,
                                    keyboardType: TextInputType.phone,
                                    maxLength: 11,
                                    labelText: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                                    prefixIconData: Icons.phone,
                                    validator: Validator.validatePhoneNumber,
                                  ),
                                ),
                                const SizedBox(width: SizeManager.s10),
                                SizedBox(
                                  width: SizeManager.s100,
                                  child: CustomButton(
                                    buttonType: ButtonType.postImage,
                                    text: provider.dialingCode.dialingCode,
                                    imageName: provider.dialingCode.flag,
                                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                    buttonColor: ColorsManager.white,
                                    borderColor: ColorsManager.grey300,
                                    iconColor: ColorsManager.grey,
                                    textColor: ColorsManager.black,
                                    fontSize: SizeManager.s12,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

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
                                  provider.onPressedBirthDate(context);
                                },
                                text: provider.birthDate == null
                                    ? Methods.getText(StringsManager.birthDate).toCapitalized()
                                    : Methods.formatDate(milliseconds: provider.birthDate!.millisecondsSinceEpoch, format: 'd MMMM yyyy'),
                                iconData: FontAwesomeIcons.calendar,
                                postClickableIconData: provider.birthDate == null ? null : Icons.clear,
                                onPressedPostClickableIcon: provider.birthDate == null ? null : () {
                                  FocusScope.of(context).unfocus();
                                  provider.changeBirthDate(null);
                                },
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.lightPrimaryColor,
                                iconColor: ColorsManager.lightPrimaryColor,
                                textColor: provider.birthDate == null ? ColorsManager.lightPrimaryColor : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                textFontWeight: provider.birthDate == null ? FontWeightManager.black : FontWeightManager.medium,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              if(provider.birthDate != null) PositionedDirectional(
                                start: 36,
                                top: -6,
                                child: Text(
                                  Methods.getText(StringsManager.birthDate).toCapitalized(),
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: SizeManager.s9,
                                    fontWeight: FontWeightManager.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Bio
                          CustomTextFormField(
                            controller: _bioController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5,
                            borderRadius: SizeManager.s20,
                            labelText: Methods.getText(StringsManager.informationAboutYou).toTitleCase(),
                            // validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              provider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                EditUserProfileParameters parameters = EditUserProfileParameters(
                                  userId: widget.userModel.userId,
                                  fullName: _fullNameController.text.trim(),
                                  personalImage: provider.personalImage is String ? provider.personalImage : null,
                                  coverImage: provider.coverImage is String ? provider.coverImage : null,
                                  bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
                                  emailAddress: _emailAddressController.text.trim().isEmpty ? null : _emailAddressController.text.trim(),
                                  dialingCode: provider.dialingCode.dialingCode,
                                  phoneNumber: _phoneNumberController.text.trim(),
                                  birthDate: provider.birthDate?.millisecondsSinceEpoch.toString(),
                                  countryId: widget.userModel.countryId,
                                  gender: _gender,
                                  latitude: widget.userModel.latitude,
                                  longitude: widget.userModel.longitude,
                                );
                                provider.editUserProfile(context: context, parameters: parameters);
                              }
                            },
                            buttonType: ButtonType.postIcon,
                            iconData: FontAwesomeIcons.penToSquare,
                            text: Methods.getText(StringsManager.edit).toTitleCase(),
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
    _fullNameController.dispose();
    _emailAddressController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}