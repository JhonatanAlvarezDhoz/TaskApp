import 'dart:developer';

import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcCreateTaskParams extends Params {
  final Task task;

  UcCreateTaskParams({
    required this.task,
  });
}

class UcCreateTask extends UseCase<bool, UcCreateTaskParams> {
  final TaskRepository taskRepository;

  UcCreateTask({required this.taskRepository});
  @override
  Future<bool> call({UcCreateTaskParams? params}) async {
    try {
      final bool response = await taskRepository.createTask(params!.task);

      switch (response) {
        case true:
          return true;

        case false:
          throw UseCaseException("No pudo crear la tarea. Intente mas tarde");
        default:
          throw UseCaseException(
              "Hubo un error al momento de crear la tarea. Por favor contactar con el administrador.");
      }
    } catch (e) {
      log("Catch CreateTask : ${e.toString()}");
      throw Exception();
    }
  }
}
