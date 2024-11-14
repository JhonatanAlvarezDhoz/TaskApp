part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTaskEvent extends TaskEvent {
  final GlobalKey<FormBuilderState> taskFormKey;

  const OnCreateTaskEvent({required this.taskFormKey});
}

class OnUpdateTaskEvent extends TaskEvent {
  final GlobalKey<FormBuilderState> taskFormKey;

  const OnUpdateTaskEvent({required this.taskFormKey});
}

class OnDeleteTaskEvent extends TaskEvent {
  final int taskId;

  const OnDeleteTaskEvent({required this.taskId});
}

class OnGetTaskEvent extends TaskEvent {}

class OnChangeStatusToPending extends TaskEvent {
  final int taskId;
  final String status;

  const OnChangeStatusToPending({required this.taskId, required this.status});
}

class OnChangeStatusToCompleted extends TaskEvent {
  final int taskId;
  final String status;

  const OnChangeStatusToCompleted({required this.taskId, required this.status});
}

class OnFilterTaskEvent extends TaskEvent {
  final String filterStatus;

  const OnFilterTaskEvent({required this.filterStatus});
}

class OnChangeFilterStatusEvent extends TaskEvent {
  final String filterStatus;

  const OnChangeFilterStatusEvent({required this.filterStatus});
}
