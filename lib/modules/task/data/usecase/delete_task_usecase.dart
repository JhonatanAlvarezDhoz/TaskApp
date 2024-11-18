import 'dart:developer';

import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcDeleteTasksParams extends Params {
  final int taskId;

  UcDeleteTasksParams({required this.taskId});
}

class UcDeleteTask extends UseCase<bool, UcDeleteTasksParams> {
  final TaskRepository taskRepository;

  UcDeleteTask({required this.taskRepository});

  @override
  Future<bool> call({UcDeleteTasksParams? params}) async {
    try {
      final response = await taskRepository.deleteTask(params!.taskId);

      switch (response) {
        case true:
          return response;
        case false:
          log(response.toString());
          return throw Exception(
              "No pudo Eliminar la tarea. Intente mas tarde");
        default:
          throw "Hubo un error al momento de crear la tarea. Por favor contactar con el administrador.";
      }
    } catch (e) {
      log("Catch DeleteTask : ${e.toString()}");
      throw Exception();
    }
  }
}
