import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:admin_tcc/config/custom_colors.dart';
import 'package:admin_tcc/enums/snackbar_kind_enum.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String description,
  required SnackBarKindEnum snackbarKind,
  String? title,
  Duration duration = const Duration(seconds: 4),
}) {
  Flushbar(
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(12),
    backgroundColor: snackbarKind.backgroundColor,
    flushbarPosition: FlushbarPosition.TOP,
    duration: duration,
    icon: Icon(
      snackbarKind.icon,
      color: snackbarKind.color,
    ),
    leftBarIndicatorColor: snackbarKind.color,
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null && title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              color: snackbarKind.color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 12,
          ),
        ),
      ],
    ),
  ).show(context);
}
