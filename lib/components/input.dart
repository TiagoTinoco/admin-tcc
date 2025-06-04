import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/enums/input_kind_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.maxLines = 1,
    this.fontSize = 14,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.sufixIcon,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.inputKind = InputKindEnum.border,
    this.letterSpacing,
    this.maxLength,
    this.obscureText = false,
    this.inputFormatters,
    this.borderColor,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onFieldSubmitted,
    this.hintText,
  });

  final int maxLines;
  final double fontSize;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final InputKindEnum inputKind;
  final double? letterSpacing;
  final int? maxLength;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return switch (inputKind) {
      InputKindEnum.border => TextFormField(
          maxLines: maxLines,
          keyboardType: textInputType,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: letterSpacing,
          ),
          maxLength: maxLength,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
          controller: controller,
          obscuringCharacter: '*',
          validator: validator,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: CustomColors.black,
            ),
            contentPadding: EdgeInsets.zero,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1.5,
                color: borderColor ?? CustomColors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1.2,
                color: CustomColors.black,
              ),
            ),
            errorStyle: TextStyle(
              color: CustomColors.warning,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      InputKindEnum.invisible => TextFormField(
          maxLines: maxLines,
          keyboardType: textInputType,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: letterSpacing,
          ),
          maxLength: maxLength,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          enabled: enabled,
          inputFormatters: inputFormatters,
          validator: validator,
          obscuringCharacter: '*',
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            suffixIcon: sufixIcon,
            errorStyle: TextStyle(
              color: CustomColors.warning,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
    };
  }
}
