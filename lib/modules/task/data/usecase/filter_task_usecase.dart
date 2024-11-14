import 'dart:developer';

import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcFilterTaskParams extends Params {
  final String filterString;

  UcFilterTaskParams({
    required this.filterString,
  });
}

class UcFilterTask extends UseCase<List<Task>, UcFilterTaskParams> {
  final TaskRepository taskRepository;

  UcFilterTask({required this.taskRepository});
  @override
  Future<List<Task>> call({UcFilterTaskParams? params}) async {
    try {
      final List<Task> response =
          await taskRepository.getTasksByStatus(params!.filterString);

      switch (response.isNotEmpty) {
        case true:
          return response;

        case false:
          log(response.toString());
          return response;
        default:
          throw UseCaseException(
              "Hubo un error al momento de filtrar las la tarea. Por favor contactar con el administrador.");
      }
    } catch (e) {
      log("Catch UpdateTask : ${e.toString()}");
      throw Exception();
    }
  }
}
