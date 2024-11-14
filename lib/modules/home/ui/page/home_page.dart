import 'package:flutter/material.dart';

import 'package:taskapp/common/constants/data.dart';
import 'package:taskapp/common/constants/status_list.dart';
import 'package:taskapp/modules/home/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/theme/theme_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Task> tasks = data.map((task) => Task.fromJson(task)).toList();
    final statusList = StatusList.statusListFilter;

    return Scaffold(
      backgroundColor: ThemeColors.ligth,
      body: SizedBox(
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
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ItemTask(task: task, size: size);
                    })),
          ],
        ),
      ),
    );
  }
}
