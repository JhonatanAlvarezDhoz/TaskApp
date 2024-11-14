import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';

import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/ui/widgets/card_task.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';

class ItemTask extends StatelessWidget {
  const ItemTask({
    super.key,
    required this.task,
    required this.size,
    this.onDelete,
  });

  final Task task;
  final Size size;
  final Function(DismissDirection)? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.taskDetail, arguments: task);
      },
      child: Dismissible(
          key: UniqueKey(),
          background: _DismisBackGound(),
          direction: DismissDirection.endToStart,
          onDismissed: onDelete,
          confirmDismiss: (direction) async {
            final confirmed = await showDialog(
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
                    onCancel: () => Navigator.of(context).pop(false),
                    onAction: () => Navigator.of(context).pop(true),
                  );
                });
            return confirmed;
          },
          child: FadeInLeftBig(child: CardTask(size: size, task: task))),
    );
  }
}

class _DismisBackGound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red.withOpacity(0.7),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Eliminado",
              color: ThemeColors.white,
              fontSize: 25,
            ),
            const Icon(
              Icons.delete_rounded,
              color: ThemeColors.white,
            )
          ],
        ),
      ),
    );
  }
}
