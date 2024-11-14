import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/constants/app_size.dart';
import 'package:taskapp/common/ui/widgets/custom_text.dart';

import 'package:taskapp/theme/theme_colors.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    required this.text,
    super.onPressed,
    this.color = ThemeColors.primary,
    super.key,
    this.borderRadius,
    this.borderColor,
    this.splashColor,
    this.padding,
    this.elevation,
    this.textWeight,
    this.textSize,
    this.textColor,
    this.buttonSize,
    this.withIcon = false,
    this.assetName = "",
  }) : super(
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(buttonSize),
              elevation: WidgetStateProperty.all(elevation ?? 0),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(20),
                  side: BorderSide(
                      color: borderColor ?? color ?? ThemeColors.white),
                ),
              ),
              overlayColor: WidgetStateProperty.all<Color>(
                  splashColor ?? ThemeColors.white.withOpacity(0.1)),
              backgroundColor:
                  WidgetStateProperty.all<Color>(color ?? ThemeColors.white),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return ThemeColors.white;
                  }
                  return ThemeColors.primary;
                },
              ),
            ),
            child: SizedBox(
              child: withIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          assetName,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                            ThemeColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        gapW4,
                        CustomText(
                          text: text,
                          color: ThemeColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )
                  : Center(
                      child: FittedBox(
                        child: CustomText(
                          text: text,
                          color: textColor ?? ThemeColors.white,
                          fontWeight: textWeight ?? FontWeight.w900,
                          fontSize: textSize ?? 14,
                        ),
                      ),
                    ),
            ));

  final String text;
  final Color? color;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? splashColor;
  final EdgeInsets? padding;
  final double? elevation;
  final FontWeight? textWeight;
  final double? textSize;
  final Color? textColor;
  final Size? buttonSize;
  final bool withIcon;
  final String assetName;
}
