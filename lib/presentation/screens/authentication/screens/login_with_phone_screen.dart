import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/background_widget.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _oldPhoneNumber;

  bool _isActiveSendCodeButton() {
    if(_phoneNumberController.text.trim().length != 11) {
      return false;
    }
    if(MyProviders.authenticationProvider.resendCodeTimer != null && MyProviders.authenticationProvider.resendCodeTimer! > 0) {
      return false;
    }
    return true;
  }

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
        child: Consumer<AuthenticationProvider>(
          builder: (context, authenticationProvider, child) {
            return CustomFullLoading(
              isShowLoading: authenticationProvider.isLoading,
              waitForDone: authenticationProvider.isLoading,
              isShowOpacityBackground: true,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const DefaultSliverAppBar(
                    appBarColor: Colors.transparent,
                  ),
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
                              Methods.getText(StringsManager.loginOrCreateAnAccount),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: SizeManager.s20,
                                fontWeight: FontWeightManager.black,
                              ),
                            ),
                            const SizedBox(height: SizeManager.s20),
                            Text(
                              Methods.getText(StringsManager.weWillSendYouACodeToConfirmYourMobileNumber).toCapitalized(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: SizeManager.s12,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            const SizedBox(height: SizeManager.s20),
                            CustomTextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              labelText: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                              validator: Validator.validatePhoneNumber,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s20),
                                child: Image.asset(FlagsImagesManager.egyptFlag, height: SizeManager.s30, width: SizeManager.s30),
                              ),
                              onChanged: (val) => setState(() {}),
                              onClickClearIcon: () => setState(() {}),
                            ),
                            const SizedBox(height: SizeManager.s10),
                            if(authenticationProvider.resendCodeTimer != null && authenticationProvider.resendCodeTimer! > 0) Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Wrap(
                                spacing: SizeManager.s5,
                                runSpacing: SizeManager.s5,
                                children: [
                                  Text(
                                    Methods.getText(StringsManager.resendCodeIn).toCapitalized(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeightManager.medium),
                                  ),
                                  Text(
                                    Methods.getWordStatusLabel(num: authenticationProvider.resendCodeTimer!, label: WordStatusLabel.second),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: SizeManager.s30),
                            if(authenticationProvider.isVerified && _phoneNumberController.text.trim() == _oldPhoneNumber) CustomButton(
                              buttonType: ButtonType.text,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()) {
                                  authenticationProvider.loginOrRegisterWithPhoneNumber(
                                    context: context,
                                    phoneNumber: _phoneNumberController.text.trim(),
                                  );
                                }
                              },
                              text: Methods.getText(StringsManager.continueText).toTitleCase(),
                              width: double.infinity,
                            )
                            else IgnorePointer(
                              ignoring: !_isActiveSendCodeButton(),
                              child: Opacity(
                                opacity: _isActiveSendCodeButton() ? 1 : ConstantsManager.buttonOpacity,
                                child: CustomButton(
                                  buttonType: ButtonType.text,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()) {
                                      _oldPhoneNumber = _phoneNumberController.text.trim();
                                      await authenticationProvider.sendOtpToVerifyPhone(
                                        context: context,
                                        phoneNumber: _phoneNumberController.text.trim(),
                                      );
                                    }
                                  },
                                  text: Methods.getText(StringsManager.sendCode).toTitleCase(),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
    _phoneNumberController.dispose();
    super.dispose();
  }
}