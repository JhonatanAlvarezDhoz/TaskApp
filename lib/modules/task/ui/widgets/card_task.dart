import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/ui/widgets/widgets.dart';
import 'package:taskapp/theme/theme_colors.dart';
import 'package:taskapp/utils/responsive.dart';

class CardTask extends StatelessWidget {
  const CardTask({
    super.key,
    required this.size,
    required this.task,
  });

  final Size size;
  final Task task;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: size.height * 0.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: responsive.widthResponsive(69),
                    child: CustomText(
                      text: task.title,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.primary,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconCheck(status: task.status)
                ],
              ),
              SizedBox(
                width: responsive.widthResponsive(69),
                child: CustomText(
                  text: task.description!,
                  fontSize: 16,
                  maxLines: 2,
                ),
              ),
              const Spacer(),
              const CustomDivider(marginTopAndbotom: 2),
              ShowDate(width: width, task: task)
            ],
          ));
    });
  }
}
