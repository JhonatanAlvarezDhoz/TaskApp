// ignore_for_file: depend_on_referenced_packages

import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/modules/home/controller/home_bloc/home_bloc.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';
import 'package:taskapp/modules/task/data/usecase/usecase.dart';
import 'package:taskapp/services/isar_database.dart';

class Injector {
  static Future<List<SingleChildWidget>> dependencies() async {
    final isar = await IsarDatabase.instance;

    final taskRepository = TaskRepository(isar);

    return [
      BlocProvider(create: (_) => HomeBloc()),
      BlocProvider(
          create: (_) => TaskBloc(
                ucCreateTask: UcCreateTask(taskRepository: taskRepository),
                ucUpdateTask: UcUpdateTask(
                  taskRepository: taskRepository,
                ),
                ucDeleteTask: UcDeleteTask(taskRepository: taskRepository),
                ucChangeStatus: UcChangeStatus(taskRepository: taskRepository),
                ucGetTaskNoParams:
                    UcGetTaskNoParams(taskRepository: taskRepository),
              ))
    ];
  }
}
