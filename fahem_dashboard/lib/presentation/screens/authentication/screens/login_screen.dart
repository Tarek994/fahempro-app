import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_dashboard/presentation/screens/splash/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/validator.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/login_admin_usecase.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerEmailAddress = TextEditingController(text: 'fahem@fahem.com');
  final TextEditingController _textEditingControllerPassword = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized(),
      ),
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
                              LoginAdminParameters loginAdminParameters = LoginAdminParameters(
                                emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                password: _textEditingControllerPassword.text,
                              );
                              MyProviders.authenticationProvider.loginAdmin(context: context, loginAdminParameters: loginAdminParameters);
                            }
                          },
                          text: Methods.getText(StringsManager.login).toUpperCase(),
                          width: SizeManager.s200,
                        ),
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