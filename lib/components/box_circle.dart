import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

class BoxCircle extends StatelessWidget {
  const BoxCircle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: CustomColors.primary.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: CustomColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
