import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  final AccountModel accountModel;

  const ExpenseListItem({
    super.key,
    required this.accountModel,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        WithdrawalRequestsArgs args = WithdrawalRequestsArgs(
          account: accountModel,
        );
        return Methods.routeTo(context, Routes.withdrawalRequestsScreen, arguments: args);
      },
      padding: const EdgeInsets.all(SizeManager.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AccountRowWidget(account: accountModel),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Center(
                  child: Text(
                    '${accountModel.totalExpenses} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
