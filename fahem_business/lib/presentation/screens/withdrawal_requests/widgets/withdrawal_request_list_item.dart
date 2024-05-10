import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/withdrawal_request_model.dart';
import 'package:fahem_business/presentation/shared/widgets/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WithdrawalRequestListItem extends StatelessWidget {
  final WithdrawalRequestModel withdrawalRequestModel;

  const WithdrawalRequestListItem({
    super.key,
    required this.withdrawalRequestModel,
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
                child: DateWidget(createdAt: withdrawalRequestModel.createdAt),
              ),
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
                  children: [
                    Expanded(
                      child: Text(
                        PaymentType.toText(withdrawalRequestModel.paymentType),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
                      ),
                    ),
                    const SizedBox(width: SizeManager.s10),
                    Row(
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(withdrawalRequestModel.paymentTypeValue),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: withdrawalRequestModel.paymentTypeValue));
                            Methods.showToast(message: Methods.getText(StringsManager.copied).toCapitalized(), showMessage: ShowMessage.success);
                          },
                          // padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                          icon: const Icon(Icons.copy, size: SizeManager.s20),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: SizeManager.s20),
                Text(
                  '${withdrawalRequestModel.balance} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   flex: 2,
              //   child: AccountRowWidget(account: withdrawalRequestModel.account),
              // ),
              // const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SizeManager.s10),
                  decoration: BoxDecoration(
                    color: WithdrawalRequestStatus.getColor(withdrawalRequestModel.withdrawalRequestStatus).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(SizeManager.s10),
                  ),
                  child: Text(
                    WithdrawalRequestStatus.toText(withdrawalRequestModel.withdrawalRequestStatus),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.medium),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          if(withdrawalRequestModel.withdrawalRequestStatus == WithdrawalRequestStatus.rejected && withdrawalRequestModel.reasonOfReject != null) ...[
            const SizedBox(height: SizeManager.s10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SizeManager.s10),
              decoration: BoxDecoration(
                color: ColorsManager.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(SizeManager.s10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white, fontWeight: FontWeightManager.bold),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Text(
                    withdrawalRequestModel.reasonOfReject!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}