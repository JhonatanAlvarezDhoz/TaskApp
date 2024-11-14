import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/widgets/custom_text.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.primary),
          width: size.width * 0.1,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Image.asset(
            "assets/images/logoTA.png",
            width: 30,
            height: 30,
          ),
        ),
        CustomText(
          text: "Task App",
          fontSize: 20,
          color: ThemeColors.primary,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          width: size.width * 0.2,
        )
      ],
    );
  }
}
