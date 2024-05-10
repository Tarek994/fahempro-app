import 'dart:io';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class ImageTypeWidget extends StatefulWidget {
  final dynamic image;
  final String title;
  final String imageDirectory;
  final String? defaultImage;
  final double imageFileBorderRadius;
  final double imageNetworkWidth;
  final double imageNetworkHeight;
  final BoxShape? imageNetworkBoxShape;
  final double? imageNetworkBorderRadius;

  const ImageTypeWidget({
    super.key,
    required this.image,
    required this.title,
    required this.imageDirectory,
    this.defaultImage,
    required this.imageFileBorderRadius,
    required this.imageNetworkWidth,
    required this.imageNetworkHeight,
    this.imageNetworkBoxShape,
    this.imageNetworkBorderRadius,
  });

  @override
  State<ImageTypeWidget> createState() => _ImageTypeWidgetState();
}

class _ImageTypeWidgetState extends State<ImageTypeWidget> {

  Widget _getEmptyImage() {
    return Center(
      child: Text(
        Methods.getText(widget.title).toTitleCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _getNetworkImage({required String imageName}) {
    return ImageWidget(
      image: imageName,
      imageDirectory: widget.imageDirectory,
      defaultImage: widget.defaultImage,
      width: widget.imageNetworkWidth,
      height: widget.imageNetworkHeight,
      boxShape: widget.imageNetworkBoxShape,
      borderRadius: widget.imageNetworkBorderRadius ?? SizeManager.s0,
      isShowFullImageScreen: true,
    );
  }

  Widget _getFileImage({required String imagePath}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.imageFileBorderRadius),
      child: Image.file(File(imagePath), fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.image == null) {
      return _getEmptyImage();
    }
    else if(widget.image is String) {
      return _getNetworkImage(imageName: widget.image);
    }
    else {
      return _getFileImage(imagePath: widget.image.path);
    }
  }
}