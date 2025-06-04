import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/enums/text_button_kind_enum.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.onPress,
    this.fontSize = 14,
    this.backgroundColor = Colors.white,
    this.textButtonKind = TextButtonKindEnum.small,
    this.color,
    this.hasBorder = false,
    this.contentPadding,
    this.textAlign = TextAlign.start,
  });

  final String title;
  final TextButtonKindEnum textButtonKind;
  final double fontSize;
  final Color? color;
  final Color backgroundColor;
  final bool hasBorder;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onPress;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: textButtonKind == TextButtonKindEnum.large
            ? const EdgeInsets.all(12)
            : contentPadding ??
                const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
        width: textButtonKind.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: hasBorder
              ? Border.all(
                  width: 1.1,
                  color: CustomColors.black,
                )
              : null,
        ),
        child: Text(
          title,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? CustomColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
