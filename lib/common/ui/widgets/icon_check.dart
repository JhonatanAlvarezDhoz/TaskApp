import 'package:flutter/material.dart';
import 'package:taskapp/theme/theme_colors.dart';

class IconCheck extends StatelessWidget {
  final String status;
  const IconCheck({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: status == "completed"
          ? Colors.green.withOpacity(0.7)
          : ThemeColors.tertiary,
      child: status == "completed"
          ? const Icon(
              Icons.check,
              color: ThemeColors.white,
              size: 25,
            )
          : null,
    );
  }
}
