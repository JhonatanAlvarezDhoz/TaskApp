import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {super.key,
      required String message,
      String labelButtom = "ok",
      required Color color,
      super.duration = const Duration(seconds: 2),
      VoidCallback? onOk})
      : super(
            content: CustomText(
              text: message,
              color: ThemeColors.white,
            ),
            backgroundColor: color,
            action: SnackBarAction(
                label: labelButtom,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                }));
}
