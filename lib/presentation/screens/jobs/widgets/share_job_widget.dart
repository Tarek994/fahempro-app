import 'dart:io';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';

class ShareJobWidget extends StatelessWidget {
  final JobModel jobModel;

  const ShareJobWidget({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s16),
      margin: const EdgeInsets.only(bottom: SizeManager.s10),
      width: double.infinity,
      color: MyProviders.appProvider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
      child: Row(
        children: [
          Text(
            Methods.getText(StringsManager.shareTheAd).toTitleCase(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: SizeManager.s20),
          Consumer<AuthenticationProvider>(
            builder: (context, authenticationProvider, _) {
              return InkWell(
                onTap: () async {
                  if(Platform.isAndroid) {await Share.share('${jobModel.jobTitle}\n\n${jobModel.details}\n\n${ConstantsManager.fahemPlayStoreUrl}');}
                  if(Platform.isIOS) {await Share.share('${jobModel.jobTitle}\n\n${jobModel.details}\n\n${ConstantsManager.fahemAppStoreUrl}');}
                },
                child: Image.asset(
                  IconsManager.share,
                  width: SizeManager.s20,
                  height: SizeManager.s20,
                  color: MyProviders.appProvider.isLight ? ColorsManager.black : ColorsManager.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
