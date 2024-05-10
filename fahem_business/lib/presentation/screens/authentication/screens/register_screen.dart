import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/domain/usecases/authentication_account/register_account_usecase.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/validator.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_business/presentation/shared/widgets/required_text_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerFullName = TextEditingController();
  final TextEditingController _textEditingControllerEmailAddress = TextEditingController();
  final TextEditingController _textEditingControllerPassword = TextEditingController();
  final TextEditingController _textEditingControllerConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    MyProviders.authenticationProvider.resetRegisterScreen();
  }

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
                const DefaultSliverAppBar(
                  title: StringsManager.createAnAccount,
                  appBarColor: ColorsManager.grey1,
                  pinned: false,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Column(
                          //   children: [
                          //     Text(
                          //       Methods.getText(StringsManager.letsStartTogether).toTitleCase(),
                          //       textAlign: TextAlign.center,
                          //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s40),
                          //     ),
                          //     const SizedBox(height: SizeManager.s10),
                          //     Text(
                          //       Methods.getText(StringsManager.searchOrHireInTheFastestAndEasiestWay).toCapitalized(),
                          //       textAlign: TextAlign.center,
                          //       style: Theme.of(context).textTheme.bodyMedium,
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: SizeManager.s50),

                          const SizedBox(height: SizeManager.s20),

                          Column(
                            children: [
                              // Image *
                              Container(
                                decoration: BoxDecoration(
                                  color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
                                  borderRadius: BorderRadius.circular(SizeManager.s50),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                          if(xFile != null) provider.changePersonalImage(xFile);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(SizeManager.s16),
                                          decoration: BoxDecoration(
                                            color: ColorsManager.lightPrimaryColor,
                                            borderRadius: BorderRadius.circular(SizeManager.s50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              Methods.getText(StringsManager.chooseImage).toCapitalized(),
                                              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(SizeManager.s16),
                                        child: Center(
                                          child: Text(
                                            provider.personalImage == null ? ConstantsManager.empty : provider.personalImage.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if(provider.isButtonClicked && provider.personalImage == null) const RequiredTextWidget(),
                              const SizedBox(height: SizeManager.s20),

                              // Main Category *
                              CustomButton(
                                onPressed: () {
                                  Dialogs.mainCategoriesBottomSheet(context: context).then((mainCategory) {
                                    if(mainCategory != null) {
                                      provider.changeMainCategory(mainCategory);
                                    }
                                  });
                                },
                                buttonType: ButtonType.postSpacerText,
                                text: provider.mainCategory == null
                                    ? '${Methods.getText(StringsManager.chooseMainCategory).toCapitalized()} *'
                                    : MyProviders.appProvider.isEnglish ? provider.mainCategory!.nameEn : provider.mainCategory!.nameAr,
                                width: double.infinity,
                                buttonColor: ColorsManager.white,
                                borderColor: ColorsManager.grey300,
                                textColor: provider.mainCategory == null ? ColorsManager.grey : ColorsManager.black,
                                fontSize: SizeManager.s12,
                                isRequired: provider.isButtonClicked && provider.mainCategory == null,
                              ),
                              const SizedBox(height: SizeManager.s20),

                              // Full Name *
                              CustomTextFormField(
                                controller: _textEditingControllerFullName,
                                labelText: '${Methods.getText(StringsManager.name).toTitleCase()} *',
                                prefixIconData: Icons.person_2_outlined,
                                validator: Validator.validateEmpty,
                              ),
                              const SizedBox(height: SizeManager.s20),

                              // Email *
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
                                isSupportClearSuffixIcon: false,
                                controller: _textEditingControllerPassword,
                                labelText: '${Methods.getText(StringsManager.password).toTitleCase()} *',
                                prefixIconData: Icons.lock,
                                validator: Validator.validatePasswordLength,
                              ),
                              const SizedBox(height: SizeManager.s20),

                              // Confirm Password *
                              CustomTextFormField(
                                isPasswordField: true,
                                isSupportClearSuffixIcon: false,
                                controller: _textEditingControllerConfirmPassword,
                                labelText: '${Methods.getText(StringsManager.confirmPassword).toTitleCase()} *',
                                prefixIconData: Icons.lock,
                                validator: (value) => Validator.validateConfirmPassword(value, _textEditingControllerPassword.text),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s30),

                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            runSpacing: 3,
                            spacing: 3,
                            children: [
                              Text(
                                Methods.getText(StringsManager.byClickingOnCreateAnAccountYouAgreeToThe).toCapitalized(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                height: SizeManager.s20,
                                child: TextButton(
                                  onPressed: () => Methods.routeTo(context, Routes.termsOfUseScreen),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    Methods.getText(StringsManager.termsOfUse).toUpperCase(),
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ),
                              Text(
                                Methods.getText(StringsManager.and),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(
                                height: SizeManager.s20,
                                child: TextButton(
                                  onPressed: () => Methods.routeTo(context, Routes.privacyPolicyScreen),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(
                                    Methods.getText(StringsManager.privacyPolicy).toUpperCase(),
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  provider.changeIsButtonClicked(true);
                                  if(_formKey.currentState!.validate() && provider.isAllDataValid()) {
                                    RegisterAccountParameters registerAccountParameters = RegisterAccountParameters(
                                      mainCategoryId: provider.mainCategory!.mainCategoryId,
                                      fullName: _textEditingControllerFullName.text.trim(),
                                      personalImage: null,
                                      emailAddress: _textEditingControllerEmailAddress.text.trim(),
                                      password: _textEditingControllerPassword.text,
                                      signInMethod: SignInMethod.emailAndPassword,
                                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                    );
                                    provider.registerAccount(context: context, registerAccountParameters: registerAccountParameters);
                                  }
                                },
                                buttonType: ButtonType.text,
                                width: SizeManager.s200,
                                text: Methods.getText(StringsManager.createAnAccount).toUpperCase(),
                              ),
                            ],
                          ),
                          const SizedBox(height: SizeManager.s30),

                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                Methods.getText(StringsManager.alreadyHaveAnAccount).toCapitalized(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  provider.resetRegisterScreen();
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  visualDensity: const VisualDensity(horizontal: -4),
                                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5),
                                ),
                                child: Text(
                                  Methods.getText(StringsManager.login).toUpperCase(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ],
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
    _textEditingControllerConfirmPassword.dispose();
    super.dispose();
  }
}