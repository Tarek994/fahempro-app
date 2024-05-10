import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/services/location_service.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceDetailsArgs args;

  const ServiceDetailsScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyProviders.appProvider.isLight ? ColorsManager.lightPrimaryColor : ColorsManager.white,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: args.color,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(SizeManager.s16),
          child: Padding(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageWidget(
                    image: args.service.serviceImage,
                    imageDirectory: ApiConstants.servicesDirectory,
                    width: SizeManager.s400,
                    height: SizeManager.s400,
                    isShowFullImageScreen: false,
                  ),
                  const SizedBox(height: SizeManager.s50),
                  Column(
                    children: [
                      const SizedBox(height: SizeManager.s20),
                      FittedBox(
                        child: Text(
                          MyProviders.appProvider.isEnglish ? args.service.nameEn : args.service.nameAr,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: args.color,
                            fontSize: SizeManager.s25,
                            fontWeight: FontWeightManager.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: SizeManager.s20),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          MyProviders.appProvider.isEnglish ? args.service.serviceInfoEn : args.service.serviceInfoAr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s2),
                        ),
                      ),
                      const SizedBox(height: SizeManager.s20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: SizeManager.s16),
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s32),
              width: double.infinity,
              child: CustomButton(
                onPressed: () async {
                  if(args.service.label == ConstantsManager.instantLawyerLabel) {
                    await LocationService.checkPermissionAndGetCurrentPosition(context).then((position) {
                      if(position != null) {
                        Methods.routeTo(context, Routes.instantLawyersScreen, arguments: position, isPushReplacement: true);
                      }
                    });
                  }
                  else if(args.service.label == ConstantsManager.instantConsultationsLabel) {
                    Methods.routeTo(context, Routes.instantConsultationFormScreen, isPushReplacement: true, isMustLogin: true);
                  }
                  else if(args.service.label == ConstantsManager.secretConsultationsLabel) {
                    Methods.routeTo(context, Routes.secretConsultationFormScreen, isPushReplacement: true, isMustLogin: true);
                  }
                  else {
                    Methods.routeTo(context, Routes.serviceScreen, arguments: args.service, isPushReplacement: true);
                  }
                },
                buttonType: ButtonType.text,
                text: Methods.getText(StringsManager.startNow).toTitleCase(),
                buttonColor: args.color,
                width: double.infinity,
                textFontWeight: FontWeightManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}