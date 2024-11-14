import 'dart:developer';

import 'package:isar/isar.dart';

import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcChangeStatusParams extends Params {
  final Id taskId;
  final String status;
  final DateTime? endDate;

  UcChangeStatusParams({
    required this.taskId,
    required this.status,
    required this.endDate,
  });
}

class UcChangeStatus extends UseCase<bool, UcChangeStatusParams> {
  final TaskRepository taskRepository;

  UcChangeStatus({required this.taskRepository});
  @override
  Future<bool> call({UcChangeStatusParams? params}) async {
    try {
      final bool response = await taskRepository.updateTaskStatus(
          params!.taskId, params.status, params.endDate);

      switch (response) {
        case true:
          return response;

        case false:
          throw Exception(
              "No pudo Actualizar el estado la tarea. Intente mas tarde");
        default:
          throw UseCaseException(
              "Hubo un error al momento de crear la tarea. Por favor contactar con el administrador.");
      }
    } catch (e) {
      log("Catch ChangeStatus : ${e.toString()}");
      throw Exception();
    }
  }
}
