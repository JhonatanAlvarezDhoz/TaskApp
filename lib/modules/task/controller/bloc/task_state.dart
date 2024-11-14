part of 'task_bloc.dart';

enum TaskStatus {
  initial,
  success,
  loading,
  error,
  created,
  updated,
  deleted,
}

class TaskState extends Equatable {
  final TaskStatus taskStatus;
  final List<Task> taskList;
  final String filterStatus;
  final String message;
  final String errorMessage;
  const TaskState({
    this.taskStatus = TaskStatus.initial,
    this.taskList = const [],
    this.message = "",
    this.errorMessage = "",
    this.filterStatus = "Todas",
  });

  TaskState copyWith({
    TaskStatus? taskStatus,
    List<Task>? taskList,
    String? filterStatus,
    String? message,
    String? errorMessage,
  }) =>
      TaskState(
          taskStatus: taskStatus ?? this.taskStatus,
          taskList: taskList ?? this.taskList,
          filterStatus: filterStatus ?? this.filterStatus,
          message: message ?? this.message,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props =>
      [taskStatus, taskList, filterStatus, message, errorMessage];
}
