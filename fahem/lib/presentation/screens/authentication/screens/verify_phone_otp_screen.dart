import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/background_widget.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyPhoneOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerifyPhoneOtpScreen({super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<VerifyPhoneOtpScreen> createState() => _VerifyPhoneOtpScreenState();
}

class _VerifyPhoneOtpScreenState extends State<VerifyPhoneOtpScreen> {
  String? _myOtpCode;

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
    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.doYouWantToLeave).toCapitalized(),
      ),
      child: Scaffold(
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
                      DefaultSliverAppBar(
                        appBarColor: Colors.transparent,
                        onPressed: () {
                          Dialogs.showBottomSheetConfirmation(
                            context: context,
                            message: Methods.getText(StringsManager.doYouWantToLeave).toCapitalized(),
                          ).then((value) {
                            if(value) {Navigator.pop(context);}
                          });
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(SizeManager.s16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Methods.getText(StringsManager.confirmPhoneNumber),
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: SizeManager.s20,
                                  fontWeight: FontWeightManager.black,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s20),
                              Text(
                                Methods.getText(StringsManager.enterThe6DigitCodeSentTo).toCapitalized(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: SizeManager.s12,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              Text(
                                widget.phoneNumber,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: SizeManager.s12,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              const SizedBox(height: SizeManager.s20),

                              // Code Text Field
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: PinCodeTextField(
                                  textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                    color: ColorsManager.black,
                                    fontSize: SizeManager.s26,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                  appContext: context,
                                  keyboardType: TextInputType.number,
                                  animationType: AnimationType.scale,
                                  animationDuration: const Duration(milliseconds: 300),
                                  length: 6,
                                  enableActiveFill: true,
                                  cursorColor: ColorsManager.white,
                                  onChanged: (val) => setState(() => _myOtpCode = val),
                                  pinTheme: PinTheme(
                                    borderWidth: SizeManager.s1,
                                    activeBorderWidth: SizeManager.s1,
                                    disabledBorderWidth: SizeManager.s1,
                                    errorBorderWidth: SizeManager.s1,
                                    inactiveBorderWidth: SizeManager.s1,
                                    selectedBorderWidth: SizeManager.s2,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(SizeManager.s5),
                                    fieldWidth: ((MediaQuery.of(context).size.width - 32 - 32) / 6) > 50 ? SizeManager.s50 : (MediaQuery.of(context).size.width - 32 - 32) / 6,
                                    fieldHeight: SizeManager.s50,
                                    inactiveFillColor: ColorsManager.white,
                                    inactiveColor: ColorsManager.grey3,
                                    activeFillColor: ColorsManager.white,
                                    activeColor: ColorsManager.lightPrimaryColor,
                                    selectedFillColor: ColorsManager.white,
                                    selectedColor: ColorsManager.lightPrimaryColor,
                                  ),
                                ),
                              ),

                              // Button
                              IgnorePointer(
                                ignoring: !(_myOtpCode != null && _myOtpCode!.length == 6),
                                child: Opacity(
                                  opacity: (_myOtpCode != null && _myOtpCode!.length == 6) ? 1 : ConstantsManager.buttonOpacity,
                                  child: CustomButton(
                                    buttonType: ButtonType.text,
                                    onPressed: () async => await MyProviders.authenticationProvider.verifyOtp(
                                      context: context,
                                      verificationId: widget.verificationId,
                                      phoneNumber: widget.phoneNumber,
                                      otpCode: _myOtpCode!,
                                    ).then((isSuccess) async {
                                      if(isSuccess != null && isSuccess != false) {
                                        Navigator.pop(context, true);
                                      }
                                    }),
                                    text: Methods.getText(StringsManager.verifyNow).toTitleCase(),
                                    width: double.infinity,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}