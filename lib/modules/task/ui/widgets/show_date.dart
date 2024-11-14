import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/helpers/formater.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/theme/theme_colors.dart';

class ShowDate extends StatelessWidget {
  const ShowDate({
    super.key,
    required this.width,
    required this.task,
    this.fontSizesitle,
    this.fontSizeContent,
    this.margin,
    this.labelHeight,
  });

  final double width;
  final Task task;
  final double? fontSizesitle;
  final double? fontSizeContent;
  final Widget? margin;
  final double? labelHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _LabelDate(
          width: width,
          fontSizesitle: fontSizesitle,
          title: "Creado:",
          content: task.createdAt,
          fontSizeContent: fontSizeContent,
          labelHeight: labelHeight,
        ),
        if (margin != null) margin!,
        if (task.completedAt != null)
          _LabelDate(
            width: width,
            fontSizesitle: fontSizesitle,
            title: "Completado",
            content: task.completedAt!,
            fontSizeContent: fontSizeContent,
            labelHeight: labelHeight,
          )
      ],
    );
  }
}

class _LabelDate extends StatelessWidget {
  const _LabelDate({
    required this.width,
    required this.fontSizesitle,
    required this.fontSizeContent,
    required this.title,
    required this.content,
    this.labelHeight,
  });

  final double width;
  final double? fontSizesitle;
  final String title;
  final DateTime content;
  final double? fontSizeContent;
  final double? labelHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: labelHeight ?? 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          CustomText(
            text: title,
            color: ThemeColors.black.withOpacity(0.4),
            fontWeight: FontWeight.w400,
            fontSize: fontSizesitle ?? 14,
          ),
          CustomText(
            text: Formater.formatDateTime(content),
            fontSize: fontSizeContent ?? 14,
          )
        ],
      ),
    );
  }
}
