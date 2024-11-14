import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return Container(
                padding: const EdgeInsets.only(left: 20, top: 7.2),
                height: size.height * 0.05,
                width: size.width * 0.81,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LabelButton(
                      size: size,
                      label: "Todas",
                      onTap: () {
                        taskBloc.add(const OnChangeFilterStatusEvent(
                            filterStatus: "Todas"));
                      },
                    ),
                    LabelButton(
                      size: size,
                      label: "Pendientes",
                      onTap: () {
                        taskBloc.add(const OnChangeFilterStatusEvent(
                            filterStatus: "Pendientes"));
                      },
                    ),
                    LabelButton(
                      size: size,
                      label: "Completadas",
                      onTap: () {
                        taskBloc.add(const OnChangeFilterStatusEvent(
                            filterStatus: "Completadas"));
                      },
                    )
                  ],
                ));
          },
        ),
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.createTask),
              icon: SvgPicture.asset(
                "assets/icons/add_task.svg",
                width: 50,
                colorFilter: const ColorFilter.mode(
                  ThemeColors.primary,
                  BlendMode.srcIn,
                ),
              )),
        )
      ],
    );
  }
}

class LabelButton extends StatelessWidget {
  const LabelButton({
    super.key,
    required this.size,
    required this.label,
    required this.onTap,
  });

  final Size size;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () => onTap(),
        child: Column(
          children: [
            CustomText(
              text: label,
              fontSize: 15,
              color: Colors.green,
            ),
            SizedBox(
                width: size.width * 0.2,
                child: const CustomDivider(marginTopAndbotom: 0))
          ],
        ));
  }
}
