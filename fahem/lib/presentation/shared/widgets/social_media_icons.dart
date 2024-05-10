import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/presentation/shared/controllers/social_media_provider.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:provider/provider.dart';

class SocialMediaIcons extends StatelessWidget {
  final bool showTitle;
  final bool ignoreEmail;
  final bool ignorePhone;

  const SocialMediaIcons({
    super.key,
    this.showTitle = false,
    this.ignoreEmail = false,
    this.ignorePhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialMediaProvider>(
      builder: (context, socialMediaProvider, child) {
        List<SocialMediaModel> socialMedia = [...socialMediaProvider.socialMedia];
        if(ignoreEmail) {
          socialMedia.removeWhere((element) => element.link.endsWith(ConstantsManager.emailAddressSuffix));
        }
        if(ignorePhone) {
          socialMedia.removeWhere((element) => element.link.startsWith(ConstantsManager.phoneNumberPrefix));
        }
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              if(showTitle && socialMedia.isNotEmpty) ...[
                Text(
                  Methods.getText(StringsManager.socialMedia).toCapitalized(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: SizeManager.s10),
              ],
              Wrap(
                spacing: SizeManager.s15,
                runSpacing: SizeManager.s15,
                children: List.generate(socialMedia.length, (index) {
                  SocialMediaModel socialMediaModel = socialMedia[index];
                  return GestureDetector(
                    onTap: () async => await Methods.openUrl(url: socialMediaModel.link),
                    child: ImageWidget(
                      image: socialMediaModel.image,
                      imageDirectory: ApiConstants.socialMediaDirectory,
                      width: SizeManager.s25,
                      height: SizeManager.s25,
                      isShowFullImageScreen: false,
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}