import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/domain/usecases/authentication_account/change_account_password_usecase.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerOldPassword = TextEditingController();
  final TextEditingController _textEditingControllerNewPassword = TextEditingController();
  final TextEditingController _textEditingControllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, provider, _) {
          return CustomFullLoading(
            isShowLoading: provider.isLoading,
            waitForDone: provider.isLoading,
            isShowOpacityBackground: true,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const DefaultSliverAppBar(title: StringsManager.changePassword),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          // Old Password *
                          CustomTextFormField(
                            isPasswordField: true,
                            isSupportClearSuffixIcon: false,
                            controller: _textEditingControllerOldPassword,
                            labelText: '${Methods.getText(StringsManager.oldPassword).toTitleCase()} *',
                            prefixIconData: Icons.lock_outline,
                            validator: Validator.validatePasswordLength,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // New Password *
                          CustomTextFormField(
                            isPasswordField: true,
                            isSupportClearSuffixIcon: false,
                            controller: _textEditingControllerNewPassword,
                            labelText: '${Methods.getText(StringsManager.newPassword).toTitleCase()} *',
                            prefixIconData: Icons.lock_outline,
                            validator: Validator.validatePasswordLength,
                          ),
                          const SizedBox(height: SizeManager.s20),

                          // Confirm Password *
                          CustomTextFormField(
                            isPasswordField: true,
                            isSupportClearSuffixIcon: false,
                            controller: _textEditingControllerConfirmPassword,
                            labelText: '${Methods.getText(StringsManager.confirmPassword).toTitleCase()} *',
                            prefixIconData: Icons.lock_outline,
                            validator: (value) => Validator.validateConfirmPassword(value, _textEditingControllerNewPassword.text),
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                ChangeAccountPasswordParameters parameters = ChangeAccountPasswordParameters(
                                  accountId: MyProviders.authenticationProvider.currentAccount.accountId,
                                  oldPassword: _textEditingControllerOldPassword.text,
                                  newPassword: _textEditingControllerNewPassword.text,
                                );
                                MyProviders.authenticationProvider.changePassword(context: context, changeAccountPasswordParameters: parameters);
                              }
                            },
                            buttonType: ButtonType.text,
                            text: Methods.getText(StringsManager.ok).toTitleCase(),
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
    _textEditingControllerOldPassword.dispose();
    _textEditingControllerNewPassword.dispose();
    _textEditingControllerConfirmPassword.dispose();
    super.dispose();
  }
}