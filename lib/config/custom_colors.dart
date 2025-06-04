import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(118, 193, 250, .1),
  100: const Color.fromRGBO(118, 193, 250, .2),
  200: const Color.fromRGBO(118, 193, 250, .3),
  300: const Color.fromRGBO(118, 193, 250, .4),
  400: const Color.fromRGBO(118, 193, 250, .5),
  500: const Color.fromRGBO(118, 193, 250, .6),
  600: const Color.fromRGBO(118, 193, 250, .7),
  700: const Color.fromRGBO(118, 193, 250, .8),
  800: const Color.fromRGBO(118, 193, 250, .9),
  900: const Color.fromRGBO(118, 193, 250, 1),
};

abstract class CustomColors {
  static Color warning = const Color(0xFFC94949);
  static Color warningLight = const Color(0xFFFDEDED);
  static Color success = const Color(0xFF28AF28);
  static Color successLight = const Color(0xFFEDF7ED);
  static Color info = const Color(0xFF498BC9);
  static Color infoLight = const Color(0xFFE8F4FD);
  static Color neutral = const Color(0xFFFCFCFC);
  static Color black = const Color(0xFF333333);
  static Color blackLow = const Color(0xFF444444);
  static MaterialColor primary = MaterialColor(0xFF76c1fa, _swatchOpacity);
  static Color secondary = const Color(0xFF064A7E);
  static Color orange = const Color(0xFFF88731);
}
