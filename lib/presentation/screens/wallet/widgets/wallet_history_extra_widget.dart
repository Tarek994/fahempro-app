import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletHistoryExtraWidget extends StatelessWidget {
  final WalletHistoryProvider walletHistoryProvider;

  const WalletHistoryExtraWidget({super.key, required this.walletHistoryProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightPrimaryColor,
                    border: Border.all(color: ColorsManager.lightPrimaryColor),
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(SizeManager.s10),
                      bottomStart: Radius.circular(SizeManager.s10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Methods.getText(StringsManager.yourCurrentWalletBalance).toCapitalized(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ColorsManager.white,
                        fontSize: SizeManager.s18,
                        fontWeight: FontWeightManager.black
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    border: Border.all(color: ColorsManager.lightPrimaryColor),
                    borderRadius: const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(SizeManager.s10),
                      bottomEnd: Radius.circular(SizeManager.s10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${MyProviders.authenticationProvider.currentUser!.balance} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: SizeManager.s18,
                        fontWeight: FontWeightManager.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          CustomButton(
            onPressed: () => Dialogs.addMoneyToWallet(context: context, walletHistoryProvider: walletHistoryProvider),
            buttonType: ButtonType.preIconPostSpacerText,
            text: Methods.getText(StringsManager.addMoneyToWallet).toCapitalized(),
            iconData: FontAwesomeIcons.circlePlus,
            buttonColor: Colors.transparent,
            textColor: ColorsManager.lightPrimaryColor,
            iconColor: ColorsManager.lightPrimaryColor,
            width: double.infinity,
            height: SizeManager.s35,
            fontSize: SizeManager.s14,
            textFontWeight: FontWeightManager.bold,
          ),
        ],
      ),
    );
  }
}