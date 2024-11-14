import 'package:taskapp/common/use_case/use_case.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/data/repository/task_repository.dart';

class UcGetTaskNoParams extends UseCaseNoParams<List<Task>> {
  final TaskRepository taskRepository;

  UcGetTaskNoParams({required this.taskRepository});
  @override
  Future<List<Task>> call() async {
    final List<Task> response = await taskRepository.getTasks();

    return response;
  }
}
