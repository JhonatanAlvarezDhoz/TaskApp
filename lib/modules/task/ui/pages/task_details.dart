import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/constants/app_size.dart';

import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/ui/widgets/show_date.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Task task = ModalRoute.of(context)?.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.ligth,
        title: CustomText(
          text: "Detalles de tarea",
          fontSize: 18,
          color: ThemeColors.primary,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.updateTask, arguments: task);
              },
              icon: const Icon(Icons.edit_square))
        ],
      ),
      backgroundColor: ThemeColors.ligth,
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: size.height * 0.1,
              width: size.width,
              child: CustomText(
                text: task.title,
                fontSize: 25,
                color: ThemeColors.primary,
                fontWeight: FontWeight.w600,
                maxLines: 2,
              ),
            ),
            gapH12,
            SizedBox(
              height: size.height * 0.3,
              child: CustomText(
                text: task.description!,
                fontSize: 20,
                maxLines: 10,
                color: ThemeColors.black.withOpacity(0.6),
              ),
            ),
            LabelStatus(task: task),
            gapH32,
            ShowDate(
              width: size.width,
              task: task,
              margin: gapH12,
              fontSizesitle: 20,
              fontSizeContent: 20,
              labelHeight: 20,
            ),
            const Spacer(),
            if (task.completedAt == null)
              CustomButton(
                buttonSize: Size(size.width * 0.9, 50),
                color: ThemeColors.primary,
                elevation: 1,
                textSize: 18,
                textWeight: FontWeight.w500,
                textColor: ThemeColors.white,
                text: "Finalizar Tarea",
                borderRadius: BorderRadius.circular(10),
                onPressed: () {},
              ),
            gapH12,
            CustomButton(
              buttonSize: Size(size.width * 0.9, 50),
              color: Colors.red.withOpacity(0.6),
              elevation: 1,
              textSize: 18,
              textWeight: FontWeight.w500,
              textColor: ThemeColors.white,
              text: "Eliminar Tarea",
              borderRadius: BorderRadius.circular(10),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                          icon: SvgPicture.asset(
                            "assets/icons/delete.svg",
                            width: 50,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.srcIn,
                            ),
                          ),
                          titleText: "Eliminar Tarea",
                          question:
                              "Upss!! Estas seguro que deseas Eliminar esta tarea?",
                          textConfirmation: "Si es asi, confirma",
                          onCancel: () => Navigator.of(context).pop(),
                          onAction: () {});
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LabelStatus extends StatelessWidget {
  const LabelStatus({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: "Estado: ",
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: ThemeColors.black.withOpacity(0.6),
        ),
        const Spacer(),
        CustomText(
          text: task.status,
          fontSize: 24,
          color: task.status == "completed"
              ? Colors.green.withOpacity(0.7)
              : ThemeColors.tertiary,
        ),
        gapW12,
        IconCheck(status: task.status),
        gapW24,
      ],
    );
  }
}
