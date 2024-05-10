import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/services/location_service.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';

class LocationMsgBtmSheet extends StatelessWidget {
  final String title;
  final String message;

  const LocationMsgBtmSheet({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(ImagesManager.location, height: SizeManager.s200),
          ),
          const SizedBox(height: SizeManager.s20),
          Text(
            Methods.getText(title).toCapitalized(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.semiBold),
          ),
          const SizedBox(height: SizeManager.s20),
          Text(
            Methods.getText(message).toCapitalized(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: SizeManager.s20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonType: ButtonType.text,
                  onPressed: () {
                    Navigator.pop(context);
                    LocationService.openLocationSettings();
                  },
                  text: Methods.getText(StringsManager.ok).toUpperCase(),
                  width: double.infinity,
                  height: SizeManager.s40,
                ),
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: CustomButton(
                  buttonType: ButtonType.text,
                  onPressed: () => Navigator.pop(context),
                  text: Methods.getText(StringsManager.cancel).toUpperCase(),
                  width: double.infinity,
                  height: SizeManager.s40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}