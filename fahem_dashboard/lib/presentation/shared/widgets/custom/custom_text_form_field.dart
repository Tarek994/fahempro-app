import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autofocus;
  final bool expands;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final Color cursorColor;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextStyle? style;
  final Color textColor;
  final double? textHeight;
  final double borderRadius;
  final Color borderColor;
  final Color errorBorderColor;
  final Color enabledBorderColor;
  final Color fillColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color labelColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color hintColor;
  final TextStyle? errorStyle;
  final double? errorHeight;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final IconData? prefixIconData;
  final double prefixIconSize;
  final Color prefixIconColor;
  final bool isSupportClearPrefixIcon;
  final Widget? suffixIcon;
  final IconData? suffixIconData;
  final double suffixIconSize;
  final Color suffixIconColor;
  final bool isSupportClearSuffixIcon;
  final Function? onClickClearIcon;
  final bool isPasswordField;
  final Color unFocusColor;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
    this.expands = false,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.cursorColor = ColorsManager.black,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.style,
    this.textColor = ColorsManager.black,
    this.textHeight,
    this.borderRadius = SizeManager.s10,
    this.borderColor = ColorsManager.lightPrimaryColor,
    this.errorBorderColor = ColorsManager.red,
    this.enabledBorderColor = ColorsManager.grey300,
    this.fillColor = ColorsManager.white,
    this.labelText,
    this.labelStyle,
    this.labelColor = ColorsManager.black,
    this.hintText,
    this.hintStyle,
    this.hintColor = ColorsManager.grey,
    this.errorStyle,
    this.errorHeight,
    this.contentPadding,
    this.prefixIcon,
    this.prefixIconData,
    this.prefixIconSize = SizeManager.s20,
    this.prefixIconColor = ColorsManager.grey,
    this.isSupportClearPrefixIcon = false,
    this.suffixIcon,
    this.suffixIconData,
    this.suffixIconSize = SizeManager.s20,
    this.suffixIconColor = ColorsManager.grey,
    this.isSupportClearSuffixIcon = true,
    this.onClickClearIcon,
    this.isPasswordField = false,
    this.unFocusColor = ColorsManager.grey,
    this.focusNode,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShowClearIcon = false;
  bool isReadyForRefresh = true;
  bool isShowPassword = false;
  bool hasFocus = false;

  _listenerController() {
    if(widget.controller!.text.trim().isEmpty) {
      isShowClearIcon = false;
      isReadyForRefresh = true;
      setState(() {});
    }
    else if(widget.controller!.text.trim().length == 1) {
      isShowClearIcon = true;
      setState(() {});
    }
    else if(widget.controller!.text.trim().length > 1 && isReadyForRefresh) {
      isShowClearIcon = true;
      isReadyForRefresh = false;
      setState(() {});
    }
  }

  _onFocusChange(hasFocus) {
    this.hasFocus = hasFocus;
    if(widget.controller == null) return;
    setState(() {
      if(hasFocus && widget.controller!.text.trim().isNotEmpty) {isShowClearIcon = true;}
      else {isShowClearIcon = false;}
    });
  }

  _onTapField() {
    if(widget.controller == null) return;
    if(widget.controller!.selection == TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.trim().length - 1))) {
      widget.controller!.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.trim().length));
    }
  }

  TextDirection _getTextDirection() {
    if(widget.controller == null || widget.controller!.text.trim().isEmpty) {
      return Methods.getDirection();
    }
    else {
      if(Methods.isRTL(widget.controller!.text.trim())) {
        return TextDirection.rtl;
      }
      else {
        return TextDirection.ltr;
      }
    }
  }

  TextStyle _getTextStyle() {
    if(widget.style != null) {
      return widget.style!;
    }
    else {
      return Theme.of(context).textTheme.displaySmall!.copyWith(
        color: widget.textColor,
        height: widget.textHeight ?? (widget.maxLines != null && widget.maxLines! > 1 ? SizeManager.s1_8 : null),
      );
    }
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.borderColor, width: SizeManager.s1),
    );
  }

  OutlineInputBorder _getEnabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.enabledBorderColor, width: 1),
    );
  }

  OutlineInputBorder _getErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: widget.errorBorderColor, width: SizeManager.s1),
    );
  }

  Widget? _getPrefixIcon() {
    if(widget.isSupportClearPrefixIcon && isShowClearIcon) {
      return Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          onPressed: () {
            setState(() => widget.controller!.clear());
            if(widget.onClickClearIcon != null) widget.onClickClearIcon!();
          },
          icon: Icon(Icons.clear, size: widget.prefixIconSize, color: hasFocus ? widget.prefixIconColor : widget.unFocusColor),
        ),
      );
    }
    if(widget.prefixIconData != null) {
      return Icon(widget.prefixIconData, size: widget.prefixIconSize, color: hasFocus ? widget.prefixIconColor : widget.unFocusColor);
    }
    if(widget.prefixIcon != null) {
      return widget.prefixIcon;
    }
    return null;
  }

  Widget? _getSuffixIcon() {
    if(widget.isSupportClearSuffixIcon && isShowClearIcon) {
      return Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          onPressed: () {
            setState(() => widget.controller!.clear());
            if(widget.onClickClearIcon != null) widget.onClickClearIcon!();
          },
          icon: Icon(Icons.clear, size: widget.suffixIconSize, color: hasFocus ? widget.suffixIconColor : widget.unFocusColor),
        ),
      );
    }
    if(widget.isPasswordField) {
      return Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          onPressed: () => setState(() => isShowPassword = !isShowPassword),
          icon: Icon(
            isShowPassword ? Icons.visibility_off : Icons.visibility, size: widget.suffixIconSize,
            color: hasFocus ? widget.suffixIconColor : widget.unFocusColor,
          ),
        ),
      );
    }
    if(widget.suffixIconData != null) {
      return Icon(widget.suffixIconData, size: widget.suffixIconSize, color: widget.suffixIconColor);
    }
    if(widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if(widget.controller != null) widget.controller!.addListener(_listenerController);
  }

  @override
  void dispose() {
    if(widget.controller != null) widget.controller!.removeListener(_listenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange:_onFocusChange,
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        focusNode: widget.focusNode,
        keyboardType: widget.isPasswordField ? TextInputType.visiblePassword : widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPasswordField ? !isShowPassword : false,
        autofocus: widget.autofocus,
        expands: widget.expands,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textDirection: _getTextDirection(),
        cursorColor: widget.cursorColor,
        onTap: _onTapField,
        onChanged: widget.onChanged,
        validator: widget.validator,
        onSaved: widget.onSaved,
        style: _getTextStyle(),
        decoration: InputDecoration(
          border: _getBorder(),
          disabledBorder: _getBorder(),
          focusedBorder: _getBorder(),
          enabledBorder: _getEnabledBorder(),
          errorBorder: _getErrorBorder(),
          focusedErrorBorder: _getErrorBorder(),
          filled: true,
          fillColor: widget.fillColor,
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: widget.labelStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: hasFocus ? widget.labelColor : widget.unFocusColor),
          hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: widget.hintColor),
          errorStyle: widget.errorStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.red700, height: widget.errorHeight),
          isDense: true,
          contentPadding: const EdgeInsetsDirectional.all(SizeManager.s17_5),
          prefixIcon: _getPrefixIcon(),
          suffixIcon: _getSuffixIcon(),
        ),
      ),
    );
  }
}