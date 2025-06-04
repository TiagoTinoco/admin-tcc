import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.iconSize,
    this.onPress,
    this.iconColor,
  });

  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor ?? CustomColors.black,
      ),
    );
  }
}
