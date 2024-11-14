import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/constants/app_size.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';

import 'package:taskapp/modules/home/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/theme/theme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(OnGetTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      backgroundColor: ThemeColors.ligth,
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: size.height * 0.16,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(size: size),
                        ActionBar(size: size),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: size.height - size.height * 0.22,
                    width: size.width,
                    child: state.taskList.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInDown(
                                  curve: Curves.bounceInOut,
                                  from: 400,
                                  child: SvgPicture.asset(
                                    "assets/icons/empty.svg",
                                    width: 150,
                                    colorFilter: const ColorFilter.mode(
                                      ThemeColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text:
                                      "Lo sentimos, pero aun no cuenta con tareas creadas o completadas",
                                  color: ThemeColors.primary,
                                  fontSize: 20,
                                  maxLines: 2,
                                ),
                                gapH12,
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text: "Agrega o completada algunas!!!",
                                  color: ThemeColors.primary,
                                  fontSize: 20,
                                  maxLines: 2,
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.taskList.length,
                            itemBuilder: (context, index) {
                              final task = state.taskList[index];
                              return ItemTask(
                                  task: task,
                                  size: size,
                                  onDelete: (direction) async {
                                    Future.delayed(
                                        const Duration(seconds: 1),
                                        () => taskBloc.add(OnDeleteTaskEvent(
                                            taskId: task.id)));
                                  });
                            })),
              ],
            ),
          );
        },
      ),
    );
  }
}
