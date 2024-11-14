import 'package:flutter/material.dart';
import 'package:taskapp/theme/theme_colors.dart';

/// Defines a custom `ThemeData` object for the application.
/// This theme defines several visual attributes such as colors extracted from
/// the `ThemeColors` class, typography and styles.
ThemeData customTheme = ThemeData(
  fontFamily: 'Poppins',
  useMaterial3: true,
  primaryColor: ThemeColors.primary,
  primaryColorLight: ThemeColors.primaryLight,
  scaffoldBackgroundColor: ThemeColors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.tertiary),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: ThemeColors.tertiary),
    bodyLarge: TextStyle(color: ThemeColors.tertiary),
  ),
  buttonTheme: const ButtonThemeData(buttonColor: ThemeColors.primary),
);
