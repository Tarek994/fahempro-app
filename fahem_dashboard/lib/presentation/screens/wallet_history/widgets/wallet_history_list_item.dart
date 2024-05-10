import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/account_row_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/date_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/user_row_widget.dart';
import 'package:flutter/material.dart';

class WalletHistoryListItem extends StatelessWidget {
  final WalletHistoryModel walletHistoryModel;
  final Function onEdit;
  final Function onDelete;
  final bool showUser;

  const WalletHistoryListItem({
    super.key,
    required this.walletHistoryModel,
    required this.onEdit,
    required this.onDelete,
    required this.showUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DateWidget(createdAt: walletHistoryModel.createdAt),
              ),
              if(Methods.checkAdminPermission(AdminPermissions.editWalletHistory) || Methods.checkAdminPermission(AdminPermissions.deleteWalletHistory)) ...[
                const SizedBox(width: SizeManager.s5),
                CustomPopupMenu(
                  items: [
                    // if(Methods.checkAdminPermission(AdminPermissions.editWalletHistory)) PopupMenu.edit,
                    if(Methods.checkAdminPermission(AdminPermissions.deleteWalletHistory)) PopupMenu.delete,
                  ],
                  onPressedEdit: () => Methods.routeTo(context, Routes.insertEditWalletHistoryScreen, arguments: walletHistoryModel, then: (walletHistory) => onEdit(walletHistory)),
                  onPressedDelete: () {
                    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                      if(value) {
                        onDelete();
                      }
                    });
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: SizeManager.s10),
          Container(
            padding: const EdgeInsets.all(SizeManager.s10),
            decoration: BoxDecoration(
              color: ColorsManager.grey100,
              borderRadius: BorderRadius.circular(SizeManager.s10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${walletHistoryModel.amount} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(SizeManager.s5),
                      ),
                      child: Text(
                        WalletTransactionType.toText(walletHistoryModel.walletTransactionType),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.medium),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  MyProviders.appProvider.isEnglish ? walletHistoryModel.textEn : walletHistoryModel.textAr,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.medium),
                ),
              ],
            ),
          ),
          if(showUser) ...[
            const SizedBox(height: SizeManager.s10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(walletHistoryModel.user != null) UserRowWidget(user: walletHistoryModel.user!),
                if(walletHistoryModel.account != null) AccountRowWidget(account: walletHistoryModel.account!),
              ],
            ),
          ],
        ],
      ),
    );
  }
}