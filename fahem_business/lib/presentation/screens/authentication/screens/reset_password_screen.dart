import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/domain/usecases/authentication_account/reset_account_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/reset_admin_password_usecase.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String emailAddress;

  const ResetPasswordScreen({
    super.key,
    required this.emailAddress,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerPassword = TextEditingController();
  final TextEditingController _textEditingControllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLeaveWithoutResettingYourPassword).toCapitalized()),
      child: Scaffold(
        body: Consumer<AuthenticationProvider>(
          builder: (context, provider, _) {
            return CustomFullLoading(
              isShowLoading: provider.isLoading,
              waitForDone: provider.isLoading,
              isShowOpacityBackground: true,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  DefaultSliverAppBar(
                    appBarColor: ColorsManager.grey1,
                    onPressed: () {
                      return Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLeaveWithoutResettingYourPassword).toCapitalized()).then((value) {
                        if(value) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    sliver: SliverToBoxAdapter(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Methods.getText(StringsManager.modifyThePassword).toTitleCase(),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s40),
                            ),
                            const SizedBox(height: SizeManager.s40),

                            // Password *
                            CustomTextFormField(
                              isPasswordField: true,
                              isSupportClearSuffixIcon: false,
                              controller: _textEditingControllerPassword,
                              labelText: '${Methods.getText(StringsManager.password).toTitleCase()} *',
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
                              validator: (value) => Validator.validateConfirmPassword(value, _textEditingControllerPassword.text),
                            ),
                            const SizedBox(height: SizeManager.s40),

                            CustomButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()) {
                                  ResetAccountPasswordParameters parameters = ResetAccountPasswordParameters(
                                    emailAddress: widget.emailAddress,
                                    password: _textEditingControllerPassword.text,
                                  );
                                  MyProviders.authenticationProvider.resetPassword(context: context, resetAccountPasswordParameters: parameters);
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
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerPassword.dispose();
    _textEditingControllerConfirmPassword.dispose();
    super.dispose();
  }
}