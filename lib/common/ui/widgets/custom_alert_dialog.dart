// ignore_for_file: must_be_immutable, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/constants/app_size.dart';
import 'package:taskapp/common/ui/widgets/custom_text.dart';
import 'package:taskapp/common/ui/widgets/outlined_button.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomAlertDialog extends AlertDialog {
  CustomAlertDialog({
    super.key,
    this.icon,
    required this.titleText,
    required this.question,
    required this.textConfirmation,
    required this.onCancel,
    required this.onAction,
  }) : super(
          icon: icon ??
              SvgPicture.asset(
                "assets/icons/news.svg",
                colorFilter: const ColorFilter.mode(
                  ThemeColors.primary,
                  BlendMode.srcIn,
                ),
                width: 40,
              ),
          title: CustomText(
            text: titleText,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            color: ThemeColors.whiteGray,
          ),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                CustomText(
                  text: question,
                  textAlign: TextAlign.center,
                  color: ThemeColors.black.withOpacity(0.4),
                  maxLines: 4,
                  fontSize: 13,
                ),
                gapH20,
                CustomText(
                  text: textConfirmation,
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  color: ThemeColors.whiteGray,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlinedThemeButton(
                  backgroundColor: ThemeColors.darkGray.withOpacity(0.1),
                  text: "Cancelar",
                  textSize: 12,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  textWeight: FontWeight.w400,
                  splashColor: ThemeColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5.0),
                  textColor: ThemeColors.primary,
                  onPressed: onCancel,
                ),
                OutlinedThemeButton(
                  backgroundColor: ThemeColors.primary,
                  text: "Confirmar",
                  textSize: 12,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  textWeight: FontWeight.bold,
                  splashColor: ThemeColors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5.0),
                  textColor: ThemeColors.white,
                  borderColor: ThemeColors.primary,
                  onPressed: onAction,
                ),
              ],
            )
          ],
          backgroundColor: ThemeColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );

  String titleText;
  String question;
  final String textConfirmation;
  VoidCallback onCancel;
  VoidCallback onAction;
  @override
  final Widget? icon;
}
