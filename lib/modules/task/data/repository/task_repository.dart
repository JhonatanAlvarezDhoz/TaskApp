import 'package:isar/isar.dart';
import 'package:taskapp/modules/task/data/models/task.dart';

class TaskRepository {
  final Isar isar;

  TaskRepository(this.isar);

  Future<bool> createTask(Task task) async {
    return await isar.writeTxn(() async {
      final created = await isar.tasks.put(task);
      if (created <= 0) {
        return false;
      }
      return true;
    });
  }

  Future<List<Task>> getTasks() async {
    return await isar.tasks.where().findAll();
  }

  Future<bool> updateTask(int taskId, Task task) async {
    final taskToEdit = await isar.tasks.get(taskId);
    if (taskToEdit == null) {
      return false;
    }
    return await isar.writeTxn(() async {
      taskToEdit.title = task.title;
      taskToEdit.description = task.description;
      taskToEdit.status = task.status;
      taskToEdit.createdAt = task.createdAt;
      taskToEdit.completedAt = task.completedAt;
      final updated = await isar.tasks.put(taskToEdit);
      if (updated <= 0) {
        return throw Exception("No pudo editar la tarea. Intente mas tarde");
      }
      return true;
    });
  }

  Future<bool> updateTaskStatus(
      Id taskId, String status, DateTime? endDate) async {
    late bool wasUpdate;
    final task = await isar.tasks.get(taskId);

    if (task != null) {
      task.status = status;
      task.completedAt = endDate;
      final updatedState = await updateTask(taskId, task);

      if (!updatedState) {
        wasUpdate = updatedState;
        return false;
      }
      wasUpdate = updatedState;
    }
    return wasUpdate;
  }

  Future<bool> deleteTask(int taskId) async {
    return await isar.writeTxn(() async {
      final deleted = await isar.tasks.delete(taskId);
      if (!deleted) {
        return false;
      }
      return deleted;
    });
  }
}
