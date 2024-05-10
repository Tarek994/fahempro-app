import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/wallet_history_model.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:fahem/presentation/shared/widgets/date_widget.dart';
import 'package:flutter/material.dart';

class WalletHistoryListItem extends StatelessWidget {
  final WalletHistoryModel walletHistoryModel;
  final WalletHistoryProvider walletHistoryProvider;

  const WalletHistoryListItem({super.key, required this.walletHistoryModel, required this.walletHistoryProvider});

  Color _getColor() {
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.chargeWallet) return ColorsManager.green;
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.instantConsultation) return ColorsManager.red;
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.secretConsultation) return ColorsManager.red;
    // if(walletHistoryModel.walletTransactionType == WalletTransactionType.refund) return ColorsManager.green;
    return ColorsManager.black;
  }

  String _getSignSymbol() {
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.chargeWallet) return '+';
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.instantConsultation) return '-';
    if(walletHistoryModel.walletTransactionType == WalletTransactionType.secretConsultation) return '-';
    // if(walletHistoryModel.walletTransactionType == WalletTransactionType.refund) return '+';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.grey1,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DateWidget(createdAt: walletHistoryModel.createdAt),
              ),
              const SizedBox(width: SizeManager.s10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s8, vertical: SizeManager.s4),
                decoration: BoxDecoration(
                  color: _getColor(),
                  borderRadius: BorderRadius.circular(SizeManager.s5),
                ),
                child: Text(
                  WalletTransactionType.toText(walletHistoryModel.walletTransactionType),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Text(
            MyProviders.appProvider.isEnglish ? walletHistoryModel.textEn : walletHistoryModel.textAr,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.medium, height: SizeManager.s1_8),
          ),
          const SizedBox(height: SizeManager.s10),
          Text(
            '${_getSignSymbol()} ${walletHistoryModel.amount} ${Methods.getText(StringsManager.egp).toUpperCase()}',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: _getColor(),
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
