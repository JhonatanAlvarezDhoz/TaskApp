// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomText extends Text {
  CustomText({
    super.key,
    required this.text,
    this.color = ThemeColors.tertiary,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
    this.maxLines = 1,
    super.textAlign,
    super.overflow,
  }) : super(
          text,
          maxLines: maxLines,
          style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              wordSpacing: 1,
              height: 1.2),
        );

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration decoration;
  @override
  final int maxLines;
}
