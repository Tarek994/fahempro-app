import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/domain/usecases/authentication_user/register_user_usecase.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/background_widget.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class RegisterWithPhoneScreen extends StatefulWidget {
  final String phoneNumber;

  const RegisterWithPhoneScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<RegisterWithPhoneScreen> createState() => _RegisterWithPhoneScreenState();
}

class _RegisterWithPhoneScreenState extends State<RegisterWithPhoneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _reasonForRegisteringController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        isShowBackground: true,
        child: SafeArea(
          child: Consumer<AuthenticationProvider>(
            builder: (context, authenticationProvider, child) {
              return CustomFullLoading(
                isShowLoading: authenticationProvider.isLoading,
                waitForDone: authenticationProvider.isLoading,
                isShowOpacityBackground: true,
                child: CustomScrollView(
                  slivers: [
                    const DefaultSliverAppBar(
                      appBarColor: Colors.transparent,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(SizeManager.s16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Methods.getText(StringsManager.theLastStepToCreateYourAccount),
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: SizeManager.s20,
                                  fontWeight: FontWeightManager.black,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s20),
                              Text(
                                Methods.getText(StringsManager.addYourBasicInformationToStartFahem).toCapitalized(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: SizeManager.s12,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s20),

                              CustomTextFormField(
                                controller: _fullNameController,
                                labelText: '${Methods.getText(StringsManager.name).toTitleCase()} *',
                                validator: Validator.validateEmpty,
                              ),
                              const SizedBox(height: SizeManager.s20),
                              CustomTextFormField(
                                controller: _emailAddressController,
                                keyboardType: TextInputType.emailAddress,
                                labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} (${Methods.getText(StringsManager.optional).toCapitalized()})',
                                validator: Validator.validateEmailAddressAllowEmpty,
                              ),
                              const SizedBox(height: SizeManager.s20),
                              CustomTextFormField(
                                controller: _reasonForRegisteringController,
                                labelText: '${Methods.getText(StringsManager.reasonForRegisteringInTheApplication).toCapitalized()} (${Methods.getText(StringsManager.optional).toCapitalized()})',
                              ),
                              const SizedBox(height: SizeManager.s20),
                              CustomButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if(_formKey.currentState!.validate()) {
                                    RegisterUserParameters registerUserParameters = RegisterUserParameters(
                                      fullName: _fullNameController.text.trim(),
                                      emailAddress: _emailAddressController.text.trim().isEmpty ? null : _emailAddressController.text.trim(),
                                      reasonForRegistering: _reasonForRegisteringController.text.trim().isEmpty ? null : _reasonForRegisteringController.text.trim(),
                                      dialingCode: ConstantsManager.dialingCodeEgypt,
                                      phoneNumber: widget.phoneNumber,
                                      personalImage: null,
                                      signInMethod: SignInMethod.phoneNumber,
                                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                    );
                                    await MyProviders.authenticationProvider.registerUser(
                                      context: context,
                                      registerUserParameters: registerUserParameters,
                                    );
                                  }
                                },
                                buttonType: ButtonType.text,
                                text: Methods.getText(StringsManager.signUp).toTitleCase(),
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
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: SizeManager.s0,
        title: const MyBackButton(),
      ),
      body: Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, child) {
          return CustomFullLoading(
            isShowLoading: authenticationProvider.isLoading,
            waitForDone: authenticationProvider.isLoading,
            isShowOpacityBackground: true,
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(SizeManager.s16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        Methods.getText(StringsManager.createNewAccount).toCapitalized(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s24, fontWeight: FontWeightManager.bold),
                      ),

                      const SizedBox(height: SizeManager.s20),
                      CustomTextFormField(
                        controller: _fullNameController,
                        hintText: Methods.getText(StringsManager.name).toTitleCase(),
                        validator: Validator.validateEmpty,
                      ),
                      const SizedBox(height: SizeManager.s20),
                      CustomTextFormField(
                        controller: _emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: Methods.getText(StringsManager.emailAddress).toTitleCase(),
                        validator: Validator.validateEmailAddressAllowEmpty,
                      ),
                      const SizedBox(height: SizeManager.s20),
                      // CustomTextFormField(
                      //   enabled: false,
                      //   controller: _phoneNumberController,
                      //   keyboardType: TextInputType.phone,
                      //   hintText: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                      //   validator: Validator.validatePhoneNumber,
                      //   prefixIcon: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: SizeManager.s20),
                      //     child: Image.asset(FlagsImagesManager.egyptFlag, height: SizeManager.s30, width: SizeManager.s30),
                      //   ),
                      // ),
                      const SizedBox(height: SizeManager.s20),
                      // CustomTextFormField(
                      //   isPasswordField: true,
                      //   controller: _passwordController,
                      //   hintText: Methods.getText(StringsManager.password).toTitleCase(),
                      //   isSupportClearSuffixIcon: false,
                      //   validator: Validator.validatePasswordLength,
                      // ),
                      // const SizedBox(height: SizeManager.s20),
                      // CustomTextFormField(
                      //   isPasswordField: true,
                      //   controller: _confirmPasswordController,
                      //   hintText: Methods.getText(StringsManager.confirmPassword).toTitleCase(),
                      //   isSupportClearSuffixIcon: false,
                      //   validator: (value) => Validator.validateConfirmPassword(value, _passwordController.text),
                      // ),
                      // const SizedBox(height: SizeManager.s40),
                      CustomButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if(_formKey.currentState!.validate()) {
                            // RegisterUserParameters registerUserParameters = RegisterUserParameters(
                            //   fullName: _fullNameController.text.trim(),
                            //   emailAddress: _emailAddressController.text.trim().isEmpty ? null : _emailAddressController.text.trim(),
                            //   password: null,
                            //   dialingCode: ConstantsManager.dialingCodeEgypt,
                            //   phoneNumber: _phoneNumberController.text.trim(),
                            //   personalImage: null,
                            //   signInMethod: SignInMethod.phoneNumber,
                            //   createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                            // );
                            // await MyProviders.authenticationProvider.registerUser(
                            //   context: context,
                            //   registerUserParameters: registerUserParameters,
                            // );
                          }
                        },
                        buttonType: ButtonType.text,
                        text: Methods.getText(StringsManager.signUp).toTitleCase(),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
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
    _reasonForRegisteringController.dispose();
    super.dispose();
  }
}