import 'package:flutter/material.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomDivider extends StatelessWidget {
  final double marginTopAndbotom;
  const CustomDivider({
    super.key,
    required this.marginTopAndbotom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginTopAndbotom),
      child: Divider(
        color: ThemeColors.whiteGray.withOpacity(0.2),
      ),
    );
  }
}
