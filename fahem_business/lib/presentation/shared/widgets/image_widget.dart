import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class ImageWidget extends StatelessWidget {
  final String? image;
  final String? imageDirectory;
  final String? defaultImage;
  final double width;
  final double height;
  final bool isBorderAroundImage;
  final Color? color1;
  final Color? color2;
  final Color? borderColor1;
  final Color? borderColor2;
  final BoxFit fit;
  final BoxShape? boxShape;
  final double? borderRadius;
  final BorderRadiusGeometry? customBorderRadius;
  final bool isShowFullImageScreen;

  const ImageWidget({
    super.key,
    this.image,
    this.imageDirectory,
    this.defaultImage,
    required this.width,
    required this.height,
    this.isBorderAroundImage = false,
    this.color1,
    this.color2,
    this.borderColor1,
    this.borderColor2,
    this.fit = BoxFit.cover,
    this.boxShape,
    this.borderRadius = SizeManager.s0,
    this.customBorderRadius,
    required this.isShowFullImageScreen,
  });

  BorderRadiusGeometry? _getBorderRadius() {
    if(customBorderRadius != null) {
      return customBorderRadius!;
    }
    else if(boxShape == null) {
      return BorderRadius.circular(borderRadius!);
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(isBorderAroundImage ? SizeManager.s2 : SizeManager.s0),
      decoration: BoxDecoration(
        color: color1,
        shape: boxShape ?? BoxShape.rectangle,
        borderRadius: _getBorderRadius(),
        border: borderColor1 == null ? null : Border.all(color: borderColor1!),
      ),
      child: Container(
        padding: EdgeInsets.all(isBorderAroundImage ? SizeManager.s3 : SizeManager.s0),
        decoration: BoxDecoration(
          color: color2,
          shape: boxShape ?? BoxShape.rectangle,
          borderRadius: _getBorderRadius(),
          border: borderColor2 == null ? null : Border.all(color: borderColor2!),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: boxShape ?? BoxShape.rectangle,
            borderRadius: _getBorderRadius(),
          ),
          child: image == null ? Image.asset(
            defaultImage ?? ImagesManager.logo,
            // fit: BoxFit.fill,
            width: width,
            height: height,
          ) : _CachedNetworkImageWidget(
            image: (imageDirectory == null || image!.startsWith('http')) ? image! : ApiConstants.fileUrl(fileName: '$imageDirectory/${image!}'),
            width: width,
            height: height,
            fit: fit,
            borderRadius: _getBorderRadius(),
            isShowFullImageScreen: isShowFullImageScreen,
          ),
        ),
      ),
    );
  }
}

class _CachedNetworkImageWidget extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final bool isShowFullImageScreen;

  const _CachedNetworkImageWidget({
    required this.image,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    required this.isShowFullImageScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: ColorsManager.grey300,
          highlightColor: ColorsManager.grey100,
          direction: MyProviders.appProvider.isEnglish ? ShimmerDirection.ltr : ShimmerDirection.rtl,
          child: Container(
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: ColorsManager.grey,
              borderRadius: borderRadius,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              ImagesManager.logo,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return GestureDetector(
          onTap: !isShowFullImageScreen ? null : () => Methods.routeTo(context, Routes.showFullImageScreen, arguments: image),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: fit),
              borderRadius: borderRadius,
            ),
          ),
        );
      },
    );
  }
}