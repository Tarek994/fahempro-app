import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationCode;

  const OtpScreen({
    super.key,
    required this.verificationCode,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String myVerificationCode = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.doYouWantToLeaveWithoutResettingYourPassword).toCapitalized(),
      ),
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
                    appBarColor: Colors.transparent,
                    onPressed: () {
                      return Dialogs.showBottomSheetConfirmation(
                        context: context,
                        message: Methods.getText(StringsManager.doYouWantToLeaveWithoutResettingYourPassword).toCapitalized(),
                      ).then((value) {
                        if(value) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: SizeManager.s20),
                          Text(
                            Methods.getText(StringsManager.enterTheConfirmationCode).toTitleCase(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s40),
                          ),
                          const SizedBox(height: SizeManager.s20),
                          Text(
                            Methods.getText(StringsManager.enterTheConfirmationNumberThatYouReceivedInTheMessage).toCapitalized(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: SizeManager.s40),

                          // Code Text Field
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return PinCodeTextField(
                                  textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.white, fontSize: SizeManager.s20, fontWeight: FontWeightManager.black),
                                  appContext: context,
                                  keyboardType: TextInputType.number,
                                  animationType: AnimationType.scale,
                                  animationDuration: const Duration(milliseconds: 300),
                                  length: 6,
                                  enableActiveFill: true,
                                  cursorColor: ColorsManager.lightSecondaryColor,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  separatorBuilder: (context, index) => const SizedBox(width: SizeManager.s10),
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(SizeManager.s5),
                                    fieldWidth: ((constraints.maxWidth - 50) / 6) > 50 ? SizeManager.s50 : (constraints.maxWidth - 50) / 6,
                                    fieldHeight: SizeManager.s50,
                                    activeFillColor: ColorsManager.lightPrimaryColor,
                                    activeColor: ColorsManager.lightPrimaryColor,
                                    inactiveFillColor: ColorsManager.white,
                                    inactiveColor: ColorsManager.grey200,
                                    selectedFillColor: ColorsManager.white,
                                    selectedColor: ColorsManager.grey200,
                                  ),
                                  onChanged: (val) {
                                    myVerificationCode = val;
                                    setState(() => val.length == 6);
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: SizeManager.s30),

                          CustomButton(
                            onPressed: () {
                              if(widget.verificationCode == myVerificationCode) {
                                Navigator.pop(context, true);
                              }
                              else {
                                Dialogs.showBottomSheetMessage(
                                  context: context,
                                  message: Methods.getText(StringsManager.theVerificationCodeIsIncorrect).toCapitalized(),
                                );
                              }
                            },
                            buttonType: ButtonType.text,
                            text: Methods.getText(StringsManager.continueText).toUpperCase(),
                            buttonColor: ColorsManager.lightPrimaryColor,
                            width: double.infinity,
                          ),
                        ],
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
}