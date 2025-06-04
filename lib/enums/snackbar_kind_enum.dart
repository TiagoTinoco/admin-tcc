import 'package:admin_tcc/config/custom_colors.dart';
import 'package:flutter/material.dart';

enum SnackBarKindEnum {
  warning,
  success,
  info;

  IconData get icon {
    switch (this) {
      case SnackBarKindEnum.warning:
        return Icons.warning_rounded;
      case SnackBarKindEnum.success:
        return Icons.check_circle_rounded;
      case SnackBarKindEnum.info:
        return Icons.info_rounded;
    }
  }

  Color get color {
    switch (this) {
      case SnackBarKindEnum.warning:
        return CustomColors.warning;
      case SnackBarKindEnum.success:
        return CustomColors.success;
      case SnackBarKindEnum.info:
        return CustomColors.info;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case SnackBarKindEnum.warning:
        return CustomColors.warningLight;
      case SnackBarKindEnum.success:
        return CustomColors.successLight;
      case SnackBarKindEnum.info:
        return CustomColors.infoLight;
    }
  }
}
