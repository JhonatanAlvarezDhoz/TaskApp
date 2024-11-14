import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskapp/common/constants/status_list.dart';
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

    final statusList = StatusList.statusListFilter;
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
                        ActionBar(size: size, statusList: statusList),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: size.height - size.height * 0.22,
                    width: size.width,
                    child: ListView.builder(
                        itemCount: state.taskList.length,
                        itemBuilder: (context, index) {
                          final task = state.taskList[index];
                          return ItemTask(
                              task: task,
                              size: size,
                              onDelete: (direction) async {
                                Future.delayed(
                                    const Duration(seconds: 1),
                                    () => taskBloc.add(
                                        OnDeleteTaskEvent(taskId: task.id)));
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
