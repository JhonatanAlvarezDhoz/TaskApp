part of 'task_bloc.dart';

enum TaskStatus {
  initial,
  success,
  loading,
  error,
  created,
  updated,
  deleted,
  createdTicket,
}

class TaskState extends Equatable {
  final TaskStatus taskStatus;
  final List<Task> taskList;
  final String message;
  final String errorMessage;
  const TaskState({
    this.taskStatus = TaskStatus.initial,
    this.taskList = const [],
    this.message = "",
    this.errorMessage = "",
  });

  TaskState copyWith({
    TaskStatus? taskStatus,
    List<Task>? taskList,
    String? message,
    String? errorMessage,
  }) =>
      TaskState(
          taskStatus: taskStatus ?? this.taskStatus,
          taskList: taskList ?? this.taskList,
          message: message ?? this.message,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [taskStatus, taskList, message, errorMessage];
}
