import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';

class ProfileCard extends StatelessWidget {
  final Function() onTap;

  const ProfileCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, _) {
        if(authenticationProvider.currentUser == null) {
          return const SizedBox();
        }
        return Hover(
          onTap: () => onTap(),
          color: ColorsManager.white,
          child: Row(
            children: [
              ImageWidget(
                image: authenticationProvider.currentUser!.personalImage,
                imageDirectory: ApiConstants.usersDirectory,
                defaultImage: ImagesManager.defaultAvatar,
                width: SizeManager.s50,
                height: SizeManager.s50,
                boxShape: BoxShape.circle,
                isShowFullImageScreen: false,
              ),
              const SizedBox(width: SizeManager.s15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NameWidget(
                      fullName: authenticationProvider.currentUser!.fullName,
                      isFeatured: authenticationProvider.currentUser!.isFeatured,
                      isSupportFeatured: true,
                      // isOverflow: true,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.semiBold),
                    ),
                    const SizedBox(height: SizeManager.s5),
                    Text(
                      authenticationProvider.currentUser!.emailAddress ?? '',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}