import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_business/presentation/shared/widgets/required_text_widget.dart';

enum ButtonType {
  text, icon, image,
  preIcon, postIcon,
  preSpacerIcon, postSpacerIcon,
  preImage, postImage,
  preSpacerImage, postSpacerImage,
  postSpacerText,
  preIconPostSpacerText,
  preIconPostClickableIcon,
  prePersonalImageNetworkPostSpacer,
}

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final Color buttonColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final RoundedRectangleBorder? roundedRectangleBorder;
  final double elevation;
  final bool isCircleBorder;
  final String text;
  final TextStyle? textStyle;
  final Color textColor;
  final double fontSize;
  final FontWeight? textFontWeight;
  final double? textHeight;
  final IconData? iconData;
  final Color iconColor;
  final double iconSize;
  final double centerSpace;
  final String? imageName;
  final String? imageDirectory;
  final String? defaultImage;
  final Color? imageColor;
  final double imageSize;
  final String spacerText;
  final TextStyle? spacerTextStyle;
  final Function()? onPressedPostClickableIcon;
  final IconData? postClickableIconData;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final bool isLoading;
  final bool isRequired;
  final MainAxisAlignment mainAxisAlignment;
  final TextDirection? textDirection;

  const CustomButton({
    super.key,
    required this.buttonType,
    this.onPressed,
    this.width,
    this.height = SizeManager.s45,
    this.buttonColor = ColorsManager.lightPrimaryColor,
    this.borderColor = Colors.transparent,
    this.borderRadius = SizeManager.s10,
    this.borderWidth = SizeManager.s1,
    this.roundedRectangleBorder,
    this.elevation = SizeManager.s0,
    this.isCircleBorder = false,
    this.text = ConstantsManager.empty,
    this.textStyle,
    this.textColor = ColorsManager.white,
    this.fontSize = SizeManager.s14,
    this.textFontWeight,
    this.textHeight,
    this.iconData,
    this.iconColor = ColorsManager.white,
    this.iconSize = SizeManager.s16,
    this.centerSpace = SizeManager.s10,
    this.imageName,
    this.imageDirectory,
    this.defaultImage,
    this.imageColor,
    this.imageSize = SizeManager.s16,
    this.spacerText = ConstantsManager.empty,
    this.spacerTextStyle,
    this.onPressedPostClickableIcon,
    this.postClickableIconData,
    this.padding,
    this.visualDensity,
    this.isLoading = false,
    this.isRequired = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.textDirection,
  });

  Widget _loadingWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: SizeManager.s30,
          height: SizeManager.s30,
          child: Padding(
            padding: EdgeInsets.all(SizeManager.s6),
            child: CircularProgressIndicator(
              color: ColorsManager.white,
              strokeWidth: SizeManager.s2,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          padding: padding,
          visualDensity: visualDensity,
          onPressed: isLoading ? () {} : onPressed ?? () {},
          minWidth: width,
          height: height,
          color: buttonColor,
          elevation: elevation,
          hoverElevation: elevation,
          focusElevation: elevation,
          highlightElevation: elevation,
          shape: isCircleBorder ? const CircleBorder() : roundedRectangleBorder ?? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: isRequired ? ColorsManager.red700 : borderColor, width: borderWidth),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: isLoading ? _loadingWidget() : _getButton(context),
        ),
        if(isRequired) const RequiredTextWidget(),
      ],
    );
  }

  Widget _getButton(BuildContext context) {
    switch(buttonType) {
      case ButtonType.text: return _textButton(context);
      case ButtonType.icon: return _iconButton(context);
      case ButtonType.image: return _imageButton(context);
      case ButtonType.preIcon: return _preIconButton(context);
      case ButtonType.postIcon: return _postIconButton(context);
      case ButtonType.preSpacerIcon: return _preSpacerIconButton(context);
      case ButtonType.postSpacerIcon: return _postSpacerIconButton(context);
      case ButtonType.preImage: return _preImageButton(context);
      case ButtonType.postImage: return _postImageButton(context);
      case ButtonType.preSpacerImage: return _preSpacerImageButton(context);
      case ButtonType.postSpacerImage: return _postSpacerImageButton(context);
      case ButtonType.postSpacerText: return _postSpacerTextButton(context);
      case ButtonType.preIconPostSpacerText: return _preIconPostSpacerTextButton(context);
      case ButtonType.preIconPostClickableIcon: return _preIconPostClickableIconButton(context);
      case ButtonType.prePersonalImageNetworkPostSpacer: return _prePersonalImageNetworkPostSpacerButton(context);
      default: return Container();
    }
  }

  Widget _textButton(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      textDirection: textDirection,
      style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
    );
  }

  Widget _iconButton(BuildContext context) {
    return Icon(iconData, color: iconColor, size: iconSize);
  }

  Widget _imageButton(BuildContext context) {
    return Image.asset(imageName!, color: imageColor, width: imageSize, height: imageSize);
  }

  Widget _preIconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: iconColor, size: iconSize),
        SizedBox(width: centerSpace),
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _postIconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
        SizedBox(width: centerSpace),
        Icon(iconData, color: iconColor, size: iconSize),
      ],
    );
  }

  Widget _preSpacerIconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(iconData, color: iconColor, size: iconSize),
        SizedBox(width: centerSpace),
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _postSpacerIconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
        SizedBox(width: centerSpace),
        Icon(iconData, color: iconColor, size: iconSize),
      ],
    );
  }

  Widget _preImageButton(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imageName!, color: imageColor, width: imageSize, height: imageSize),
        SizedBox(width: centerSpace),
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _postImageButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
        SizedBox(width: centerSpace),
        Image.asset(imageName!, color: imageColor, width: imageSize, height: imageSize),
      ],
    );
  }

  Widget _preSpacerImageButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(imageName!, color: imageColor, width: imageSize, height: imageSize),
        SizedBox(width: centerSpace),
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _postSpacerImageButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
        SizedBox(width: centerSpace),
        Image.asset(imageName!, color: imageColor, width: imageSize, height: imageSize),
      ],
    );
  }

  Widget _postSpacerTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
            ),
          ),
        ),
        SizedBox(width: centerSpace),
        Flexible(
          child: Text(
            spacerText,
            style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
          ),
        ),
      ],
    );
  }

  Widget _preIconPostSpacerTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: iconColor, size: iconSize),
        SizedBox(width: centerSpace),
        Expanded(
          child: Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.displayLarge!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
          ),
        ),
        SizedBox(width: centerSpace),
        Text(
          spacerText,
          style: spacerTextStyle,
        ),
      ],
    );
  }

  Widget _preIconPostClickableIconButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: iconColor, size: iconSize),
        SizedBox(width: centerSpace),
        Expanded(
          child: Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.displayLarge!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
          ),
        ),
        SizedBox(width: centerSpace),
        IconButton(
          onPressed: onPressedPostClickableIcon,
          padding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          icon: Icon(postClickableIconData, color: ColorsManager.grey),
        ),
      ],
    );
  }

  Widget _prePersonalImageNetworkPostSpacerButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageWidget(
          image: imageName,
          imageDirectory: imageDirectory,
          defaultImage: defaultImage,
          width: imageSize,
          height: imageSize,
          boxShape: BoxShape.circle,
          isShowFullImageScreen: false,
        ),
        SizedBox(width: centerSpace),
        Expanded(
          child: Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.displayLarge!.copyWith(color: textColor, fontSize: fontSize, fontWeight: textFontWeight, height: textHeight),
          ),
        ),
      ],
    );
  }
}