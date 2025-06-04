import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.isSOS = false,
    this.onPress,
    this.color = const Color(0xFF333333),
  });

  final IconData icon;
  final String title;
  final Color color;
  final Function()? onPress;
  final bool isSOS;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 24,
            color: color.withOpacity(0.85),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
          trailing: onPress != null
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: color.withOpacity(0.6),
                )
              : isSOS
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CustomColors.warningLight,
                        border: Border.all(
                          color: CustomColors.warning,
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(
                        Icons.warning_rounded,
                        size: 16,
                        color: CustomColors.warning,
                      ),
                    )
                  : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          onTap: onPress,
        ),
        Container(
          height: 1.5,
          color: const Color(0xFFECECEC),
        ),
      ],
    );
  }
}
