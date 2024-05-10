import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final Object? currentValue;
  final List<String> valuesText;
  final List<Object> valuesObject;
  final bool autofocus;
  final void Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  final Function(Object?)? onSaved;
  final TextStyle? style;
  final Color textColor;
  final double borderRadius;
  final Color borderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color labelColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color hintColor;
  final TextStyle? errorStyle;
  final double? errorHeight;
  final Widget? prefixIcon;
  final IconData? prefixIconData;
  final double prefixIconSize;
  final Color prefixIconColor;
  final Widget? suffixIcon;
  final IconData? suffixIconData;
  final double suffixIconSize;
  final Color suffixIconColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropdownButtonFormField({
    super.key,
    this.currentValue,
    required this.valuesText,
    required this.valuesObject,
    this.autofocus = false,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.style,
    this.textColor = ColorsManager.black,
    this.borderRadius = SizeManager.s10,
    this.borderColor = ColorsManager.grey300,
    this.errorBorderColor = ColorsManager.red,
    this.fillColor = ColorsManager.white,
    this.labelText,
    this.labelStyle,
    this.labelColor = ColorsManager.grey,
    this.hintText,
    this.hintStyle,
    this.hintColor = ColorsManager.grey,
    this.errorStyle,
    this.errorHeight,
    this.prefixIcon,
    this.prefixIconData,
    this.prefixIconSize = SizeManager.s20,
    this.prefixIconColor = ColorsManager.grey,
    this.suffixIcon,
    this.suffixIconData,
    this.suffixIconSize = SizeManager.s20,
    this.suffixIconColor = ColorsManager.lightPrimaryColor,
    this.contentPadding,
  });

  @override
  State<CustomDropdownButtonFormField> createState() => _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState extends State<CustomDropdownButtonFormField> {

  List<DropdownMenuItem<Object>>? _getItems() {
    return List.generate(widget.valuesText.length, (index) => DropdownMenuItem(
      value: widget.valuesObject[index],
      child: Align(
        alignment: MyProviders.appProvider.isEnglish ? Alignment.centerLeft : Alignment.centerRight,
        child: Text(widget.valuesText[index]),
      ),
    ));
  }

  TextStyle _getTextStyle() {
    if(widget.style != null) {
      return widget.style!;
    }
    else {
      return Theme.of(context).textTheme.displaySmall!.copyWith(
        color: widget.textColor,
      );
    }
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.borderColor, width: SizeManager.s1),
    );
  }

  OutlineInputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.errorBorderColor, width: SizeManager.s1),
    );
  }

  Widget? _getPrefixIcon() {
    if(widget.prefixIconData != null) {
      return Icon(widget.prefixIconData, size: widget.prefixIconSize, color: widget.prefixIconColor);
    }
    if(widget.prefixIcon != null) {
      return widget.prefixIcon;
    }
    return null;
  }

  Widget? _getSuffixIcon() {
    if(widget.suffixIconData != null) {
      return Icon(widget.suffixIconData, size: widget.suffixIconSize, color: widget.suffixIconColor);
    }
    if(widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: _getItems(),
      value: widget.currentValue,
      iconEnabledColor: ColorsManager.lightPrimaryColor,
      iconSize: SizeManager.s0,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      borderRadius: BorderRadius.circular(SizeManager.s10),
      style: _getTextStyle(),
      decoration: InputDecoration(
        border: _getBorder(),
        disabledBorder: _getBorder(),
        focusedBorder: _getBorder(),
        enabledBorder: _getBorder(),
        errorBorder: _getErrorBorder(),
        focusedErrorBorder: _getErrorBorder(),
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: widget.labelStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: widget.labelColor),
        hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: widget.hintColor),
        errorStyle: widget.errorStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.red700, height: widget.errorHeight),
        isDense: true,
        contentPadding: widget.contentPadding ?? const EdgeInsetsDirectional.all(SizeManager.s0),
        prefixIcon: _getPrefixIcon(),
        suffixIcon: _getSuffixIcon(),
      ),
    );
  }
}