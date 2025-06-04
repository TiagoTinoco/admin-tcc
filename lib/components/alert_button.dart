import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  const AlertButton({
    super.key,
    required this.message,
    required this.messageColor,
    required this.backgroundColor,
    required this.icon,
    required this.onPress,
  });

  final String message;
  final Color messageColor;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1.5,
            color: backgroundColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_rounded,
              color: backgroundColor,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: messageColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              icon,
              color: backgroundColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
