import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';

class RevenueListItem extends StatelessWidget {
  final UserModel userModel;

  const RevenueListItem({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () => Methods.routeTo(
        context,
        Routes.walletHistoryScreen,
        arguments: WalletHistoryArgs(
          user: userModel,
          isRevenueOnly: true,
        ),
      ),
      padding: const EdgeInsets.all(SizeManager.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: UserRowWidget(user: userModel),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Center(
                  child: Text(
                    '${userModel.totalRevenues} ${Methods.getText(StringsManager.egp).toUpperCase()}',
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
