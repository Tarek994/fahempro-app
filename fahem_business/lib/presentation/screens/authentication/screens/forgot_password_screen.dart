import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerEmailAddress = TextEditingController();

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
                const DefaultSliverAppBar(appBarColor: ColorsManager.grey1),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: SizeManager.s20),
                          Text(
                            Methods.getText(StringsManager.forgotPassword).toTitleCase(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s40),
                          ),
                          const SizedBox(height: SizeManager.s20),
                          Text(
                            Methods.getText(StringsManager.typeYourEmailAddressAndYouWillReceiveAConfirmationCode).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          // Email Address *
                          CustomTextFormField(
                            controller: _textEditingControllerEmailAddress,
                            keyboardType: TextInputType.emailAddress,
                            labelText: '${Methods.getText(StringsManager.emailAddress).toTitleCase()} *',
                            prefixIconData: Icons.email,
                            validator: Validator.validateEmailAddress,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()) {
                                MyProviders.authenticationProvider.sendOtpToResetPassword(
                                  context: context,
                                  emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                );
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
    _textEditingControllerEmailAddress.dispose();
    super.dispose();
  }
}