import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/screens/authentication/widgets/dont_have_account.dart';
import 'package:fahem/presentation/screens/splash/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/domain/usecases/authentication_user/login_user_usecase.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerEmailAddress = TextEditingController();
  final TextEditingController _textEditingControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized()),
      child: Scaffold(
        body: Consumer<AuthenticationProvider>(
          builder: (context, provider, _) {
            return CustomFullLoading(
              isShowLoading: provider.isLoading,
              waitForDone: provider.isLoading,
              isShowOpacityBackground: true,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          Methods.getText(StringsManager.appName).toTitleCase(),
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.semiBold),
                        ),
                        const SizedBox(height: SizeManager.s30),
                        const MyLogo(),
                        const SizedBox(height: SizeManager.s40),
                        Column(
                          children: [
                            // Email Address *
                            CustomTextFormField(
                              controller: _textEditingControllerEmailAddress,
                              keyboardType: TextInputType.emailAddress,
                              labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} *',
                              prefixIconData: Icons.email,
                              validator: Validator.validateEmailAddress,
                            ),
                            const SizedBox(height: SizeManager.s16),

                            // Password *
                            CustomTextFormField(
                              isPasswordField: true,
                              isSupportClearSuffixIcon: false,
                              controller: _textEditingControllerPassword,
                              textInputAction: TextInputAction.done,
                              labelText: '${Methods.getText(StringsManager.password).toTitleCase()} *',
                              prefixIconData: Icons.lock,
                              validator: Validator.validatePasswordLength,
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Methods.routeTo(context, Routes.forgotPasswordScreen);
                            },
                            style: TextButton.styleFrom(
                              visualDensity: const VisualDensity(horizontal: -4),
                              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5),
                            ),
                            child: Text(
                              '${Methods.getText(StringsManager.forgotPassword).toTitleCase()} ${MyProviders.appProvider.isEnglish ? '?' : '؟'}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeManager.s40),
                        CustomButton(
                          buttonType: ButtonType.text,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if(_formKey.currentState!.validate()) {
                              LoginUserParameters loginUserParameters = LoginUserParameters(
                                emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                password: _textEditingControllerPassword.text,
                              );
                              MyProviders.authenticationProvider.loginUser(context: context, loginUserParameters: loginUserParameters);
                            }
                          },
                          text: Methods.getText(StringsManager.login).toUpperCase(),
                          width: double.infinity,
                        ),
                        const SizedBox(height: SizeManager.s20),
                        Text(
                          Methods.getText(StringsManager.orContinueWith).toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.medium),
                        ),
                        const SizedBox(height: SizeManager.s15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  MyProviders.authenticationProvider.signInWithGoogle(context: context);
                                },
                                buttonType: ButtonType.postIcon,
                                text: Methods.getText(StringsManager.google).toCapitalized(),
                                iconData: FontAwesomeIcons.google,
                                buttonColor: ColorsManager.google,
                                textColor: ColorsManager.white,
                                iconColor: ColorsManager.white,
                                borderColor: ColorsManager.google,
                                height: SizeManager.s40,
                              ),
                            ),
                            if(false) const SizedBox(width: SizeManager.s10),
                            if(false) Flexible(
                              child: CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                },
                                buttonType: ButtonType.postIcon,
                                text: Methods.getText(StringsManager.facebook).toCapitalized(),
                                iconData: FontAwesomeIcons.facebookF,
                                buttonColor: ColorsManager.facebook,
                                width: SizeManager.s150,
                                height: SizeManager.s40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SizeManager.s20),
                        const DontHaveAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerEmailAddress.dispose();
    _textEditingControllerPassword.dispose();
    super.dispose();
  }
}