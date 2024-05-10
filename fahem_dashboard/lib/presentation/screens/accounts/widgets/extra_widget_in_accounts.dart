import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/screens/accounts/controllers/accounts_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';

class ExtraWidgetInAccounts extends StatelessWidget {
  const ExtraWidgetInAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsProvider>(
      builder: (context, accountsProvider, _) {
        return Container(
          padding: const EdgeInsets.only(top: SizeManager.s16, left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s8),
          color: ColorsManager.white,
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    accountsProvider.accountStatus = null;
                    await accountsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.all).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: accountsProvider.accountStatus == null ? ColorsManager.lightPrimaryColor : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    accountsProvider.accountStatus = AccountStatus.active;
                    await accountsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.active).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: accountsProvider.accountStatus == AccountStatus.active ? ColorsManager.green : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    accountsProvider.accountStatus = AccountStatus.pending;
                    await accountsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.pending).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: accountsProvider.accountStatus == AccountStatus.pending ? ColorsManager.amber : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  onPressed: () async {
                    accountsProvider.accountStatus = AccountStatus.rejected;
                    await accountsProvider.reFetchData();
                  },
                  buttonType: ButtonType.text,
                  text: Methods.getText(StringsManager.rejected).toCapitalized(),
                  width: double.infinity,
                  height: SizeManager.s35,
                  buttonColor: accountsProvider.accountStatus == AccountStatus.rejected ? ColorsManager.red : ColorsManager.lightPrimaryColor.withOpacity(0.4),
                  fontSize: SizeManager.s12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}