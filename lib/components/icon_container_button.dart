import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomIconContainerButton extends StatelessWidget {
  const CustomIconContainerButton({
    super.key,
    required this.icon,
    required this.iconSize,
    this.backgroundColor,
    this.onPress,
    this.iconColor,
  });

  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(
          top: 13,
          left: 14,
          right: 12,
          bottom: 13,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? CustomColors.black,
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: CustomColors.black.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? CustomColors.black,
        ),
      ),
    );
  }
}
