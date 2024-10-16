import 'package:flutter/material.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      border: _border(),
      focusedBorder: _border(AppPallete.greyColor),
      contentPadding: const EdgeInsets.all(27),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
