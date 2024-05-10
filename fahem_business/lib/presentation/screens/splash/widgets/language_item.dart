import 'package:fahem_business/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/controllers/app_provider.dart';

class LanguageItem extends StatelessWidget {
  final String image;
  final String text;
  final bool language;

  const LanguageItem({
    super.key,
    required this.image,
    required this.text,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Hover(
          color: provider.isLight ? ColorsManager.white : ColorsManager.darkPrimaryColor,
          border: Border.all(
            color: provider.isEnglish == language ? ColorsManager.lightPrimaryColor
                : provider.isLight ? ColorsManager.grey2 : ColorsManager.darkPrimaryColor,
            width: SizeManager.s2,
          ),
          onTap: () => provider.changeIsEnglish(language),
          child: Column(
            children: [
              Image.asset(image, width: SizeManager.s120, height: SizeManager.s100),
              Text(
                Methods.getText(text).toCapitalized(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}