import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/shared/widgets/card_info.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/name_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const UserProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultSliverAppBar(customTitle: userModel.fullName),
            SliverToBoxAdapter(
              child: Column(
                children: [

                  // Images
                  SizedBox(
                    width: double.infinity,
                    height: SizeManager.s260,
                    child: Stack(
                      children: [
                        ImageWidget(
                          image: userModel.coverImage,
                          imageDirectory: ApiConstants.usersDirectory,
                          color1: userModel.coverImage == null ? ColorsManager.white : null,
                          width: double.infinity,
                          height: SizeManager.s200,
                          isShowFullImageScreen: true,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: ImageWidget(
                              image: userModel.personalImage,
                              imageDirectory: ApiConstants.usersDirectory,
                              defaultImage: ImagesManager.defaultAvatar,
                              width: SizeManager.s120,
                              height: SizeManager.s120,
                              boxShape: BoxShape.circle,
                              isBorderAroundImage: true,
                              isShowFullImageScreen: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Name
                  NameWidget(
                    fullName: userModel.fullName,
                    isFeatured: userModel.isFeatured,
                    isSupportFeatured: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Info
                  Padding(
                    padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
                    child: Column(
                      children: [
                        if(userModel.phoneNumber != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.phone,
                            title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                            value: userModel.phoneNumber,
                            spacerText: userModel.dialingCode,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.country != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.locationDot,
                            title: Methods.getText(StringsManager.country).toTitleCase(),
                            value: MyProviders.appProvider.isEnglish ? userModel.country!.countryNameEn : userModel.country!.countryNameAr,
                            spacerImage: userModel.country!.flag,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.birthDate != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.calendar,
                            title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                            value: Methods.formatDate(milliseconds: int.parse(userModel.birthDate!), format: 'd MMMM yyyy'),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.gender != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.venusMars,
                            title: Methods.getText(StringsManager.gender).toTitleCase(),
                            value: Gender.toText(userModel.gender!),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.calendar,
                          title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                          value: Methods.formatDate(milliseconds: int.parse(userModel.createdAt), format: 'd MMMM yyyy'),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(userModel.bio != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.info,
                            title: Methods.getText(StringsManager.bio).toTitleCase(),
                            value: userModel.bio ?? Methods.getText(StringsManager.notFound).toTitleCase(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}