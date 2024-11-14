import 'dart:developer';

import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcUpdateTaskParams extends Params {
  final Task task;
  final int taskId;

  UcUpdateTaskParams({
    required this.task,
    required this.taskId,
  });
}

class UcUpdateTask extends UseCase<bool, UcUpdateTaskParams> {
  final TaskRepository taskRepository;

  UcUpdateTask({required this.taskRepository});
  @override
  Future<bool> call({UcUpdateTaskParams? params}) async {
    try {
      final bool response =
          await taskRepository.updateTask(params!.taskId, params.task);

      switch (response) {
        case true:
          return response;

        case false:
          throw UseCaseException("No pudo editar la tarea. Intente mas tarde");
        default:
          throw UseCaseException(
              "Hubo un error al momento de crear la tarea. Por favor contactar con el administrador.");
      }
    } catch (e) {
      log("Catch UpdateTask : ${e.toString()}");
      throw Exception();
    }
  }
}
