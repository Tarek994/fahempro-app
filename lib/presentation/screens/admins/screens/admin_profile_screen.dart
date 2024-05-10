import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/admin_model.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/card_info.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';

class AdminProfileScreen extends StatelessWidget {
  final AdminModel adminModel;

  const AdminProfileScreen({
    super.key,
    required this.adminModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultSliverAppBar(customTitle: adminModel.fullName),
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
                          image: adminModel.coverImage,
                          imageDirectory: ApiConstants.adminsDirectory,
                          color1: adminModel.coverImage == null ? ColorsManager.white : null,
                          width: double.infinity,
                          height: SizeManager.s200,
                          isShowFullImageScreen: true,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: ImageWidget(
                              image: adminModel.personalImage,
                              imageDirectory: ApiConstants.adminsDirectory,
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
                    fullName: adminModel.fullName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Info
                  Padding(
                    padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
                    child: Column(
                      children: [
                        CardInfo(
                          icon: FontAwesomeIcons.solidEnvelope,
                          title: Methods.getText(StringsManager.emailAddress).toTitleCase(),
                          value: adminModel.emailAddress,
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(adminModel.phoneNumber != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.phone,
                            title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                            value: adminModel.phoneNumber ?? Methods.getText(StringsManager.notFound).toTitleCase(),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(adminModel.gender != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.venusMars,
                            title: Methods.getText(StringsManager.gender).toTitleCase(),
                            value: adminModel.gender == null ? Methods.getText(StringsManager.notFound).toTitleCase() : Gender.toText(adminModel.gender!),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(adminModel.birthDate != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.calendar,
                            title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                            value: adminModel.birthDate == null ? Methods.getText(StringsManager.notFound).toTitleCase() : Methods.formatDate(milliseconds: int.parse(adminModel.birthDate!), format: 'd MMMM yyyy'),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.calendar,
                          title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                          value: Methods.formatDate(milliseconds: int.parse(adminModel.createdAt), format: 'd MMMM yyyy'),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(adminModel.bio != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.info,
                            title: Methods.getText(StringsManager.bio).toTitleCase(),
                            value: adminModel.bio ?? Methods.getText(StringsManager.notFound).toTitleCase(),
                          ),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.userCheck,
                          title: Methods.getText(StringsManager.permissions).toTitleCase(),
                          value: adminModel.isSuper ? Methods.getText(StringsManager.allowAllPermissions).toCapitalized() : List.generate(adminModel.permissions.length, (index) {
                            return MyProviders.appProvider.isEnglish ? adminModel.permissions[index].nameEn : adminModel.permissions[index].nameAr;
                          }).join(' - '),
                        ),
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