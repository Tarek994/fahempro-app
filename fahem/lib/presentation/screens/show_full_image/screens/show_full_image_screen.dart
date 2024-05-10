import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/shared/widgets/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:shimmer/shimmer.dart';

class ShowFullImageScreen extends StatelessWidget {
  final String imageUrl;

  const ShowFullImageScreen({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        backgroundColor: ColorsManager.black,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorsManager.black,
            statusBarIconBrightness: Brightness.light,
          ),
          toolbarHeight: SizeManager.s0,
        ),
        body: Stack(
          children: [
            imageUrl.startsWith(imagesPath) ? PhotoView(
              imageProvider: AssetImage(imageUrl),
            ) : CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: ColorsManager.grey300,
                  highlightColor: ColorsManager.grey100,
                  direction: MyProviders.appProvider.isEnglish ? ShimmerDirection.ltr : ShimmerDirection.rtl,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ColorsManager.grey,
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: ColorsManager.grey,
                  child: Container(),
                );
              },
              imageBuilder: (context, imageProvider) {
                return PhotoView(imageProvider: imageProvider);
              },
            ),
            const PositionedDirectional(
              top: SizeManager.s16,
              child: MyBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}