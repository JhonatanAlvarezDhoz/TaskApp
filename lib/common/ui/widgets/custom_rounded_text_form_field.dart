import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomRoundedTextFormField extends StatelessWidget {
  final String name;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? iconRoute;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool isFilled;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final Color? hintColor;
  final Color? errorTextColor;
  final double? maxHeight;
  final double? maxWidth;
  final double borderWidth;
  final double fontSizeHint;
  final double fontSizeLabel;
  final int maxLines;
  final FontWeight fontWeightHint;

  const CustomRoundedTextFormField({
    super.key,
    required this.name,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.isFilled = false,
    this.borderColor,
    this.enabledBorderColor,
    this.hintColor,
    this.errorTextColor,
    this.maxHeight,
    this.maxWidth,
    this.borderWidth = 1.8,
    this.fontSizeHint = 14,
    this.fontSizeLabel = 18,
    this.fontWeightHint = FontWeight.w300,
    required this.maxLines,
    this.iconRoute,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode
          .onUserInteraction, // Cambia este modo según tu preferencia
      maxLines: maxLines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: errorText ?? 'Este campo es obligatorio',
        ),
      ]),
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? 50,
          maxWidth: maxWidth ?? 327,
        ),
        filled: isFilled,
        fillColor: isFilled ? ThemeColors.white : Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSizeHint,
          fontWeight: fontWeightHint,
          color: hintColor,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        prefixIcon: iconRoute != null
            ? Padding(
                padding: const EdgeInsets.all(11.0),
                child: SvgPicture.asset(
                  iconRoute!,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    ThemeColors.ligth,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: borderWidth,
            color: enabledBorderColor ?? ThemeColors.ligth.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: borderWidth,
            color: borderColor ?? ThemeColors.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
