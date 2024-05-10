import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/services/location_service.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/data_source/static/appointment_booking_data.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/domain/usecases/authentication_account/edit_account_profile_usecase.dart';
import 'package:fahem_business/presentation/screens/profile/controllers/edit_account_profile_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/image_type_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/my_error_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_dropdown_button_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';

class EditAccountProfileScreen extends StatefulWidget {
  final AccountModel accountModel;

  const EditAccountProfileScreen({
    super.key,
    required this.accountModel,
  });

  @override
  State<EditAccountProfileScreen> createState() => _EditAccountProfileScreenState();
}

class _EditAccountProfileScreenState extends State<EditAccountProfileScreen> {
  late EditAccountProfileProvider editAccountProfileProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _consultationPriceController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  Gender? _gender;

  @override
  void initState() {
    super.initState();
    editAccountProfileProvider = Provider.of<EditAccountProfileProvider>(context, listen: false);

    _fullNameController.text = widget.accountModel.fullName;
    _emailAddressController.text = widget.accountModel.emailAddress;
    _addressController.text = widget.accountModel.address ?? '';
    _phoneNumberController.text = widget.accountModel.phoneNumber ?? '';
    _jobTitleController.text = widget.accountModel.jobTitle ?? '';
    _bioController.text = widget.accountModel.bio ?? '';
    _consultationPriceController.text = widget.accountModel.consultationPrice == null ? '' : widget.accountModel.consultationPrice.toString();
    _nationalIdController.text = widget.accountModel.nationalId ?? '';
    _cardNumberController.text = widget.accountModel.cardNumber ?? '';
    _gender = widget.accountModel.gender;
    editAccountProfileProvider.setPersonalImage(widget.accountModel.personalImage);
    editAccountProfileProvider.setCoverImage(widget.accountModel.coverImage);
    if(widget.accountModel.birthDate != null) editAccountProfileProvider.setBirthDate(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.accountModel.birthDate!)));
    editAccountProfileProvider.setIsBookingByAppointment(widget.accountModel.isBookingByAppointment);
    editAccountProfileProvider.setGovernorate(widget.accountModel.governorate);
    editAccountProfileProvider.setTasks(widget.accountModel.tasks);
    editAccountProfileProvider.setSelectedCategories(widget.accountModel.categories);
    editAccountProfileProvider.setSelectedServices(widget.accountModel.services);
    editAccountProfileProvider.setSelectedAppointmentBooking(widget.accountModel.appointmentBooking);
    editAccountProfileProvider.setPhotoGallery(widget.accountModel.photoGallery);
    editAccountProfileProvider.setIdentificationImages(widget.accountModel.identificationImages);
    editAccountProfileProvider.setNationalImageFrontSide(widget.accountModel.nationalImageFrontSide);
    editAccountProfileProvider.setNationalImageBackSide(widget.accountModel.nationalImageBackSide);
    editAccountProfileProvider.setCardImage(widget.accountModel.cardImage);
    if(widget.accountModel.latitude != null && widget.accountModel.longitude != null) {
      LocationService.getAddressFromCoordinates(
        LatLng(widget.accountModel.latitude!, widget.accountModel.longitude!),
      ).then((value) {
        editAccountProfileProvider.changeAddress(value);
      });
      editAccountProfileProvider.setPosition(
        Position.fromMap({
          'latitude': widget.accountModel.latitude,
          'longitude': widget.accountModel.longitude,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        editAccountProfileProvider.fetchCategories(mainCategoryId: widget.accountModel.mainCategoryId),
        editAccountProfileProvider.fetchServices(mainCategoryId: widget.accountModel.mainCategoryId),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EditAccountProfileProvider>(
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
                  // customTitle: widget.accountModel.fullName,
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
                                          color: ColorsManager.white,
                                          borderRadius: BorderRadius.circular(SizeManager.s10),
                                          border: Border.all(color: ColorsManager.grey300),
                                        ),
                                        child: ImageTypeWidget(
                                          image: provider.coverImage,
                                          imageDirectory: ApiConstants.accountsDirectory,
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
                                            imageDirectory: ApiConstants.accountsDirectory,
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
                          if(widget.accountModel.signInMethod == SignInMethod.emailAndPassword) ...[
                            CustomTextFormField(
                              controller: _emailAddressController,
                              keyboardType: TextInputType.emailAddress,
                              labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} *',
                              prefixIconData: Icons.email_outlined,
                              validator: Validator.validateEmailAddress,
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          // Government
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  provider.onPressedGovernorate(context);
                                },
                                buttonType: ButtonType.preIconPostSpacerText,
                                text: provider.governorate == null
                                    ? Methods.getText(StringsManager.governorate).toCapitalized()
                                    : MyProviders.appProvider.isEnglish ? provider.governorate!.governorateNameEn : provider.governorate!.governorateNameAr,
                                iconData: Icons.location_city_outlined,
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.grey300,
                                iconColor: ColorsManager.grey,
                                textColor: provider.governorate == null ? ColorsManager.grey : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                mainAxisAlignment: MainAxisAlignment.start,
                                // isRequired: provider.isButtonClicked && provider.governorate == null,
                              ),
                              if(provider.governorate != null) PositionedDirectional(
                                start: 36,
                                top: -5,
                                child: Text(
                                  Methods.getText(StringsManager.governorate).toCapitalized(),
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Address
                          CustomTextFormField(
                            controller: _addressController,
                            labelText: Methods.getText(StringsManager.address).toTitleCase(),
                            prefixIconData: Icons.location_on,
                            // validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Dialing Code And Phone Number
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
                                  // validator: Validator.validatePhoneNumber,
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
                                borderColor: ColorsManager.grey300,
                                iconColor: ColorsManager.grey,
                                textColor: provider.birthDate == null ? ColorsManager.grey : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                mainAxisAlignment: MainAxisAlignment.start,
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

                          // Job Title
                          CustomTextFormField(
                            controller: _jobTitleController,
                            labelText: Methods.getText(StringsManager.jobTitle).toTitleCase(),
                            prefixIconData: FontAwesomeIcons.briefcase,
                            // validator: Validator.validateEmpty,
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
                          const SizedBox(height: SizeManager.s20),

                          // consultationPrice
                          CustomTextFormField(
                            controller: _consultationPriceController,
                            keyboardType: TextInputType.number,
                            labelText: '${Methods.getText(StringsManager.consultationPrice).toTitleCase()} (${Methods.getText(StringsManager.egyptianPound).toTitleCase()})',
                            prefixIconData: FontAwesomeIcons.coins,
                            // validator: Validator.validateIntegerNumber,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Tasks
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
                                  controller: _taskController,
                                  labelText: Methods.getText(StringsManager.tasks).toCapitalized(),
                                  prefixIconData: Icons.task_alt,
                                  fillColor: ColorsManager.grey100,
                                  suffixIcon: CustomButton(
                                    onPressed: () async {
                                      provider.addInTasks(_taskController.text.trim());
                                      _taskController.clear();
                                    },
                                    buttonColor: Colors.transparent,
                                    textColor: ColorsManager.lightPrimaryColor,
                                    buttonType: ButtonType.text,
                                    text: Methods.getText(StringsManager.add).toCapitalized(),
                                  ),
                                  isSupportClearSuffixIcon: false,
                                  // validator: (value) {
                                  //   if(provider.tasks.isEmpty) {
                                  //     return Methods.getText(StringsManager.required).toCapitalized();
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: SizeManager.s10),
                                Wrap(
                                  spacing: SizeManager.s5,
                                  runSpacing: SizeManager.s10,
                                  children: List.generate(provider.tasks.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        provider.removeFromTasks(provider.tasks[index]);
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
                                              provider.tasks[index],
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

                          // photoGallery
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
                                    Methods.getText(StringsManager.photoGallery).toCapitalized(),
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
                                      return index == provider.photoGallery.length ? Container(
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
                                              if(xFile != null) provider.addInPhotoGallery(xFile.path);
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
                                            provider.photoGallery[index].startsWith(ConstantsManager.fahemBusinessImageFromFile) ? Image.file(
                                              File(provider.photoGallery[index]),
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              fit: BoxFit.cover,
                                            ) : ImageWidget(
                                              image: provider.photoGallery[index],
                                              imageDirectory: ApiConstants.accountsGalleryDirectory,
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
                                                    if(xFile != null) provider.editInPhotoGallery(image: xFile.path, index: index);
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
                                                  onPressed: () async => provider.removeFromPhotoGallery(index),
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
                                    itemCount: provider.photoGallery.length + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // identificationImages
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
                                    Methods.getText(StringsManager.proofOfIdentity).toCapitalized(),
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
                                      return index == provider.identificationImages.length ? Container(
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
                                              if(xFile != null) provider.addInIdentificationImages(xFile.path);
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
                                            provider.identificationImages[index].startsWith(ConstantsManager.fahemBusinessImageFromFile) ? Image.file(
                                              File(provider.identificationImages[index]),
                                              width: SizeManager.s100,
                                              height: SizeManager.s100,
                                              fit: BoxFit.cover,
                                            ) : ImageWidget(
                                              image: provider.identificationImages[index],
                                              imageDirectory: ApiConstants.accountsIdentificationDirectory,
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
                                                    if(xFile != null) provider.editInIdentificationImages(image: xFile.path, index: index);
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
                                                  onPressed: () async => provider.removeFromIdentificationImages(index),
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
                                    itemCount: provider.identificationImages.length + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // nationalId
                          CustomTextFormField(
                            controller: _nationalIdController,
                            keyboardType: TextInputType.number,
                            maxLength: 14,
                            labelText: Methods.getText(StringsManager.nationalId).toTitleCase(),
                            validator: Validator.validateIntegerNumberAllowEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // nationalImageFrontSide
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
                                    image: provider.nationalImageFrontSide,
                                    imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                    title: StringsManager.nationalImageFrontSide,
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
                                        if(provider.nationalImageFrontSide == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) provider.changeNationalImageFrontSide(xFile);
                                        }
                                        else {
                                          provider.changeNationalImageFrontSide(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.nationalImageFrontSide == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.nationalImageFrontSide == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // nationalImageBackSide
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
                                    image: provider.nationalImageBackSide,
                                    imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                    title: StringsManager.nationalImageBackSide,
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
                                        if(provider.nationalImageBackSide == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) provider.changeNationalImageBackSide(xFile);
                                        }
                                        else {
                                          provider.changeNationalImageBackSide(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.nationalImageBackSide == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.nationalImageBackSide == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // cardNumber
                          CustomTextFormField(
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            labelText: Methods.getText(StringsManager.cardNumber).toTitleCase(),
                            validator: Validator.validateIntegerNumberAllowEmpty,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // cardImage
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
                                    image: provider.cardImage,
                                    imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                    title: StringsManager.cardImage,
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
                                        if(provider.cardImage == null) {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) provider.changeCardImage(xFile);
                                        }
                                        else {
                                          provider.changeCardImage(null);
                                        }
                                      },
                                      isCircleBorder: true,
                                      iconData: provider.cardImage == null ? Icons.image : Icons.clear,
                                      buttonColor: provider.cardImage == null ? ColorsManager.lightPrimaryColor : ColorsManager.red700,
                                      iconSize: SizeManager.s20,
                                      width: SizeManager.s35,
                                      height: SizeManager.s35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Latitude & Longitude
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  provider.changeIsDetectLocationClicked(true);
                                  await Methods.checkPermissionAndGetCurrentPosition(context).then((position) async {
                                    provider.changeIsDetectLocationClicked(false);
                                    provider.changePosition(position);
                                    await LocationService.getAddressFromCoordinates(
                                      LatLng(provider.position!.latitude, provider.position!.longitude),
                                    ).then((address) {
                                      provider.changeAddress(address);
                                    });
                                  });
                                },
                                buttonType: ButtonType.preIconPostClickableIcon,
                                isLoading: provider.isDetectLocationClicked,
                                text: provider.position == null
                                    ? Methods.getText(StringsManager.detectLocation).toCapitalized()
                                    : provider.address ?? '',
                                // : MyProviders.appProvider.isEnglish
                                // ? 'Latitude: ${provider.position!.latitude} / Longitude: ${provider.position!.longitude}'
                                // : 'خط الطول: ${provider.position!.latitude} / خط العرض: ${provider.position!.longitude}',
                                iconData: Icons.location_on,
                                postClickableIconData: provider.position == null ? null : Icons.clear,
                                onPressedPostClickableIcon: provider.position == null ? null : () {
                                  FocusScope.of(context).unfocus();
                                  provider.changePosition(null);
                                  provider.changeIsDetectLocationClicked(false);
                                },
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.grey300,
                                iconColor: ColorsManager.grey,
                                textColor: provider.position == null ? ColorsManager.grey : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                // isRequired: provider.isButtonClicked && provider.position == null,
                              ),
                              if(provider.position != null) PositionedDirectional(
                                start: 36,
                                top: -5,
                                child: Text(
                                  Methods.getText(StringsManager.location).toCapitalized(),
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: SizeManager.s9),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Categories
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
                                    const Icon(FontAwesomeIcons.layerGroup, size: SizeManager.s12, color: ColorsManager.grey),
                                    const SizedBox(width: SizeManager.s10),
                                    Flexible(
                                      child: Text(
                                        Methods.getText(StringsManager.chooseTheCategories).toCapitalized(),
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SizeManager.s20),
                                ConditionalBuilder(
                                  condition: provider.categories.isNotEmpty,
                                  builder: (_) => Wrap(
                                    spacing: SizeManager.s5,
                                    runSpacing: SizeManager.s10,
                                    children: List.generate(provider.categories.length, (index) {
                                      bool isSelected = provider.selectedCategories.indexWhere((element) => element.categoryId == provider.categories[index].categoryId) != -1;
                                      return InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          provider.toggleSelectedCategories(provider.categories[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(SizeManager.s5),
                                          decoration: BoxDecoration(
                                            color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey100,
                                            border: Border.all(color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey300),
                                            borderRadius: BorderRadius.circular(SizeManager.s5),
                                          ),
                                          child: Text(
                                            MyProviders.appProvider.isEnglish ? provider.categories[index].nameEn : provider.categories[index].nameAr,
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: isSelected ? ColorsManager.white : ColorsManager.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  fallback: (_) {
                                    if(provider.categoriesDataState == DataState.loading) {
                                      return Methods.shimmerGrid(itemHeight: SizeManager.s40);
                                    }
                                    if(provider.categoriesDataState == DataState.empty) {
                                      return const NotFoundWidget(message: StringsManager.thereAreNoCategories, isShowImage: false);
                                    }
                                    if(provider.categoriesDataState == DataState.error) {
                                      return MyErrorWidget(onPressed: () => provider.reFetchCategories(mainCategoryId: widget.accountModel.mainCategoryId));
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Fahem Services
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
                                    const Icon(FontAwesomeIcons.layerGroup, size: SizeManager.s12, color: ColorsManager.grey),
                                    const SizedBox(width: SizeManager.s10),
                                    Flexible(
                                      child: Text(
                                        Methods.getText(StringsManager.subscribeToFahemServices).toCapitalized(),
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SizeManager.s20),
                                ConditionalBuilder(
                                  condition: provider.services.isNotEmpty,
                                  builder: (_) => Wrap(
                                    spacing: SizeManager.s5,
                                    runSpacing: SizeManager.s10,
                                    children: List.generate(provider.services.length, (index) {
                                      bool isSelected = provider.selectedServices.indexWhere((element) => element.serviceId == provider.services[index].serviceId) != -1;
                                      return InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          provider.toggleSelectedServices(provider.services[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(SizeManager.s5),
                                          decoration: BoxDecoration(
                                            color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey100,
                                            border: Border.all(color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey300),
                                            borderRadius: BorderRadius.circular(SizeManager.s5),
                                          ),
                                          child: Text(
                                            MyProviders.appProvider.isEnglish ? provider.services[index].nameEn : provider.services[index].nameAr,
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: isSelected ? ColorsManager.white : ColorsManager.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  fallback: (_) {
                                    if(provider.servicesDataState == DataState.loading) {
                                      return Methods.shimmerGrid(itemHeight: SizeManager.s40);
                                    }
                                    if(provider.servicesDataState == DataState.empty) {
                                      return const NotFoundWidget(message: StringsManager.thereAreNoServices, isShowImage: false);
                                    }
                                    if(provider.servicesDataState == DataState.error) {
                                      return MyErrorWidget(onPressed: () => provider.reFetchServices(mainCategoryId: widget.accountModel.mainCategoryId));
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // isBookingByAppointment *
                          Material(
                            color: Colors.transparent,
                            child: CheckboxListTile(
                              value: provider.isBookingByAppointment,
                              onChanged: (value) => provider.changeIsBookingByAppointment(value!),
                              title: Text(
                                Methods.getText(StringsManager.activateTheAppointmentBookingFeature).toTitleCase(),
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

                          // Appointment Booking *
                          if(provider.isBookingByAppointment) ...[
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
                                      const Icon(FontAwesomeIcons.clock, size: SizeManager.s12, color: ColorsManager.grey),
                                      const SizedBox(width: SizeManager.s10),
                                      Flexible(
                                        child: Text(
                                          '${Methods.getText(StringsManager.chooseThePeriodsAvailableToYou).toCapitalized()} *',
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: SizeManager.s20),
                                  Wrap(
                                    spacing: SizeManager.s5,
                                    runSpacing: SizeManager.s10,
                                    children: List.generate(appointmentBookingData.length, (index) {
                                      bool isSelected = provider.selectedAppointmentBooking.indexWhere((element) => element.appointmentBookingId == appointmentBookingData[index].appointmentBookingId) != -1;
                                      return InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          provider.toggleSelectedAppointmentBooking(appointmentBookingData[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(SizeManager.s5),
                                          decoration: BoxDecoration(
                                            color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey100,
                                            border: Border.all(color: isSelected ? ColorsManager.lightPrimaryColor : ColorsManager.grey300),
                                            borderRadius: BorderRadius.circular(SizeManager.s5),
                                          ),
                                          child: Text(
                                            MyProviders.appProvider.isEnglish ? appointmentBookingData[index].nameEn : appointmentBookingData[index].nameAr,
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
                            ),
                            const SizedBox(height: SizeManager.s20),
                          ],

                          const SizedBox(height: SizeManager.s20),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              provider.changeIsButtonClicked(true);
                              if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                Dialogs.showBottomSheetConfirmation(
                                  context: context,
                                  message: Methods.getText(StringsManager.noteEditProfile).toCapitalized(),
                                ).then((value) {
                                  if(value) {
                                    EditAccountProfileParameters parameters = EditAccountProfileParameters(
                                      accountId: widget.accountModel.accountId,
                                      fullName: _fullNameController.text.trim(),
                                      personalImage: provider.personalImage is String ? provider.personalImage : null,
                                      coverImage: provider.coverImage is String ? provider.coverImage : null,
                                      bio: _bioController.text.trim().isEmpty ? null : _bioController.text.trim(),
                                      emailAddress: _emailAddressController.text.trim(),
                                      dialingCode: provider.dialingCode.dialingCode,
                                      phoneNumber: _phoneNumberController.text.trim().isEmpty ? null : _phoneNumberController.text.trim(),
                                      birthDate: provider.birthDate?.millisecondsSinceEpoch.toString(),
                                      countryId: widget.accountModel.countryId,
                                      gender: _gender,
                                      latitude: provider.position?.latitude,
                                      longitude: provider.position?.longitude,
                                      jobTitle: _jobTitleController.text.trim().isEmpty ? null : _jobTitleController.text.trim(),
                                      address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
                                      consultationPrice: _consultationPriceController.text.trim().isEmpty ? null : int.parse(_consultationPriceController.text.trim()),
                                      tasks: provider.tasks.map((e) => e).toList(),
                                      features: widget.accountModel.features,
                                      photoGallery: widget.accountModel.photoGallery,
                                      governorateId: provider.governorate?.governorateId,
                                      isBookingByAppointment: provider.isBookingByAppointment,
                                      availablePeriods: provider.isBookingByAppointment
                                          ? provider.selectedAppointmentBooking.map((e) => e.appointmentBookingId).toList()
                                          : [],
                                      identificationImages: widget.accountModel.identificationImages,
                                      nationalId: _nationalIdController.text.trim().isEmpty ? null : _nationalIdController.text.trim(),
                                      nationalImageFrontSide: provider.nationalImageFrontSide is String ? provider.nationalImageFrontSide : null,
                                      nationalImageBackSide: provider.nationalImageBackSide is String ? provider.nationalImageBackSide : null,
                                      cardNumber: _cardNumberController.text.trim().isEmpty ? null : _cardNumberController.text.trim(),
                                      cardImage: provider.cardImage is String ? provider.cardImage : null,
                                      categoriesIds: provider.selectedCategories.map((e) => e.categoryId).toList(),
                                      servicesIds: provider.selectedServices.map((e) => e.serviceId).toList(),
                                    );
                                    provider.editAccountProfile(context: context, parameters: parameters);
                                  }
                                });
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
    _jobTitleController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _consultationPriceController.dispose();
    _taskController.dispose();
    _nationalIdController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }
}