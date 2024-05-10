import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:flutter/material.dart';

class UserRowWidget extends StatelessWidget {
  final UserModel user;
  final Color? color;
  final TextStyle? style;
  final CrossAxisAlignment crossAxisAlignment;

  const UserRowWidget({
    super.key,
    required this.user,
    this.color,
    this.style,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () => Methods.routeTo(context, Routes.userProfileScreen, arguments: user),
      color: color ?? ColorsManager.grey100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          ImageWidget(
            image: user.personalImage,
            imageDirectory: ApiConstants.usersDirectory,
            defaultImage: ImagesManager.defaultAvatar,
            width: SizeManager.s20,
            height: SizeManager.s20,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: false,
          ),
          const SizedBox(width: SizeManager.s5),
          Flexible(
            child: NameWidget(
              fullName: user.fullName,
              isFeatured: user.isFeatured,
              isSupportFeatured: true,
              // isOverflow: true,
              style: style ?? Theme.of(context).textTheme.bodySmall,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
        ],
      ),
    );
  }
}
