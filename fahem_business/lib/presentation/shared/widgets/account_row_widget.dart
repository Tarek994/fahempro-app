import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';

class AccountRowWidget extends StatelessWidget {
  final AccountModel account;

  const AccountRowWidget({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () => Methods.routeTo(context, Routes.accountProfileScreen, arguments: account),
      color: ColorsManager.grey100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            image: account.personalImage,
            imageDirectory: ApiConstants.accountsDirectory,
            defaultImage: ImagesManager.defaultAvatar,
            width: SizeManager.s20,
            height: SizeManager.s20,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: false,
          ),
          const SizedBox(width: SizeManager.s5),
          Flexible(
            child: NameWidget(
              fullName: account.fullName,
              isFeatured: account.isFeatured,
              isSupportFeatured: true,
              isOverflow: true,
              style: Theme.of(context).textTheme.bodySmall,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
        ],
      ),
    );
  }
}
