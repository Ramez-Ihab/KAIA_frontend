import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
class KaiaTheme {
static ThemeData get kaiaTheme{
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: whiteColor,
    ),
  );
}
}